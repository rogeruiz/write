---
layout: post
title: Iterating Again and Again
date: "2021-04-27T11:41:37-04:00"
---

## Let's get started

{% highlight sh %}
  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     for r in $(l ~/.lolcommits/ |

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     l ~/.lolcommits
.DS_Store                  .plugins           cf-recycle-plugin  cg-site  cg-style  cloud-foundry-cli  config.yml            docs-buildpacks  dotfiles  handbook      kubernetes-broker
northwest-recommendations  openopps-platform  redis-3.2          repo     rog.gr    scuttle            staticfile-buildpack  thelou           tock      write.rog.gr

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     l ~/.lolcommits -d
/Users/rsr/.lolcommits

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     l -d ~/.lolcommits
/Users/rsr/.lolcommits

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     l -D ~/.lolcommits
.plugins           cf-recycle-plugin  cg-site  cg-style  cloud-foundry-cli  docs-buildpacks       dotfiles  handbook  kubernetes-broker  northwest-recommendations
openopps-platform  redis-3.2          repo     rog.gr    scuttle            staticfile-buildpack  thelou    tock      write.rog.gr

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     l -D ~/.lolcommits  | grep -v 'plugins'
cf-recycle-plugin
cg-site
cg-style
cloud-foundry-cli
docs-buildpacks
dotfiles
handbook
kubernetes-broker
northwest-recommendations
openopps-platform
redis-3.2
repo
rog.gr
scuttle
staticfile-buildpack
thelou
tock
write.rog.gr

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     for r in $(l -D ~/.lolcommits  | grep -v 'plugins'); do cp -v ~/.lolcommits/config.yml ~/.lolcommits/${r}/config.yml; done
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/cf-recycle-plugin/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/cg-site/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/cg-style/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/cloud-foundry-cli/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/docs-buildpacks/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/dotfiles/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/handbook/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/kubernetes-broker/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/northwest-recommendations/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/openopps-platform/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/redis-3.2/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/repo/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/rog.gr/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/scuttle/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/staticfile-buildpack/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/thelou/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/tock/config.yml
/Users/rsr/.lolcommits/config.yml -> /Users/rsr/.lolcommits/write.rog.gr/config.yml

  ~/Developer/oss/rog.gr  master ▁▁▁▁▁▁▁▁▁▁▁▁▃▁█
     z write
{% endhighlight %}
