---
layout: post
title: "Smooth Terminal"
date: "2017-06-22 00:19:00 -0400"
---

## Getting started

> This guide is more of a review of the decisions that went into my [`Prompt String 1` (PS1)][ps1-faq].
> Your mileage may vary, but remember to have fun and create the PS1 you want to see in the world.

[ps1-faq]: http://www.linuxnix.com/linuxunix-shell-ps1-prompt-explained-in-detail/

I really really really spend a lot of time in a terminal. I got hooked all the
way back in my MS-DOS days with the idea that I could write a set of
instructions and have the machine act them out repeatedly for me. The fact that
so much can be automated in a shell with an incredibly small amount of code is
one of my favorite aspects of using it. There's also the added benefit of
intent, or friction depending on what you're doing, that using only a keyboard
facilitates when working in high-risk environments. Mice and touch are nice
modernities of contemporary computer life, but it's nice to feel like you're
back in the 80s and 90s logged into a computer somewhere else. It's also really
great to seamlessly continue working the same way you're used to working when
you have to context-switch onto another machine.

I'm going to walk you through my terminal setup and how it came to fruition. It's
something I modify consistently whenever I introduce a new workflow or metric
into what I do every day. Sometimes they're cosmetic like adding [font
icons][rogeruiz/fonts] everywhere and other times they're foundational like when
I wrote a [time-tracking tool][rogeruiz/tick] to move away from a NodeJS
implementation because I thought it was too slow for my taste.

[rogeruiz/fonts]: https://github.com/rogeruiz/.files/tree/master/fonts
[rogeruiz/tick]: https://github.com/rogeruiz/tick

### Use a framework, so you don't have to think of everything

I use [oh-my-zsh][oh-my-zsh] because it's dope. But there are [other
frameworks][bash-it] out there for [other shells][oh-my-fish] as well. The idea
here is for the shell framework to help you not have to think about some basic
things that can get displayed on the PS1 prompt. It's also super common for
shell frameworks to come with themes that you can leverage instead of
customizing the PS1 completely on your own. This is important because the PS1
prompt can be really difficult to modify and can cause you to give up. You
should take all the help in the world and find a good thing that
works for you to put in your terminal after you tweak it a bit. I believe in you.

[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[bash-it]: https://github.com/Bash-it/bash-it
[oh-my-fish]: https://github.com/oh-my-fish/oh-my-fish

### Pick a good theme, scheme, and font

#### PS1 theme

The theme I use is [real][real-theme], a modified version of [pure][pure-theme],
for ZSH. I really like how _pure_ is simple and fast. I modified it to go against
everything that _pure_ stands for and cluttered the ever-living pixels out of my
PS1 using my own custom font. I'm a visual person and I like having little
iconography everywhere I go especially since I never leave the terminal.

[real-theme]: https://github.com/rogeruiz/.files/blob/master/oh-my-zsh/custom/real.zsh-theme
[pure-theme]: https://github.com/sindresorhus/pure

#### Color scheme

This part was really important for me. I use [Hopscotch][hopscotch-theme]. It's
a color scheme based on an [iOS app][hopscotch-app] which is for teaching kids
how to code. I chose it because I wanted to remind myself that I want to teach
my children how to code. It's also purple and I love the color purple. And if
my kids ultimately decide that programming isn't a thing they're interested in
then at least I have my purple color scheme and it's the thought that counts
anyway.

![Hopscotch in my terminal]({{ site.url }}/img/dress-code/hopscotch-terminal.png)

[hopscotch-theme]: http://tmtheme-editor.herokuapp.com/#!/editor/theme/Hopscotch
[hopscotch-app]: https://www.gethopscotch.com

I have switched between light and dark styles, but eventually settled on just
using dark styles to make things less complicated. It's still bright, but it
does discourage me to work in direct sunlight. If you're outside in the sun with
a computer it shouldn't be to work on it, but to treat it like today's NYC 1980s
boombox. Put that thing on your shoulder and drop the beat.

There's this great [Textmate Theme Editor][tmtheme-editor] that you can use to
inform which theme you'd like to chose. You can also download the file there and
use them in a lot of popular editors or use it as a foundation to edit the
source of a theme for your favorite text editor.

![Hopscotch theme editor]({{ site.url }}/img/dress-code/hopscotch-preview.png)

[tmtheme-editor]: http://tmtheme-editor.herokuapp.com

#### Font

I like the [open-source M+ font][m_plus] a lot because of how much the lowercase
g in the M+ M Type-2 family looks like my hand-written lowercase g.

```
gggggggggggggggggggggggggggggggggggg
it's a really nice g, isn't it?
```

It's also open-source. I like the fact that [I can store the compiled font
somewhere][rogeruiz/fonts] and not worry about losing access to the font or
worry about licensing. I also use the font on my site for all my code excerpts
on this site. I think it looks great.

