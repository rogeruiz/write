---
layout: post
title: "cURLing, CORS, and your sanity"
date: "2015-10-08 10:47:00 -0400"
---

There are a lot of things that are easily taken for granted when all of
your application's assets live on the same origin / domain. It's all too
easy to rest on the assumption that security features only protect you, but
there are plenty of things browsers do in order to protect user's through-out
a variety of attacks that could befall the innocent user. As a web developer who
is trying to build client-side applications with a centralized API, you may think
that you don't really need protecting yet CORS will gladly step in block you
unless you're following the recommended [spec](http://www.w3.org/TR/cors/).

## CORS because of XSS-etera

Cross-site scripting and cross-origin request sharing go hand in hand. When trying
to prevent XSS attacks from happening, browser vendors have implemented ways to
mitigate the damage that a compromised user session can have on a particular site.

This is pretty important considering how much of the internet now happens via JS
rather than page refreshes. Most client-side interactions always have some form
of AJAX call associated with a user's data. Browser vendors implemented the W3C
recommendation which "preflights" these AJAX and `@font-face` with an `OPTIONS`
request and establishes a coordinated request from two different origins / domains.

## Cross-Origin Request Sharing, or the handshake between two servers

When a browser makes a request to an external resource on a different domain, the
browser will insert a "preflight" request before your actual request. Depending on
how the server responds to your `OPTIONS` request:

```
OPTIONS /v1 HTTP/1.1
Origin: http://client-side-app.com
Host: server-side-api.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Whatever/YOLO 5.0...
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: X-Client-Side
```

A response that allows `PUT` and `DELETE` requests with cookies and custom-headers

```
Access-Control-Allow-Origin: http://client-side-app.com
Access-Control-Allow-Methods: PUT, DELETE
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: X-Client-Side
```

## Let's get your server set up to respond appropriately

The first step to getting your server to respond appropriately is to make sure
that it's not. My approach to working with web applications is to make sure that
I am not building something that is already working. So let's debug our client
and server interaction and make sure that CORS is giving us a hard time.

### cURLing your way

I have grown very accustomed to using my terminal for most things, this includes
my text editor and time tracker. I even use Lynx from time-to-time to read some
technical articles.

