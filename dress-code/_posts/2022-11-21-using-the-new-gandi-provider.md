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

## Get the TF state off my laptop

It's important to securely store the Terraform state file even if it's on your
machine. I like to get the TF state off of my machine, but I do this at work
where someone else is paying for the secure storage. While it's convenient that
Terraform uses local state storage by default I consider it an anti-pattern. But
like I mentioned, cloud storage costs money. HashiCorp provides a free tier to
their Terraform Cloud 

You can still plan and work with your variables locally, but you can store your
state file in your private account for free. There's more information about what
you can do below.

[➡️  Checkout the official documentation on Terraform Cloud Free Organizations](https://developer.hashicorp.com/terraform/cloud-docs/overview#free-organizations)

The following code is a breakdown of the least amount of work I did before
getting started with the Terraform CLI and logging into my new Terraform Cloud
account.

<details>
<summary>
<a href="https://git.sr.ht/~rogeruiz/dns/commit/1b314fe5ccf1d3e096b5f96c29406e8235d18e10">
➡️  Here's the code
</a> or click the non-highlighted part of this sentence to see it without leaving the page.
</summary>

{% highlight diff %}
From 1b314fe5ccf1d3e096b5f96c29406e8235d18e10 Mon Sep 17 00:00:00 2001
From: Roger Steve Ruiz <hi@rog.gr>
Date: Mon, 21 Nov 2022 19:10:24 -0500
Subject: [PATCH] Adding the Gandi Provider working;
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm leveraging TF Cloud to store my state files as well here. It's a
best practice, but it's certainly not entirely needed. Also, since
departing from HashiCorp I had to create a new user since I can't access
my Google account at HC anymore and my 2FA can't be disabled in order
for me to reclaim my account. I hope HC appreciates it 😉.

---
 main.tf      | 15 +++++++++++++++
 provider.tf  | 10 ++++++++++
 variables.tf | 11 +++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 main.tf
 create mode 100644 provider.tf
 create mode 100644 variables.tf

diff --git a/main.tf b/main.tf
new file mode 100644
index 0000000..0c0465a
--- /dev/null
+++ b/main.tf
@@ -0,0 +1,15 @@
+terraform {
+  cloud {
+    organization = "gandi-dns"
+    workspaces {
+      name = "main"
+    }
+  }
+
+  required_providers {
+    gandi = {
+      source  = "go-gandi/gandi"
+      version = ">= 2.1.0"
+    }
+  }
+}
diff --git a/provider.tf b/provider.tf
new file mode 100644
index 0000000..b280580
--- /dev/null
+++ b/provider.tf
@@ -0,0 +1,10 @@
+# The Gandi provider lives at:
+# https://github.com/go-gandi/terraform-provider-gandi
+
+# To make sure we don't expose things, let's leverage the `GANDI_KEY`
+# environment variable to replace the `key = ""` field in the provider
+# below.
+
+provider "gandi" {
+  key = var.gandi_api_key
+}
diff --git a/variables.tf b/variables.tf
new file mode 100644
index 0000000..6ef37dc
--- /dev/null
+++ b/variables.tf
@@ -0,0 +1,11 @@
+variable "gandi_api_key" {
+  type        = string
+  description = "The Gandi API key from the Account Management screen"
+}
+
+# README: This is disabled as I'm not sure if I'll ever use it.
+# variable "gandi_sharing_id" {
+#   type        = string
+#   default     = ""
+#   description = "The Gandi Sharing ID to indicate the organization that will pay for any ordered products and to filter collections."
+# }

-- 
2.34.5
{% endhighlight %}
</details>

Make sure you login to Terraform using the CLI after creating your Terraform
Cloud account. I've shortened the CLI to `tf` with an alias. Once you've logged
in, you can start using Terraform the way you expect to with a backend
configuration such as AWS S3, but if you opt-in to remote execution you get a
nice little web URL to track your plans and applies in the Terraform Cloud UI.

[➡️  Learn more about Backend configuration for Terraform](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)

```sh

tf login


# login with your Terraform Cloud account.
```

Once you've logged into Terraform Cloud locally, the following Terraform will
let you use it as your backend configuration. Learn more about it in the
official docs above.

```terraform
terraform {
  cloud {
    organization = "your-free-organiation"
    workspaces {
      name = "your-free-workspace"
    }
  }
}
```
[➡️  Sign up for Terraform Cloud](https://app.terraform.io/public/signup/account)

### It doesn't just have to be the state

While I choose to keep my secret variables and have my plans and applies execute
locally, Terraform Cloud does off some benefits if you use the more mainstream
version control systems. They don't support integrating with sourcehut, so I
will be sticking to using my local machine to run things, but I do still
appreciate having some secure storage for my state files behind a username and
password.

But it's nice that you can store environmental variables and sensitive
variables you'd expect to put in a `terraform.tfvars` file. They also support a
UI and remote execution for your Terraform commands. Not all commands, but most
of the important ones. And if you do have a supported SCM system, then you have
trigger builds whenever you push code to your repository.

## It's DNS

As mentioned earlier, this is all about DNS. Specifically, it's about updating
DNS records. I love this pattern of using Terraform to manage them as most DNS
records are not considered sensitive information. But it's too common to keep
these sort of records behind closed doors of an authenticated web UI. That means
you will have to log in just to verify your DNS settings. It also means that you
would need to share a screenshot or have someone log into your account to
manage your DNS records. I like that you could just have people take a look at
some code to verify that your DNS records are setup properly. There's a better
way. And that way is configuring your DNS records via infrastructure as code.
But since this is about a Terraform provider, we'll stick to Terraform-flavored
IaC.

### Security around DNS

Are DNS records secure? I asked myself that a lot and found out that they
aren't most of the time. It's possible that some things like an IP address or a
URI is not public, but there is no real sensitive information. But consider the
value of a `TXT` record. Those may look sensitive considering that sometimes
you need to generate these to prove trust somewhere on the internet. But, these
records are also tied to your domain as well and are accessible via `dig`
commands.

```sh

dig +short rog.gr TXT
#   |      |      ^ what's the type of DNS record.
#   |      ^ what's the domain for the DNS record. 
#   ^ just give me the value from the response instead of everything.


"google-site-verification=IztwJSDmloiYJFmZU9U-oIl4VTX3fdTVcVbfIIB3PO8"
```

You're welcome to do what you want with that `google-site-verification` value up
there. But if it's not coming from my domain, then it's useless to you. As usual
though, my threat model is not the same as yours. Always make sure you assess
one for yourself and your situation.

## Writing the Terraform

Now the Terraform code for the using provider specifically is in my DNS
repository. But, I'm going to include an example using the default DNS
resources you'll need to import your _Gandi LiveDNS records_. You will probably
want to import those into your Terraform state rather than creating them. But
the Gandi provider will not delete or override _LiveDNS_ domains from your
infrastructure. Some providers I've used do this.

### Importing the infrastructure

This part of the documentation for the provider is a little sparse. I'm working
on figuring out how to contribute back to the provider repository to include
some better examples but it easy to figure out from reading the source code as
long as you're comfortable with Golang.

```sh

terraform import -h

  
Usage: terraform [global options] import [options] ADDR ID
# shortened for brevity
```

[➡️  The Terraform import command](https://developer.hashicorp.com/terraform/cli/commands/import)

When importing infrastructure via the Terraform CLI, you need to target the
import with both an address and an identity. The address part is each to
understand. It's the part of the code you write to create a resource. 

```terraform
resource "gandi_livedns_domain" "example" {
  #                             ^ make sure you name this something memorable
  name = "example.com"
  #      ^ replace this with your domain
}
```

This translates to the following command to import this into your Terraform
state file. 

```sh

terraform import \
  resource.gandi_livedns_domain.example \
  example.com
```

As I said, the code for this is pretty straight forward to read. 

[➡️  This is the line where the ID gets set to the name that's passed in](https://github.com/go-gandi/terraform-provider-gandi/blob/ed7469caaf82f873f82867e73aa179063f5ac23f/gandi/resource_livedns_domain.go#L57)

If you have more questions on this, you can get some answers from the official
documentation soon. For now, go explore the codebase to see what the
definitions for the other IDs are.

[➡️  The Terraform import command](https://developer.hashicorp.com/terraform/cli/commands/import)
