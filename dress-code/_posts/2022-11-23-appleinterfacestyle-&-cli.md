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

Here’s an excerpt from the original authors.

> Expect the output of every program to become the input to another, as yet unknown, program. Don’t clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don’t insist on interactive input.
> 
> *from Ken Thompson and Dennis Ritchie, key proponents of the Unix philosophy*

Now the Unix philosophy is thrown around a lot. I recommend reading it every now and then. It’s historic information and the perspective gained from rereading it is super helpful. I’ve also learned that not many people are aware of the Unix philosophy by name. So I hope showing you how using macOS Night mode to trigger theme changes across multiple tools at once helps enforce parts of the Unix philosophy in modern times.

## The visual problem

When I’m on the computer, I tend to work in Dark themes in my editor and terminal. For me, these are the same things and expand further to tools like my multiplexer, command prompt framework, and TUI. The problems I experience are whenever I work outside during daylight hours it is almost impossible to work outside. My monitor on my laptop is glossy and turns into a reflective surface when my Dark themes are activated. 

> %Show my dark theme

I use a lot of tools that subscribe to the Unix philosophy to varying degrees. For a Terminal I’ve used [iTerm2][iterm2] for almost a decade but I just switched to Alacritty. I recently switched from OhMyZSH to Starship for my command prompt. I used to use Vim but made the big leap to learn Lua and Neovim earlier this year. I’ve also made a big switch to Rust-based tools like Bat to get a different visual user experience compared to Cat. 
[iterm2]: https://iterm2.com/
