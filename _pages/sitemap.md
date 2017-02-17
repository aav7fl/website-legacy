---
layout: default
title: Sitemap
description: "A webpage version of the website sitemap for KyleNiewiada.org providing a simple overview of all website content."
regenerate: true
permalink: /sitemap/
---

## Blog Posts

{% for post in site.posts %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
  {% if year != nyear %}
### {{ post.date | date: '%Y' }}
  {% endif %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}

## Other Pages

{% for page in site.pages %}
- [{{ page.title }}]({{ page.url }})
{% endfor %}
