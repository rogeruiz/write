---
layout: page
title: About
---

![Roger static]({{ site.url }}/img/about.png "Selfie")

### About

I am a self-taught software engineer that found my place in web development by
coming in through the window, specifically the browser window. Coming from a
traditional graphic design background, CSS and systems design were two things
that felt as natural as color theory and typography. As I learned more about the
history of and fundamentals of programming, I made my transition to full-stack
web development with a strong focus on front-end, back-end, infrastructure,
and automation.

I try to add elements of the emotional in a world of the artificial. We're all
people who work on computers, or sometimes inside the computers e.g. cloud, and
it is easy to forget that people at the end of the day are the ones using them.
My career has taken me from the private sector to the public sector. I enjoy
both kinds of work, although the latter I find has the most to improve on and
biggest impact.

Currently, my career path has me in more senior roles. I'm mostly focused on
release engineering and building the necessary infrastructure and processes to
help teams ship and iterate on software. I feel comfortable on-boarding on teams
to better understand how to contribute. I find myself consistently working on a
lot of different projects and being the glue interconnecting them.

### Experience
<ul class="exp-list">
  {% for exp in site.data.experiences %}
  <li>
    <span class="exp-name">{{ exp.name }}</span>
    <span class="exp-dates" title="{{ exp.length }}">{{ exp.dates }}</span>
    <p>{{ exp.title }}</p>
  </li>
  {% endfor %}
</ul>
