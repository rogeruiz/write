---
layout: post
title: AppleInterfaceStyle & CLI
date: "2022-11-23T02:59:08-05:00"
---

> `tl;dr` macOS-based Night mode supported scripting to modify the configuration across multiple development environment tools including: [Alacritty][alacritty], [Tmux][tmux], [Neovim][neovim], [Starship][starship], and [Bat][bat].
>
> [🔗 code](https://git.sr.ht/~rogeruiz/.files/tree/main/item/bin/darwin/current_visual_mode)

[alacritty]: https://alacritty.org/
[tmux]: https://github.com/tmux/tmux/wiki
[neovim]: https://neovim.io/
[starship]: https://starship.rs/
[bat]: https://github.com/sharkdp/bat

This post has been cooking for a long time. The ability to switch between visual modes across all my tooling always felt like an attainable goal but for years it was outside of my periphery because my main tools were not Unix philosophy aligned. 

> Expect the output of every program to become the input to another, as yet unknown, program. Don’t clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don’t insist on interactive input.
> 
> *from Ken Thompson and Dennis Ritchie, key proponents of the Unix philosophy*

Now the Unix philosophy is thrown around a lot. I recommend reading it every now and then. It’s historic information and the perspective gained from is very is super helpful.
