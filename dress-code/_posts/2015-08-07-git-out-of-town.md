---
layout: post
title: "Git Out of Town"
date: "2015-16-07 16:00:00 -0400"
---

Depending on how experienced you are with Git, you've either run into problems
that we very scary or problems that were downright terrifying. The upper limit
of the `scale of fear` is something that is mostly determined by whether your
changes affect a remote or just your local machine compounded by whether or not
you understand the difference.

>
One thing for certain is that when you run anything with the word `push` and
it's immediately followed by the word `delete` you're contemplating why you
didn't choose to have more brown furniture in your life.

### Go complete yourself

I recently ran into that `scale of fear` when I let Git's auto-completion take
over while my mind was on autopilot because I was autonomous, meaning I was
working a bit later than I should have been.

__The command I ran was:__

```

❯ git push --mirror # oh no!

```

__When I was trying to run:__

```

❯ git push --no-verify # some times I feel like letting the CI handle my bidness

```

Well, my muscle memory kicked in and before my mind could tell what I had done,
I started seeing the scariest output I wanted to see at 2:30 AM.

```

Roger Steve Ruiz deleted branch dev/not-on-my-local at current / project
Roger Steve Ruiz deleted branch dev/another-one-not-on-my-local at current / project
Roger Steve Ruiz deleted branch dev/another-devs-latest-work at current / project
Roger Steve Ruiz deleted branch master at current / project
Roger Steve Ruiz deleted branch yet-another-one at current / project

```

Crap. Oh, crap.

