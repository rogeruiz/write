---
layout: post
title: Debugging in a terminal
date: "2022-01-27T21:31:11-05:00"
---

When it comes to debugging a Linux server, I like to think of it as if it's a
database that I'm querying.

There are a lot of Linux fundamentals that I have come across over the years of
being an engineer which I use to try to get to the source of a problem that's
running on a server.

I'm going to go through all of them in this essay where I break down things into
a couple of good steps to take before you start blaming your application or
service. And I'll say that it is probably your application or service, but this
essay is about the why not the what of what you've decided to run on a Linux
server.

This means knowing a lot of general commands around Linux that help you debug
everything about the state of the system.

When you aren't familiar with the system or you don't have the proper
observability

The cause of the issues was rarely obvious: here are a few things we usually got
started with.

## What are the conditions of the server?

It's important to get some context of what's going on with the CPU, memory,
disk, OS, and network. But it's also important to realize that there's some
basic awareness you should have as well.

> Don't rush on the servers just yet, you need to figure out how much is already
> known about the server and the specifics of the issues. You don't want to
> waste your time troubleshooting in the dark.

A few "must have":

- Is it reproducible?
- What exactly are the symptoms of the issue? Unresponsiveness? Errors?
- What were the latest changes on the platform (application code, servers,
    infrastructure)?
- Is there monitoring in place?
- Does it affect a specific user segment (logged in, logged out, geographically
  located...)?
- Any pattern (e.g. happens every hour)?
- Is there any documentation for the architecture?
- Any (centralized) logs?
- When did the problem start being noticed?
- The last two ones are the most convenient sources of information, but don't
  expect too much: they're also the ones usually painfully absent. Tough luck,
  make a note to get this corrected and move on.

### Is anybody else out there?

While these commands are not critical to troubleshooting a server, you might
find that you're not the only person on the server, so it's important to
understand if there are any other users and when the last login was.

{% highlight sh %}

w # displays who's logged and what they're doing
{% endhighlight %}

{% highlight sh %}

last # show the last logins of users and their ttys
{% endhighlight %}


### What was previously done?

Always a good thing to look at; combined with the knowledge of who was on the
box earlier on. Be responsible by all means, being admin shouldn't allow you to
break ones privacy.

A quick mental note for later, you may want to update the environment variable
`HISTTIMEFORMAT` to keep track of the time those commands were ran. Nothing is
more frustrating than investigating an outdated list of commands.

{% highlight sh %}

history
{% endhighlight %}

### What is running?

While `ps aux` tends to be pretty verbose, `pstree -a` gives you a nice
condensed view of what is running and who called what.

{% highlight sh %}

pstree -a
{% endhighlight %}

{% highlight sh %}

ps aux
{% endhighlight %}


## Listening services

I tend to prefer running them separately, mainly because I don't like looking at
all the services at the same time. `netstat -nalp` will do to though. Even then,
I'd omit the numeric option (IPs are more readable IMHO).

Identify the running services and whether they're expected to be running or not.
Look for the various listening ports. You can always match the `PID` of the
process with the output of `ps aux`; this can be quite useful especially when
you end up with 2 or 3 Java or Erlang processes running concurrently.

We usual prefer to have more or less specialized boxes, with a low number of
services running on each one of them. If you see 3 dozens of listening ports you
probably should make a mental note of investigating this further and see what
can be cleaned up or reorganized.

