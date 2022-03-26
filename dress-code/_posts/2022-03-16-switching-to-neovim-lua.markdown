---
layout: post
title: Switching to Neovim & Lua
date: "2022-03-16T20:17:27-04:00"
---

## Long time Vim user migrates to Neovim

Less than a year ago, I migrated to Neovim from Vim because others where I
worked were doing it. Also, I was growing frustrated with how slow my Vim setup
was getting and thought that Neovim would solve a lot of those problems for me.
And the transition did! It was mostly painless to switch to Neovim from Vim. I
had to change my package manager for consistency with some of the documentation
and needed to tweak a small number of configurations because now I was using CoC
for my LSP support. This was happening at a time where I wasn't super aware of
the LSP support that was incoming to Neovim natively in Lua.

## Switching to using Neovim and Lua

So I have not touched the architecture of my Vim setup in a while. I set it up
once thanks to [the helpful guidance of Steve Francia and a guide that he made
called _The Ultimate Vim Distribution_][sf-vim-distro] and have not looked back
at it since. Certainly, I've added a lot since I started using Vim as my daily
text editor. I've even moved over to using Neovim full-time too. My personal
machines don't even have Vim installed on it. It's Neovim for me all the way.
But, I did notice that there was a significant amount of slow down on my machine
most likely due to the bloat over almost eight years of using Vim full-time at
this point. 

[sf-vim-distro]: http://vim.spf13.com

So I started looking into disabling certain plugins or disabling certain
features in my Tmux configuration to make things run smoother. But then, I
started thinking about the problem a different way. What if my Vim configuration
and Vimscript-based LSP was slowing me down? So I did some digging on how to
configure Neovim with a preference for Lua-based plugins rather than
Vimscript-based plugins.

The reasoning behind using Lua-based plugins is that they should be a lot
faster. According to [the motivation for Neovim][nvim-intro], Neovim is a much
better more current version of Vim written in Lua. Because of this, I assumed
that Lua-based Neovim plugins are faster than Vimscript-based plugins.

[nvim-intro]: https://github.com/neovim/neovim/wiki/Introduction#motivation

### I wouldn't have been able to do this without the community

I'm thankful for the Neovim community for self-documenting configurations and
plugins so that's easier to understand and tweak these things. I have
developed a lot of muscle memory around my use of Vim. The following links
helped me a lot, [Heiker Curiel's Lua-based configuration guide for
Neovim][heiker-curiel-nvim-config] and [Chris@Machine's YouTube playlist for
setting up Neovim from scratch][chris@machine-yt-playlist].

[heiker-curiel-nvim-config]: https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
[chris@machine-yt-playlist]: https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ

## This was a lot harder than I thought

I didn't realize that I would need to learn Lua before I could get my Neovim up
and running. This is clearly a lack of foresight on my part. I was really
assuming that I would be mostly copying and pasting configuration pieces around.
But what I hadn't thought about is that the Neovim configuration community is
very opinionated and that it's still not as mature as the Vim community. A lot
of the documentation that I encountered was either making a lot of assumptions
of the reader or was just incorrect/missing/confusing for any number of reasons.

### Not really a bad thing though

This isn't really a bad thing though. I just don't think that the path I took of
configuring Neovim is for everyone. There are a lot of super helpful guides on
how to set this stuff up and a lot of them are opinionated enough to be useful
for most use-cases out of the box. The issues I ran into are unique to me and
  don't really speak to the authors of the plugins I am using. 

If you're the kind of person who is doesn't yet have a lot of muscle memory
around how you will work with Neovim, starting from scratch will be super
helpful.

## Giving back

To give back to the Neovim community, I'll be starting a short series of posts
which will talk about how I tied together a lot of my own Neovim configuration.
Hopefully this helps others including future me.

[For now, you can view my Neovim configuration in my Dotfiles
repository][gh-dotfiles].

[gh-dotfiles]: https://github.com/rogeruiz/.files/tree/main/nvim
