---
layout: default
title: Sitemap
description: "Website Sitemap"
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
