---
layout: default
title: About
---
<section class="hero">
  <div>
    <h1>{{ site.author.name }}</h1>
    <p class="role">Solutions Engineer at Gradyent, Rotterdam</p>
    <div class="bio">
      <p>
        I build forecasting and optimisation models for energy systems and take them from
        first analysis to use in operations. At <a href="https://www.gradyent.ai">Gradyent</a>
        in Rotterdam I work on demand forecasting and on optimisation models that schedule
        energy assets against electricity prices.
      </p>
      <p>
        Before that I did my PhD at TU Delft with Dr. Riccardo Ferrari on machine learning and
        state estimation for lithium-ion batteries: physics-informed models that estimate battery
        state from sparse, unlabelled field data, and moving horizon estimators for joint state and
        parameter estimation. Outside work I am building a bidding and dispatch optimiser for
        batteries in European electricity markets.
      </p>
    </div>
    <div class="actions">
      <a class="btn btn-primary" href="{{ '/resume/' | relative_url }}">Resume</a>
      <a class="btn" href="mailto:{{ site.author.email }}">Email me</a>
      <span class="profiles">
        <a href="https://www.linkedin.com/in/{{ site.author.linkedin }}">LinkedIn</a>
        <a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a>
        <a href="https://github.com/{{ site.author.github }}">GitHub</a>
      </span>
    </div>
  </div>
  <img class="portrait" src="{{ '/assets/img/portrait.jpg' | relative_url }}" alt="Photo of {{ site.author.name }}" width="420" height="420">
</section>

{% include day-curve.html %}

<h2>Interests</h2>
<ul class="interests">
  <li><span class="tile">{{ site.data.icons.forecast }}</span><span>Time-series forecasting of energy demand and battery behaviour</span></li>
  <li><span class="tile">{{ site.data.icons.pinn }}</span><span>Physics-informed machine learning and state estimation for batteries</span></li>
  <li><span class="tile">{{ site.data.icons.grid }}</span><span>Rolling-horizon optimisation for scheduling flexible assets on the power grid</span></li>
  <li><span class="tile">{{ site.data.icons.market }}</span><span>Battery bidding in day-ahead, intraday and balancing markets</span></li>
</ul>

<div class="section-head">
  <h2>Selected publications</h2>
  <a href="{{ '/resume/' | relative_url }}#publications">All publications</a>
</div>
{% include pubs.html selected=true %}

<div class="section-head">
  <h2>Writing</h2>
  <a href="{{ '/blog/' | relative_url }}">All posts</a>
</div>
<ul class="post-list">
{% for post in site.posts limit: 5 %}
  {% assign ic = post.icon | default: "forecast" %}
  <li>
    <span class="tile">{{ site.data.icons[ic] }}</span>
    <span>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.summary %}<span class="summary">{{ post.summary }}</span>{% endif %}
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%-d %B %Y" }}</time>
    </span>
  </li>
{% else %}
  <li><span class="empty">No posts yet.</span></li>
{% endfor %}
</ul>
