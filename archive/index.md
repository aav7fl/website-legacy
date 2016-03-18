---
layout: default
title : Archive
---

<section id="archive">
  <center><h1>Post Archive</h1></center>

<h3>Large projects</h3>  
  {% for post in site.posts %}
    {% if post.project_size == "large" %}
      {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
      {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
      <li><time>{{ post.date | date:"%d %b, %Y " }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

<h3>Medium projects</h3>  
  {% for post in site.posts %}
    {% if post.project_size == "medium" %}
      {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
      {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
      <li><time>{{ post.date | date:"%d %b, %Y " }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

<h3>Small projects/Updates</h3>  
  {% for post in site.posts %}
    {% if post.project_size == "small" %}
      {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
      {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
      <li><time>{{ post.date | date:"%d %b, %Y " }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

</section>
