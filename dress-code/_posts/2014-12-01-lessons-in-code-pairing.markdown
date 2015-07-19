---
layout: post
title: "Lessons in Code Pairing"
date: "2014-12-01 23:00:29 -0400"
---

If you use Sublime Text as your editor, you may have mucked around with your
user preferences. As someone who loves to customize my tools, I have all sort of
packages installed along with global and syntax-specific preferences.

My editor and terminal are places where I spend most of my time while working on
my computer. That's why I think it's important for me to feel like these places
are extensions of my personality. Because of this I've also put my preferences
in source control as well. So that I don't end losing parts of my personality.

Where your user preferences live (on a Mac):

{% highlight sh %}
# If you use st2
$ cd $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User

# If you use st3
$ cd $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
{% endhighlight %}

Once you've navigated to this folder in the terminal, you can just run the
following command within that directory to get started.

{% highlight sh %}
$ git init
{% endhighlight %}

Since this is your first time using git with your sublime settings, you can just
commit everything in there using:

{% highlight sh %}
$ git add . && git commit -m "Initial commit"
{% endhighlight %}

Now that you've set your settings are under version control, you can go ahead
and start updating them and committing your changes along the way.

Here's a link to mine on Github. Be wary of putting yours in a public place if
you're using the Gist plugin for Sublime. It stores your Github Token and
shouldn't be versioned. This advice goes for any sublime-plugin that stores
personal data or information you don't want public.

## Okay so now that everything's in git, what's the point?

So now that everything is in version control, you can start setting up different
"environments" for your editor. This is particularly useful if you do "extreme
programming", which I highly recommend you look into.

One of the best things to do when pairing up is to make sure that your editor is
easy to read. While dark editor themes may be good for you to use when working
alone, I have found that it's easier to read light editor themes from far away.
Another important thing to account for when more than one pair of eyes is looking
at code is font size. I like to personally use a font size of 15px, but when pairing
I bump it up all the way to 22px.

Now that your preferences are under version control, switching your editor is
simple. Just make a branch with the updated changes. And you've created an
"environment" for you to easily switch to and from when code-pairing.

![Switching branches from code-review to master](/img/dress-code/code-pairing.gif)

> tl;dr: Control your environment by using version control.
