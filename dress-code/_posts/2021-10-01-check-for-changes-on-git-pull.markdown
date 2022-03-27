---
layout: post
title: Check for changes on git pull
date: "2021-10-01T00:00:00-05:00"
---

Working on large projects with people means that you're going to be
collaborating asynchronously a lot. Even with the best intentions, it can be
difficult to track what's changed after pulling code down from your Git
repository. Things like keeping dependencies up to date and running local
database migrations are examples of possible slippage that can lead to developer
confusion or friction. But other times, you may just need a reminder that some
internal documentation has changed and that folks show read it.

It's really helpful that whenever you do a `git pull`, you are given a list of
files that change. But if you're not paying attention or that list of changes is
too long, you can get lost and forget to run certain things on your local
machine. 

With a `post-merge` Git hook, you can run an arbitrary number of commands
whenever certain files or directories change. These examples only run `echo`
commands as it could be intrusive to run code on other's machines, but it's easy
enough to run a command rather than only suggest running a command if you'd
like. After all, the `post-merge` hook is a local Bash script.

## Anatomy of a post-merge hook

Below is an example of a Git hook that is saved as an executable file in your
project's `.git/hooks/post-merge` file. This one is written using Bash, but feel
free to tweak things

```sh

cat .git/hooks/post-merge
```

```sh

#!/usr/bin/env bash

set -eo pipefail

function changed {
  local chg_str=$1
  git diff --name-only 'HEAD@{1}' HEAD | grep "^${chg_str}" > /dev/null 2>&1
}

if changed 'migrations/'; then
  echo
  echo "🗄️ The migrations/ directory has changed. You may want to run \`make db_dev_migrate\`."
fi
```

The first think you'll notice is that we have a function called `changed` which
takes a single argument and uses that to search using `grep` through the output
of `git diff` with some flags and options. Let's break those down to make sure
we understand what's going on.

### Running a diff between the last pull and HEAD

For a more up-to-date and thorough explanation of the following `git diff`
command, please read the official Git documentation on
[`git-diff`][git-diff-docs] and [`git-rev-parse`][git-rev-parse]. Those docs
will be more current and may be better at explaining things that my summary.

[git-diff-docs]: https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---name-only
[git-rev-parse]: https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt-emltrefnamegtltngtemegemmaster1em
When you run `git diff` with the `--name-only` flag, you're asking for just the
file names for any files that were changed. After `--name-only`, we are passing
the two `<refname>` that we want to compare. In this case, it's `'HEAD@{1}'` and
`HEAD` respectively. The `@{1}` means the previous value of `HEAD` that existed
before the `git pull` took place. That particular `<refname>` is also quoted in
single-quotes to prevent issues with the `@` at-sign and `{}` braces.

### Checking for changes

With a `changed` function, we're able to write `if-statements` with simple
`strings` to check for the existence of a file's path at the beginning. This is
mostly useful for checking directories. But the `changed` function can be
changed to allow for checks of any of the output from the `git-diff` command.

## Anatomy of a changed if-statement

Like I said above, the string that's passed in as an argument for `changed` is
grepping for a value that starts the string. Notice the `^` in the `changed`
function above. This means that checking for files or paths means that we will
need to include the full path and not just any part of a file or directory.

The reason for this is important, but I won't go into it here. Take a look at
what the `git-diff` command outputs after you've done a `git-pull` to better
understand this. I will say that it's always better to be specific rather than
general when checking for things. If that's enough reason, then just keep that
in mind.

Now the example above shows that we're checking for a `mirgations/` directory to
have changes in it. But we can easily add other `if-statements` to check for
other common files or directories that have changed.

### Check for changes in the _docs/adrs_ directory.

```sh
if changed 'docs/adrs/'; then
  echo
  echo "📄 The docs/adrs directory has changed. Please review any ADR changes."
fi

```

### Check for changes of the _package.json_ file.
```sh
# if changed 'package.json'; then
  echo
  echo "🧰 The contents of package.json has changed. Run \`npm install\` or \`yarn\` to update your local dependencies."
end
```

The options here are limited only by the files or directories that are changing in your repository. 
