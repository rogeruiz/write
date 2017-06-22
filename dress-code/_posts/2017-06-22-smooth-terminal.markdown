---
layout: post
title: "Smooth Terminal"
date: "2017-06-22 00:19:00 -0400"
---

## Getting started

> _What you need to have set up to understand this._

This guide is a breakdown of my technical assessment and process in picking my
terminal setup. I tweak it regularly, but as layered as it is, I tend to make
cosmetic changes like presentation or data. This leaves the heavy-handed stuff
to things that are only done

### Use a framework, so you don't have to think of everything

I use oh-my-zsh because it's dope. But you don't have to. The idea here is for
the shell framework to help you not have to think about some basic things that
can get displayed on the PS1 prompt. It's also super common for shell frameworks
to come with themes that you can leverage instead of customizing the PS1
completely on your own.

### Pick a good theme and scheme

Look through various color schemes and find something that's easy on your eyes.
I have switched between light and dark styles, but eventually settled on just
using dark styles so make things less complicated. It's still bright, but it
does discourage me to work in direct sunlight. If you're outside in the sun with
a computer it shouldn't be to work on it, but to treat it like a contemporary
boombox.

### Working with NerdFonts Patcher

Use this and install all the bits. It's a load of work, so maybe just pick
something that's already patched. I didn't. I didn't because the particular font
weight I use wasn't officially supported. I'm very particular so I patched a
version of the font and modified iTerm to leverage both fonts depending on what
it was rendering. It's great since I can set the width of the characters
separately from one another.

### Modify that theme you like to make it your own

Now with a patched font file, and your terminal app set up to handle the
glorious power of patched fonts, you can start bringing in some of the
iconography from NerdFonts. It can be as a small change like adding a
single character. Or you can go mad and create an entire world based on the
places you use everyday.

### Treat your PS1 like Jon Ivy treats the Touch Bar

Consider what's important for you everything you're on your computer mashing on
tactile keys rapping commands, codes, and comments. I like to make sure I have
as much information on display at any given time. It's a good place to let out
your creative side and it helps to understand typographic emphasis. And since
you've patched your favorite font with icons, you should be good to
