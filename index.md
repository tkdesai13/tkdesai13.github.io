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
      I build forecasting and optimisation models for energy systems and take them from
      first analysis to use in operations. At <a href="https://www.gradyent.ai">Gradyent</a>
      in Rotterdam I forecast heat demand from smart heat meter data and use the forecasts to
      schedule boilers, heat pumps and thermal storage in district heating networks.
    </p>
    <p>
      Before that I did my PhD at TU Delft with Dr. Riccardo Ferrari on machine learning and
      state estimation for lithium-ion batteries: physics-informed models that estimate battery
      state from sparse, unlabelled field data, and moving horizon estimators for joint state and
      parameter estimation. Outside work I am building a bidding and dispatch optimiser for
      batteries in European electricity markets.
    </p>
    <p class="contact-line">
      {{ site.author.location }}
      &nbsp;·&nbsp; <a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a>
      &nbsp;·&nbsp; <a href="https://www.linkedin.com/in/{{ site.author.linkedin }}">LinkedIn</a>
      &nbsp;·&nbsp; <a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a>
    </p>
  </div>
</div>

## Interests

- Time-series forecasting of energy demand and battery behaviour
- Physics-informed machine learning and state estimation (moving horizon estimation, Bayesian filtering)
- Dispatch and bidding optimisation for flexible assets: batteries, heat pumps, thermal storage
- Electricity markets: day-ahead, intraday and balancing

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
