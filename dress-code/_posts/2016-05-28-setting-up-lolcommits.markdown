---
layout: post
title: "Setting up lolcommits"
date: "2016-05-13 23:00:29 -0400"
---

## Getting started

> This guide makes some assumptions that you're using the terminal to run the
> following commands, and that you're using Mac hardware and software.

Installing `lolcommits` is pretty easy via Ruby Gems. If you've got the `gem`
command on your computer, you can simply run the following command.

{% highlight sh %}
gem install lolcommits
# If you've got permission errors, `sudo` like you mean it ( ie: `sudo !!` )
{% endhighlight %}

After it installs, you can make sure it's available by running `lolcommits`.

{% highlight shell %}
❯❯❯❯❯❯❯ lolcommits
Do what exactly?
Try: lolcommits --enable   (when in a git repository)
Or:  lolcommits --help
{% endhighlight %}

Great. Now that the binary is installed and in your `$PATH`, we can focus on
customizing it. I personally use it to post everything I commit as a photo to a
[Tumblr I made specifically][roger-is-working] to [cope with the dehumanizing
aspects of working with computers][humanizing-computer-work].

[roger-is-working]: http://rogerisworking.tumblr.com/ "Roger Is Working"
[humanizing-computer-work]: {{ site.baseurl }}/writing/humanizing-computer-work.html "Humanizing computer work"

### Initializing teh lulz

To get started you can run `lolcommits --enable` within any git repository you'd
like. This does a few things which __are pretty destructive__ if you use the
`post-commit` hook. So make sure you back it up.

{% highlight shell %}
cp .git/hooks/post-commit .git/hooks/post-commit.bak
{% endhighlight %}

Now you can safely run `lolcommits --enable`.

{% highlight shell %}
❯❯❯❯❯❯❯ lolcommits --enable
installed lolcommit hook to:
  -> $HOME/Developer/<REPO>/.git/hooks/post-commit
(to remove later, you can use: lolcommits --disable)
{% endhighlight %}

Which will give you the following output inside of `.git/hooks/post-commit`.

{% highlight shell %}
❯❯❯❯❯❯❯ cat .git/hooks/post-commit
#!/bin/sh
### lolcommits hook (begin) ###
if [ ! -d "$GIT_DIR/rebase-merge" ]; then
export LANG="en_US.UTF-8"
export PATH="$HOME/.rvm/rubies/ruby-2.2.2/bin:/usr/local/bin:$PATH"
lolcommits --capture
fi
###  lolcommits hook (end)  ###
{% endhighlight %}

### Customizing teh lulz

Now that we've got the hook installed, you can make your first commit and see
what it's all about. You'll notice on the `post-commit` file that line 6 is just
a call to `lolcommits --capture`. This is what takes the commit. It accepts some
flags to customize your experience. Feel free to play around with them.

{% highlight shell %}
❯❯❯❯❯❯❯ lolcommits --help
Usage: lolcommits [-vedclbscpsmwga]
    # shortened for emphasis & brevity
    -c, --capture                    capture lolcommit based on last git commit
    -w, --delay=SECONDS              delay taking of the snapshot by n seconds
        --stealth                    capture image in stealth mode
    -a, --animate=SECONDS            enable animated gif captures with duration (seconds)
        --fork                       fork the lolcommits run
{% endhighlight %}

Once you run the `--capture` command within a repo with commits, you can see
your lolcommit image by running `lolcommits --browse`. This will open the
`Finder.app` to the folder containing all the lulz. It's useful to keep this
open as you tweak your `lolcommits --capture **` command so you can preview your
changes.

Here's the command I use to capture my lovely commits

{% highlight shell %}
lolcommits --capture --fork --stealth --delay=3 --animate=5
{% endhighlight %}

I find that `--fork` tends to allow me to quickly capture commits while
`--stealth` just helps me forget it's taking a picture. Even though the green
light will still turn on. The `--delay=3` is great so that the iSight camera can
focus on you. Finally, `--animate=5` is what gives me `*.gif` files that I can
later upload to Tumblr. This means I don't get any `*.jpg` files. I personally
don't mind losing them, but if you want you can always run the command twice
once without the `--animate=*` flag.

### Configuring teh lulz

There are [quite a few plugins][lol-plugins] available for `lolcommits` that do
all sorts of fancy things. The one I like to use is the Tumblr one, since I
don't want to worry about hosting.

To configure Tumblr, ...

### Automating teh lulz

Once you've gotten a single repository enabled and tweaked to your liking, you
might want to ensure that all of your newly cloned repositories and old
repositories are using `lolcommits` to capture your beautiful selfie. This can
be very time consuming as you'd need to run `lolcommits --enable` within each
repository _and then_ copy over the `config.yml` file into that new folder
within `$HOME/.lolcommits`. Or you could automate it.

> ... Talk about `.git_templates/hooks/post-commit` ...

Useful command for sharing `config.yml` files between repositories. You can make
it an alias that you can run within the repository after `lolcommits` has been
enabled.

{% highlight shell %}
cp -v $HOME/.lolcommits/config.yml $HOME/.lolcommits/`echo "${PWD##*/}"`/config.yml
{% endhighlight %}
