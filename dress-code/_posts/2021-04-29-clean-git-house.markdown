---
layout: post
title: Clean Git House
date: "2021-04-29T12:41:27-04:00"
---

> This guide is about deleting branches in Git. There's a few ways I break down
> how to do it from manual effort to maximum automation and every step explained
> in between. To skip that and get to the good stuff, [click here][tldr].

[tldr]: {% post_url /dress-code/2021-04-29-clean-git-house %}#automating-and-aliasing

Deleting branches in Git can be confusing and at times harrowing for folks
getting started. The distributed nature of Git allows for remotes to have copies
of branches and your local machine to have copies of branches. Over time, you
can create a large number of branches that exist in both places. If you delete
your remote branches outside of your Git repository, such as on GitHub, then you
still need to delete them from your local repository. And, you can delete local
branches, but that doesn't actually delete them from the remote repository.

Git has some features that easily allow you to do either of these activities
easily. To really clean house though, you need to combine these commands to
delete your local and remote stale branches from your local Git repository.

## Deleting local branches

There are a lot of ways to delete local branches for Git. One of the more
popular ways is to delete them each on by one running the delete flag on the
branch command.

```sh

git branch --delete ${local_branch_name}
```

When you do this with the `-d, --delete` flag, it'll delete the branch you
choose. The command will give you an error if you attempt to delete a branch
that hasn't been merged upstream or if its commits aren't currently in your
`HEAD`. If you want to go ahead and delete the branch regardless, you run the
`-D` flag which is a shortcut for `--delete --force`.

```sh

git branch --delete --force ${local_branch_name}
```

## Deleting remote branches

There's a couple of ways to delete remote branches. If you're using GitHub, you
can do it from the `/branches` endpoint on your GitHub repository and delete
any branches from there. Also, you can set your branches to automatically delete
branches from the **Options** section of the `/settings` endpoint on your GitHub
repository.

On the command-line, you can delete branches by pushing nothing to the branch on
your repository.


```sh

git push origin :${branch_name}
                ^ # the empty space in front of the colon is the nothing you
                  # are pushing to the ${branch_name}.
```

This will cause the remote branch to be deleted. Combining this with the local
way of deleting branches allows you to keep your output from `git branch --all`
neat and tidy.

### Deleting by pruning stale remote branches

For the sake of this post, a stale remote branch is a branch that has been
deleted from your remote repository and your local repository still thinks it
exists when you run `git branch --remote`. Git has a pretty straight forward way
of deleting these stale branches by pruning them.

```sh

git remote prune ${remote_name}
                 ^ # this is usually `origin` but you can name remotes whatever
                   # you'd like to name them.
```

Helpfully, there isn't an equivalent command that takes into account local and
remote branch relationships and deletes the local branches that your local
repository doesn't know about.

The main reason for this is that a command like that would be dangerous to any
local work that you've done on a local branch that you haven't pushed up yet.
After all, local branches are usually the beginning of new work on a repository
and remote branches are considered already distributed across clones of the
repository. It should be easy to delete these remote branches locally, but
deleting local branches based on the non-existence of a remote branch is a
tricky thing to do that could potentially cause you to lose your local work.

## So let's build something

So even though it doesn't ship with Git, you can pipe together various commands
to get Git to do this local branch pruning based on what remote branches don't
exist on the repository but do exist in your local repository.

```sh

git branch -r | \
  awk '{print $1}' | \
  egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | \
  awk '{print $1}' | \
  xargs git branch -d
```

### Breaking down the Bash

Now there's quite a lot to this command. I've broken it down into multiple lines
for legibility, but it is still running 7 separate commands in two separate
shells. It's a lot, so I'm going to break it down further.

#### Fetch remote branches

This command gets all the remote branches from all your remotes. For the sake of
these examples, let's assume the remote is name `origin` as that's the default.

```sh

git branch --remote
```

#### Get the first column of output

This command leverages `awk` to print out the first column of output from the
previous command. In this case, it outputs the names of all the remote branches
with `origin/` in front of them. e.g. `origin/main`.

```sh

awk '{print $1}'
```

#### Grep the remote branch list for local branch names

This command leverages `egrep` with flags of `-v` and `-f`. The `-v,
--invert-match` flag is used to exclude any remote branches from the list of
local branches. The list of local branches is being redirected into a file
called `/dev/fd/0`. [The explanation of this is a bit out-of-scope for this
post][exp-devfd], but essentially it's allowing `egrep` to read from `STDIN`.

This command outputs an inverted match of remote branches comparing them to a
list of your local branches. Because the match is inverted, it means that the
names of the branches that are matched locally don't exist in the list of remote
branches.

```sh

egrep -v -f /dev/fd/0 <(git branch -vv | grep origin)
```

[exp-devfd]: https://www.informit.com/articles/article.aspx?p=99706&seqNum=15 "Advanced Programming in the UNIX® Environment: UNIX File I/O"

#### Get the first column of output again

This command leverages `awk` to print out the first column of output from the
previous command. In this case, it outputs the full-name of the local branch.

```sh

awk '{print $1}'
```

#### Leverage `xargs` to run git commands

This command leverages `xargs` which takes a string that's broken up by
delimiters such as spaces or newlines and runs the command passed into it. This
command runs the `git branch --delete` on the output of the previous command
which is a newline delimited string of all the local branches that don't exist
on the remote repository.

```sh

xargs git branch --delete
```

## Automating and aliasing

So I don't like to have to remember all these steps when running this locally.
There's quite a few things you'd need to remember such as pruning the remote
branches first, then running the 7 commands in the right order and piping the
output of one into the next.

To make this easier, let's create a named function which takes an argument of
the remote name for your Git repository and iterates through all the steps I
previously mentioned. It looks like this.

```sh

limpia-git() {
  remote_name="${1:-origin}"
  if [ -d $(pwd)/.git ]
  then
    git remote prune $remote_name

    git branch -r | \
    awk '{print $1}' | \
    egrep -v -f /dev/fd/0 <(git branch -vv | grep ${remote_name}) | \
    awk '{print $1}' | \
    xargs git branch -d

  else
    echo "There's not \".git/\" directory in \"$(pwd)\"."
  fi
}
```

Finally with all this setup in a file that you source into your shell session,
you can simply run `limpia-git` or `limpia-git origin` and have it clean up all
your stale local and remote branches. And because of the `egrep` matching and
the `git remote prune ${remote_name}` commands, this is a no-op when there
aren't branches to delete or stale local branches to delete.

Also, to be extra careful, the `git branch --delete` command will check if your
commits have been merged into the `HEAD` of any of your remote branches and won't
delete local branches that aren't merged yet. You can remove this safety net by
changing the command to `git branch --delete --force`.
