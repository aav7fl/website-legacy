---
layout: default
title : Blog
---

<div class="post">
	<h1 class="pageTitle">Blog</h1>

	{% include setup %}
	{% assign posts_collate = site.posts %}
	{% include posts_collate %}

</div>
