---
layout: default
title: Blog
permalink: /blog/
---

# Blog

Notes on modelling, estimation, optimisation and energy markets.
Subscribe via [RSS]({{ '/feed.xml' | relative_url }}).

{% assign by_year = site.posts | group_by_exp: "p", "p.date | date: '%Y'" %}
{% for year in by_year %}
<h2 class="year-heading">{{ year.name }}</h2>
<ul class="post-list">
  {% for post in year.items %}
  {% assign ic = post.icon | default: "forecast" %}
  <li>
    <span class="tile">{{ site.data.icons[ic] }}</span>
    <span>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.summary %}<span class="summary">{{ post.summary }}</span>{% endif %}
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%-d %B %Y" }}</time>
    </span>
  </li>
  {% endfor %}
</ul>
{% else %}
<p>No posts yet.</p>
{% endfor %}
