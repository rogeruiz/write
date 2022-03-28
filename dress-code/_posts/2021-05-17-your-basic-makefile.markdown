---
layout: post
title: Your basic Makefile
date: "2021-05-17T00:00:00+00:00"
---

Make is a tool that's been around for a long time. It was built in order to
manage building programs and update files when other files change.

> In software development, Make is a build automation tool that automatically
> builds executable programs and libraries from source code by reading files
> called Makefiles which specify how to derive the target program. Though
> integrated development environments and language-specific compiler features can
> also be used to manage a build process, Make remains widely used, especially in
> Unix and Unix-like operating systems.

> Besides building programs, Make can be used to manage any project where some
> files must be updated automatically from others whenever the others change.

[Source: Make (Software) on Wikipedia](https://en.wikipedia.org/wiki/Make_(software))

Because of this, I use it a lot even when other automation tooling exists. I
don't actively avoid tooling like `yarn` or `npm` or `rake` or `cargo` or `go`,
but I will usually wrap them in `make` targets to ensure that there's a single
interface. I think that there's a pretty steep learning curve when it comes to
writing any _Makefiles_. Especially when you're coming from other automation
tooling. Make was written in April of 1976, and it's still quite popular. I'm
hoping that by writing this, I can help folks who aren't too familiar with Make
at least comfortable when it comes to managing a _Makefile_.

## Here enters a _Makefile_

Now below I have a _Makefile_ template that I like to use. I sometimes only
reference it and others times I'll just copy and paste it and start editing it.
Feel free to use it for your projects. [The latest version I keep updated in my
Gists here][gist-makefile].

[gist-makefile]: https://gist.github.com/rogeruiz/c112313f5c480b830b3274fc0ac1ad21

```makefile
# This is a template Makefile that I use for automating projects that might
# require one.
#
# For more guidance around Makefiles, the checkout out the helpful 
# [makefiletutorial](https://makefiletutorial.com/).

directory = tmp

# A loop that automatically runs to check if executables are in the $PATH variable before running any targets.
EXECUTABLES = echo mkdir npm yarn nc grep sort awk
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell command -v $(exec)),some string,$(error "No $(exec) executable in PATH")))

# A function to check if a environment variable is defined or not.
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

$(directory):
	@echo "Folder ./$(directory) does not exist"
	mkdir -p $@

all: $(directory) ## This is the default target. It depends on a ./tmp/ directory to exist...

# An example of checking if something is running on port 8800.
# This could be used for anything like a file existance or a particular
# PID is running. The object of this target is to check if something is true via
# exit status and then output a message if it failed and then to also fail on
# the target so Make doesn't keep running.
.PHONY: is-server-running
is-server-running:
	@nc -zv 127.0.0.1 8800 &> /dev/null || \
		if [ $$? -eq 1 ]; then echo "The development server is not running.\nRun \`make run-server\` in another terminal."; false; fi

.PHONY: install
install: ## A target to install stuff with required $var1 and $var2 to be passed into the target...
	$(call check_defined, var1)
	$(call check_defined, var2)
	# do stuff here..

.PHONY: help
help: ## Outputs this help message.
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
```

There's a lot of things going on here, so I will be breaking it all down piece
by piece after the file.

### What is a Make target

### Default targets

### Some commands are phonies

### Always include a _Help_ command

### Using external commands inside targets

### Checking for external executables

### You can write Bash in a _Makefile_ without needing external scripts
