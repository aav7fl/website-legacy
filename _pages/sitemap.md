---
layout: default
title: Sitemap
description: "Website Sitemap"
regenerate: true
permalink: /sitemap/
---

<h2>Blog Posts</h2>

{% for post in site.posts %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}

  {% if year != nyear %}
  <h3><th colspan="3">{{ post.date | date: '%Y' }}</th></h3>
  {% endif %}

  <li><a href="{{ post.url }}">{{ post.title }}</a></li>

{% endfor %}

<h2>Other Pages</h2>

{% for page in site.pages %}

  <li><a href="{{ page.url }}">{{ page.title }}</a></li>

{% endfor %}
