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
    </div>
    <ul class="contact">
      <li><a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a></li>
      <li><a href="https://www.linkedin.com/in/{{ site.author.linkedin }}">LinkedIn</a></li>
      <li><a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a></li>
      <li><a href="https://github.com/{{ site.author.github }}">GitHub</a></li>
      <li><a href="{{ '/resume/' | relative_url }}">Resume</a></li>
    </ul>
  </div>
  <!-- To add a photo: save it as assets/img/portrait.jpg and uncomment the next line -->
  <!-- <img class="portrait" src="{{ '/assets/img/portrait.jpg' | relative_url }}" alt="{{ site.author.name }}"> -->
</section>

{% include day-curve.html %}

<h2>Interests</h2>
<ul class="interests">
  <li>Time-series forecasting of energy demand and battery behaviour</li>
  <li>Physics-informed machine learning and state estimation</li>
  <li>Dispatch and bidding optimisation for batteries, heat pumps and thermal storage</li>
  <li>Electricity markets: day-ahead, intraday and balancing</li>
</ul>

<h2>Selected publications</h2>
{% include pubs.html selected=true %}
<p class="more"><a href="{{ '/resume/' | relative_url }}#publications">All publications</a></p>

<h2>Writing</h2>
<ul class="post-list">
{% for post in site.posts limit: 5 %}
  <li>
    <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%-d %b %Y" }}</time>
    <span><a href="{{ post.url | relative_url }}">{{ post.title }}</a>{% if post.summary %}<span class="summary">{{ post.summary }}</span>{% endif %}</span>
  </li>
{% else %}
  <li><span class="empty">No posts yet.</span></li>
{% endfor %}
</ul>
<p class="more"><a href="{{ '/blog/' | relative_url }}">All posts</a></p>