[m_plus]: http://mplus-fonts.osdn.jp/about-en.html#multiweight

### Working with NerdFonts Patcher

Once I discovered [the NerdFonts patcher][nerdfonts], I immediately patched my
own M+ 2m font to use in iTerm. iTerms supports two different fonts for ASCII
and non-ASCII text so those icons will look great next to your favorite font.

![iTerm preference for text support]({{ site.url }}/img/dress-code/iterm-preferences.png)

I used this and ran all the bits. It was a load of work, so maybe just pick
something that's already patched. I didn't. I didn't because the particular font
family I use wasn't officially supported. I'm very particular so I patched a
version of the font I use and modified iTerm to leverage both fonts depending on
what it was rendering. It's great since I can set the width of the characters
separately for each font.

[nerdfonts]: https://github.com/ryanoasis/nerd-fonts

### Treat your PS1 like Jon Ivy treats the Touch Bar

I like to make sure I have as much information on display at any given time.
It's a good place to let out your creative side out and it helps to understand
typographic emphasis. And with my patched version of my favorite font with
icons, I customized every last pixel on my PS1 prompt.

![Terminal prompt example]({{ site.url }}/img/dress-code/terminal-prompt.png)

Below are some excerpts from my modified _pure_ theme, real.

```sh
prompt_pure_job_count() {
  local job_count=$(jobs | wc -l | xargs)
  if (( $job_count > 0 ))
  then
    echo -n " "
  fi
}
```

I like to know if I have any background jobs running without having to run
`jobs`. What better way to represent that than with an old floppy disk. Remember
that feeling of having a floppy in disk in your computer and hearing that
rattling sound when the computer was reading from it? This function brings me
back to those days.

```sh
prompt_pure_git_diary() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    command git log -1 &>/dev/null || return

    for day in $(seq 14 -1 0); do
        git log --before="${day} days" --after="$[${day}+1] days" --format=oneline |
        wc -l
    done | spark
}
```

I like to keep diaries even if they're absurd or visual. Git keeps a really good
record of activity so I figured, why not show what the activity for a particular
branch is using spark charts.

```sh
prompt_pure_precmd() {
    # ... shortened for brevity

    local prompt_pure_preprompt='\n%F{yellow}`prompt_pure_cmd_exec_time`%f%F{cyan}  %F{magenta}`prompt_pure_job_count`%F{242}%~ $vcs_info_msg_0_ %F{242}`prompt_pure_git_diary`%f %F{yellow}`prompt_pure_git_dirty`%f $prompt_pure_username %f'
    print -P $prompt_pure_preprompt

    # check async if there is anything to pull
    (( ${PURE_GIT_PULL:-1} )) && {
        # check if we're in a git repo
        command git rev-parse --is-inside-work-tree &>/dev/null &&
        # check check if there is anything to pull
        command git fetch &>/dev/null &&
        # check if there is an upstream configured for this branch
        command git rev-parse --abbrev-ref @'{u}' &>/dev/null &&
        (( $(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) &&
        # some crazy ansi magic to inject the symbol into the previous line
        print -Pn "\e7\e[A\e[1G\e[`prompt_pure_string_length $prompt_pure_preprompt`C%F{cyan}%f\e8"
    } &!

}
```

The `precmd` function here is what prints out the little manilla folder and
cloud icons when there are remote changes in a git repository.

```sh
prompt_pure_setup() {
    # ... shortened for brevity

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git*' formats "%F{green}%F{242} %b"
    zstyle ':vcs_info:git*' actionformats "%F{green}%F{242} %b %F{green} %F{242} %a"

    # prompt turns red if the previous command didn't exit with 0

    prompt_okay="%F{green}  "
    prompt_not_okay="%F{red}  "
    PROMPT='%(?.${prompt_okay}.${prompt_not_okay})%f %F{242} %f '

}
```

Here I output some git related icons, and okay / not_okay iconography based on
the exit status of the last command than ran.

### tl;dr

I hope you enjoyed reading this and that it helps inspire you to modify your
command prompt. Take your tools seriously and take the time to customize them.
It's very difficult to try and keep all the context in your head when something
as highly conceptual as a terminal. Iconography and specific output can be super
helpful when working in a terminal, so take the time to add what you want to
know your PS1 prompt. At the bare-minimum, you should be able to look at your
PS1 prompt and know where you are, what you're doing, and possibly what just happened.
