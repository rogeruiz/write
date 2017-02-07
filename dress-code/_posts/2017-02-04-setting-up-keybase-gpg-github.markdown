---
layout: post
title: "Setting up Keybase GPG with GitHub"
date: "2017-02-04 13:30:00 -0400"
---

## Getting started

> To use this guide you will need to be working in the terminal, like Bash or
> Zsh. I also make the assumption that you're using Mac hardware and software.
> In particular, you need to have Git and Keybase installed along with Homebrew.

GNU Privacy Guard (GPG) is pretty dope. It allows you to send encrypted information
from yourself to another trusted person. You're able to control who the other
trusted person is by practicing safe distribution of your public key. They can
verify messages that you send them signed (encrypted) with your private key by
using their copy of your public key to decrypt it.

So, I had a [Keybase account][kb-profile] before the whole `[Verified]` thing on
GitHub was on my radar. I didn't know much about it or how it would be something
that I wanted to do for my workflow. I already considered [my
selfies]({{ site.baseurl }}/writing/humanizing-computer-work.html) to be enough
to validate my identity. &#x1f61c;

Let's walk through setting up [GitHub verified commits and tags][gh-gpg] with
[GPG][hp-gpg] and [Keybase][hp-keybase]. Follow along with the great [Keybase
GPG GitHub repository][gh-keybase-gpg-github] otherwise continue reading below
to take an existing Keybase key and use it for your [GitHub account][gh-keys].

[gh-gpg]: https://github.com/blog/2144-gpg-signature-verification "GitHub GPG Signature Verification"
[hp-gpg]: https://gnupg.org "The GNU Privacy Guard"
[kb-profile]: https://keybase.io/rogeruiz "Roger Steve Ruiz (rogeruiz) | Keybase"
[hp-keybase]: https://keybase.io "Keys for everyone! Keybase maps your identity to your public keys, and vice versa."
[gh-keybase-gpg-github]: https://github.com/pstadler/keybase-gpg-github "Keybase GPG GitHub repository"
[gh-keys]: https://github.com/settings/keys "GitHub SSH and GPG Keys"

### You already have a Keybase account and key

If you don't already have `gpg` installed on your machine, just brew some up
from source.

```sh

brew install gpg
```

You need to get a list of your PGP keys from Keybase. Since you're reading this
you should have one. The **Keybase Key ID** is important to note here so you
might want to export to your environment. You will need it later. The output
below has a suggestion for what you want to call the variable.

```sh

keybase pgp list


Keybase Key ID: $KEY_ID_FOR_QUERY
PGP Fingerprint: MYP GP FIN GER PR INT
PGP Identities:
   Name Last <hello@example.com>
```

To use GPG for GitHub verified commits, you need to export your key from
Keybase. This is easy to do from command line using the Keybase client. You want
to make sure you include the secret key and import that into GPG with the
correct flags.

```sh

keybase pgp export -s | \
gpg --import --allow-secret-key-import


GPG key imported
```

Next, make sure that your key was imported correctly. Your identity should be
carried over from the `keybase pgp list` command above. The secret signing key
is what you're going be using in your `~/.gitconfig`.

```sh

gpg --list-secret-keys


/$HOME/.gnupg/secring.gpg
-----------------------------
sec   7530G/5S2M8G66 2016-04-05 [expires: 3204-04-01]
#           ^^^^^^^^ You're going to use this in your Git configuration file to
#                    track your key
uid                  Name Last <hello@example.com>
ssb   7530G/618n55f5 2016-04-05
```

Use the following environment variable to configure installation of Git. Then
run the following commands to configure both Git and GitHub.

```sh

export MY_SIGNING_KEY="$(gpg --list-secret-keys | \
                         grep -E '\s.*\/.*\s' | \
                         cut -d / -f 2 | \
                         grep -o -E '^(\d\w)+ ')"


git config --global user.signingkey $MY_SIGNING_KEY && \
git config --global commit.gpgsign true
```

Next, using your key ID from the first command export your public key to upload
it to GitHub. Copy your public key to your clipboard via `pbcopy` and configure
your GPG installation with your signing key. In your browser, create a new GPG
key in your GitHub account and paste your public key.

```sh

export MY_KEY_ID="$(keybase pgp list | \
                 grep -oiE 'key id.*$' | \
                 grep -oE '[a-zA-Z0-9]+$')"

keybase pgp export -q $MY_KEY_ID | pbcopy && \
echo "default-key $MY_SIGNING_KEY" >> ~/.gnupg/gpg.conf && \
open https://github.com/settings/keys
```

You should use `gpg-agent` and `pinentry-mac` to properly set up your Keychain
to handle the passphrase verification. The instructions are in the repo
mentioned below.

### You don't already have a Keybase key, but you have an account

I mentioned it above. Please follow along on the instructions in the [Keybase
GPG GitHub repository's `README.md`][gh-keybase-gpg-github]. The instructions
there were adapted for the guide above.
