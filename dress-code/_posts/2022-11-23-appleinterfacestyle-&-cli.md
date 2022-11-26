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

## The configuration problem 

My most used terminal throughout the years has been iTerm2. I love the customization and the attention to detail you find in the configuration. It’s a Mac-first application and does a good job of maintaining the HIG or allowing users to customize it further on their own. It’s all accessible with a very intuitive UI-based settings page. Configurations can even be exported and imported to XML files to make sharing them easy.

> %Show the iTerm2 settings page
## Text-based configurations are better than proprietary ones

Most of the tools I use every day use text based configuration files such as customized `.conf` files or Yaml or TOML files too. This is also super helpful to me to be able to back these things up. 

Even though iTerm2 allows for exports and imports of configuration, the interface isn’t text-first. It’s visual first. Which is great if that’s what you’re in to.

> Write programs to handle text streams, because that is a universal interface.
>
> *by Peter H. Salus in A Quarter-Century of Unix (1994)*

### I had to stop using iTerm2 and start using Alacritty

While I’ve used iTerm2 for so long, I did run in to various limitations. They were mostly around configuration management. There were times where I would make an update and I would have close and open the window for it to take effect. Other times, I would have to manually enter my theme and tweak my configuration using the UI editor. While all this worked for me for years, I needed to try something better. I switched to Alacritty and haven’t looked back. While it’s not as feature-rich as iTerm2 if you’re looking for lots of features, it does have a text-based configuration written in Yaml that updates the terminal on save.

[➡️ Checkout my Alacritty configuration](https://git.sr.ht/~rogeruiz/.files/tree/main/item/alacritty/alacritty.yml)

The Alacritty project has stated publicly that they’re looking to only recreate the terminal emulation experience and nothing else. That’s okay for me as I use Tmux to modify my terminal experience. But as usual, your mileage may vary. Explore your options. If Alacritty interests you then please keep reading. 