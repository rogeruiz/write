---
layout: post
title: Using the new Gandi provider
date: "2022-11-21T19:39:58-05:00"
---

> `tl;dr` Manage your Gandi DNS records via Terraform with open source tools and
> free commercial products. 
>
> [🔗 code](https://git.sr.ht/~rogeruiz/dns)

The new Gandi Terraform provider dropped on the 30th of September, 2022. I can't
remember where I read the news from but this is pretty good news for me. Now I
can start managing my DNS records using Terraform. I'd done this at 18F back in
my time there and now that my DNS registrar has a Terraform provider I'm aware
of, I decided to give it a shot.

[➡️  Checkout the Gandi Terraform provider on the Terraform Registry](https://registry.terraform.io/providers/go-gandi/gandi/2.2.0)

I've used Gandi for a long time as my personal choice in DNS providers. And if
you happen to use Gandi as your domain registrar, then this should help you dive
right in. And if you're not that's okay too. You might learn something from
this, but I can't promise anything.

[➡️  Learn more about Gandi](https://www.gandi.net/)

[➡️  The blog post on marco.org about domain registrars that introduced me to Gandi](https://marco.org/2011/04/14/why-is-it-so-hard-to-be-a-good-registrar)

## Get the TF into version control

The first major steps for me here was to get started and create a repository for
the code. I use sourcehut for my open source development now. I've made the
switch about a year ago. I love it. If you haven't checked out sourcehut yet, I
recommend it. 

[➡️  Checkout sourcehut](https://sr.ht/)

I went ahead and started a repository from scratch with the intentions of
writing Terraform code. The initial scaffolding here covers a license,
documentation, tooling around documentation, and the bare Terraform that's
required to exist to get started using the provider. It won't do anything, but
it's the foundation you need.

[➡️  Here's the commits so far](https://git.sr.ht/~rogeruiz/dns/log?from=1b314fe5ccf1d3e096b5f96c29406e8235d18e10#log-1b314fe5ccf1d3e096b5f96c29406e8235d18e10)

### The documentation is important

Documentation is everywhere. It's important to get it right. Things like
spelling, repetition, and sentence structure don't come easy to me. I like to
have the computer suggest things based on rules I find or can even write myself.
I like to use Vale to make sure that what I write makes sense to the reader.

[➡️  Checkout the vale command-line tool](https://vale.sh/)

```sh

vale dress_code/


 dress-code/_posts/2022-11-21-using-the-new-gandi-provider.md
 11:40  warning  'really' is a weasel word!      write-good.Weasel
 42:15  error    'my' is repeated!               Vale.Repetition
 43:35  error    Don't start a sentence with     write-good.So
                 'So '.

✖ 2 errors, 1 warnings and 0 suggestions in 1 file.
```

You could tie `vale` into your CI/CD process using the same steps to have it run
in your editor. Choose what you'd like but the best part for me is that it
covers a lot of edge cases in my writing such as spelling mistakes, using
passive voice, and generally trying to "write good". That last one is an open
source package for Vale which is easy enough to install.

I keep a basic `vale.ini` file in my home directory just to make sure I have the
my editor's linting running without crashing.

```sh

bat ~/.vale.ini

  
 File: ~/.vale.ini
 1   │ # Core settings appear at the top
 2   │ # (the "global" section).
 3   │
 4   │ [formats]
 5   │ # Format associations appear under
 6   │ # the optional "formats" section.
 7   │
 8   │ [*]
 9   │ # Format-specific settings appear
10   │ # under a user-provided "glob"
11   │ # pattern.
```

But to actually use Vale in a better way, you'll probably want something like
this using the built-ins.

```sh

# from within a directory with a Vale configuration file
bat .vale.ini 

  
 File: .vale.ini
 1   │ StylesPath = .vale/styles
 2   │ 
 3   │ Vocab = rogeruiz
 4   │ 
 5   │ Packages = write-good
 6   │ 
 7   │ [*.{md,markdown}]
 8   │ ; BasedOnStyles = Vale, write-good, rogeruiz
 9   │ BasedOnStyles = Vale, write-good
```

Note that this one uses the `write-good` package that I manually installed into
a custom `.vale/styles` directory in the repository. Also note that the Vocab
and the Styles are different directories to Vale. That's why line 8 above is a
comment. I don't have custom styles but I do have custom spellings.