{
{% highlight sh %}

netstat -ntlp
{% endhighlight %}

{% highlight sh %}

netstat -nulp
{% endhighlight %}

{% highlight sh %}

netstat -nxlp
{% endhighlight %}


## CPU and RAM

### This should answer a few questions:

- Any free RAM? Is it swapping?
- Is there still some CPU left? How many CPU cores are available on the server?
  Is one of them overloaded?
- What is causing the most load on the box? What is the load average?

{% highlight sh %}

free -m
{% endhighlight %}

{% highlight sh %}

uptime
{% endhighlight %}

{% highlight sh %}

top
{% endhighlight %}

{% highlight sh %}

htop
{% endhighlight %}
Hardware

{% highlight sh %}

lspci
{% endhighlight %}

{% highlight sh %}

dmidecode
{% endhighlight %}

{% highlight sh %}

ethtool
{% endhighlight %}

### There are still a lot of bare-metal servers out there, this should help with

- Identifying the RAID card (with BBU?), the CPU, the available memory slots.
  This may give you some hints on potential issues and/or performance
  improvements.
- Is your NIC properly set? Are you running in half-duplex? In 10MBps? Any TX/RX
  errors?

## IO Performances

{% highlight sh %}

iostat -kx 2
{% endhighlight %}

{% highlight sh %}

vmstat 2 10
{% endhighlight %}

{% highlight sh %}

mpstat 2 10
{% endhighlight %}

{% highlight sh %}

dstat --top-io --top-bio
{% endhighlight %}

### Very useful commands to analyze the overall performances of your backend;

- Checking the disk usage: has the box a filesystem/disk with 100% disk usage?
- Is the swap currently in use (si/so)?
- What is using the CPU: system? User? Stolen (VM)?
- `dstat` is my all-time favorite. What is using the IO? Is MySQL sucking up the
  resources? Is it your PHP processes?

## Mount points and filesystems

{% highlight sh %}

mount
{% endhighlight %}

{% highlight sh %}

cat /etc/fstab
{% endhighlight %}

{% highlight sh %}

vgs
{% endhighlight %}

{% highlight sh %}

pvs
{% endhighlight %}

{% highlight sh %}

lvs
{% endhighlight %}

{% highlight sh %}

df -h
{% endhighlight %}

{% highlight sh %}

lsof +D / # beware not to overload the server with this command.
{% endhighlight %}

- How many filesystems are mounted?
- Is there a dedicated filesystem for some of the services? (MySQL by any
  chance...?)
- What are the `filesystem` mount options: `noatime`? `default`? Have some
  `filesystem` been re-mounted as read-only?
- Do you have any disk space left?
- Is there any big (deleted) files that haven't been flushed yet?
- Do you have room to extend a partition if disk space is an issue?

## Kernel, interrupts and network usage

{% highlight sh %}

sysctl -a | grep ...
{% endhighlight %}

{% highlight sh %}

cat /proc/interrupts
{% endhighlight %}

{% highlight sh %}

cat /proc/net/ip_conntrack # may take some time on busy servers
{% endhighlight %}

{% highlight sh %}

netstat
{% endhighlight %}

{% highlight sh %}

ss -s
{% endhighlight %}

- Are your IRQ properly balanced across the CPU? Or is one of the core
  overloaded because of network interrupts, raid card, ...?
- How much is `swappinness` set to? 60 is good enough for workstations, but when
  it come to servers this is generally a bad idea: you do not want your server
  to swap...ever. Otherwise your swapping process will be locked while data is
  read/written to the disk.
- Is `conntrack_max` set to a high enough number to handle your traffic?
- How long do you maintain TCP connections in the various states (TIME_WAIT,
  ...)? `netstat` can be a bit slow to display all the existing connections, you
  may want to use `ss` instead to get a summary.
- Have a look at Linux TCP tuning for some more pointer as to how to tune your
  network stack.

## System logs and kernel messages

{% highlight sh %}

dmesg
{% endhighlight %}

{% highlight sh %}

less /var/log/messages
{% endhighlight %}

{% highlight sh %}

less /var/log/secure
{% endhighlight %}

{% highlight sh %}

less /var/log/auth
{% endhighlight %}

### Look for any error or warning messages;

- Is it spitting issues about the number of connections in your `conntrack`
  being too high?
- Do you see any hardware error, or `filesystem` error?
- Can you correlate the time from those events with the information provided
  beforehand?

## Cronjobs

{% highlight sh %}

ls /etc/cron* + cat
{% endhighlight %}

{% highlight sh %}

for user in $(cat /etc/passwd | cut -f1 -d:); do crontab -l -u $user; done
{% endhighlight %}

- Is there any cron job that is running too often?
- Is there some user's cron that is "hidden" to the common eyes?
- Was there a backup of some sort running at the time of the issue?

## Application logs

There is a lot to analyze here, but it's unlikely you'll have time to be
exhaustive at first. Focus on the obvious ones, for example in the case of a
LAMP stack:

- For Apache or NGINX, chase down access and error logs, look for `5xx` errors,
  look for possible `limit_zone` errors.
- For MySQL, look for errors in the `mysql.log`, trace of corrupted tables,
  `innodb` repair process in progress. Looks for slow logs and define if there
  is disk, index, or query issues.
- For PHP-FPM, if you have php-slow logs on, dig in and try to find errors
  (`php`, `mysql`, `memcache`, etc). If not, set it on.
- For Varnish, in `varnishlog` and `varnishstat`, check your hit/miss ratio. Are
  you missing some rules in your config that let end-users hit your backend
  instead?
- For HA-Proxy, what is your backend status? Are your health-checks successful?
  Do you hit your max queue size on the frontend or your backends?

## Conclusion

After these first 5 minutes (give or take 10 minutes) you should have a better
understanding of:

- What is running.
- Whether the issue seems to be related to IO/hardware/networking or
  configuration (bad code, kernel tuning, ...).
- Whether there's a pattern you recognize: for example a bad use of the DB
  indexes, or too many Apache workers.
- You may even have found the actual root cause. If not, you should be in a good
  place to start digging further, with the knowledge that you've covered the
  obvious.
