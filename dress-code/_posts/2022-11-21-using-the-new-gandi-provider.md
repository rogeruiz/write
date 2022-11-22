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

