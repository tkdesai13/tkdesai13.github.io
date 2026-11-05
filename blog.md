---
layout: default
title: Blog
permalink: /blog/
---

# Blog

Notes on modelling, estimation, optimisation and energy markets.
New posts are also published as an [RSS feed]({{ '/feed.xml' | relative_url }}) for feed readers.

{% assign sdata = site.data.series["bess-nl"] %}{% assign sposts = site.posts | where: "series", "bess-nl" %}
<a class="series-card" href="{{ sdata.url | relative_url }}"><span class="sc-kicker">Series</span><span class="sc-title">{{ sdata.title }}</span><span class="sc-meta">One 1 MW / 2 MWh battery and 2025 data, one market at a time. {{ sposts.size }} of {{ sdata.parts.size }} parts published.</span></a>

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
      <span class="pl-meta"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%-d %B %Y" }}</time>{% if post.series %}<span class="pl-part">Series, part {{ post.part }}</span>{% endif %}</span>
    </span>
  </li>
  {% endfor %}
</ul>
{% else %}
<p>No posts yet.</p>
{% endfor %}
