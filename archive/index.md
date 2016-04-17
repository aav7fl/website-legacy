---
layout: default
title : Post Archive
---

<section id="archive">
  <center><h1>Post Archive</h1></center>

  {% assign headerTags = "large projects,medium projects,small projects,updates" | split: ',' %}


  {% for tag in headerTags %}
    <h3 class="archive">{{ tag | capitalize}}</h3>
      {% for post in site.posts %}
        {% assign sanitizedPostTag = {{post.tag | upcase}} %}
        {% assign sanitizedHeaderTag = {{tag | upcase}} %}
        {% if sanitizedHeaderTag contains sanitizedPostTag %}
          {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
          {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
          <li><time>{{ post.date | date:"%d %b, %Y " }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
      {% endfor %}
    </ul>
  {% endfor %}


</section>
