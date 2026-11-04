---
layout: default
title: About
---

<div class="intro">
  <!-- To add a photo: put it at assets/img/portrait.jpg and uncomment the next line -->
  <!-- <img class="portrait" src="{{ '/assets/img/portrait.jpg' | relative_url }}" alt="Portrait of {{ site.author.name }}"> -->
  <div>
    <h1>{{ site.author.name }}</h1>
    <p class="lede">
      I work on modelling, estimation and optimisation for energy systems.
      At <a href="https://www.gradyent.ai">Gradyent</a> in Rotterdam I build digital twins
      and optimisation models for district heating networks. Before that I did my PhD
      research at TU Delft on battery modelling and state estimation.
    </p>
    <p class="contact-line">
      {{ site.author.location }}
      &nbsp;·&nbsp; <a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a>
    </p>
  </div>
</div>

## Research interests

- State and parameter estimation for batteries: moving horizon estimation, physics-informed machine learning
- Hydraulic and thermal modelling of district heating networks
- Optimal operation of flexible assets: storage, heat pumps, e-boilers
- Battery bidding in day-ahead, intraday and balancing electricity markets

## Recent writing

<ul class="post-list">
{% for post in site.posts limit: 5 %}
  <li>
    <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%-d %b %Y" }}</time>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </li>
{% else %}
  <li><span>No posts yet.</span></li>
{% endfor %}
</ul>

[All posts &rarr;]({{ '/blog/' | relative_url }})
