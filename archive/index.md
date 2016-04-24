---
layout: default
title : "Post Archive"
meta: "Kyle Niewiada's blog post archive where my posts and projects are listed into categories based on the magnitude of each project and by personal updates"
---

<h1 class="pageTitle">{{ page.title }}</h1>

<section id="archive">
  {% assign headerTags = "large projects,medium projects,small projects,updates" | split: ',' %}

  {% for tag in headerTags %}
    <h3 class="archive">{{ tag | capitalize}}</h3>
      {% for post in site.posts %}
        {% assign sanitizedPostTag = {{post.tag | upcase}} %}
        {% assign sanitizedHeaderTag = {{tag | upcase}} %}
        {% if post.tag != null and sanitizedHeaderTag contains sanitizedPostTag %}
          {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
          {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
          <li><time>{{ post.date | date:"%d %b, %Y " }}</time><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
      {% endfor %}
    </ul>
  {% endfor %}
</section>
