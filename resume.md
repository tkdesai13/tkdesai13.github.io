---
layout: default
title: Resume
permalink: /resume/
---

# Resume

<p class="pdf-link">
  <!-- Put your PDF CV at assets/files/cv.pdf, then this link works -->
  <a href="{{ '/assets/files/cv.pdf' | relative_url }}">Download PDF</a>
  &nbsp;·&nbsp; <a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a>
  &nbsp;·&nbsp; {{ site.author.location }}
</p>

## Experience

<div class="cv-entry">
  <span class="role">Solutions Engineer / Data Scientist</span>
  <span class="dates">2025 – present</span>
  <span class="org">Gradyent, Rotterdam</span>
  <ul>
    <li>Build digital twins of district heating networks for utilities in the Netherlands and Scandinavia.</li>
    <li>Hydraulic and thermal network models using graph traversal, incidence matrices and forward/backward sweep methods.</li>
    <li>Optimisation studies (CasADi) for network expansion and new heat sources: thermal storage, e-boilers, heat pumps, geothermal.</li>
    <li>GIS-based network analysis with QGIS and Python; data pipelines with DuckDB.</li>
  </ul>
</div>

<div class="cv-entry">
  <span class="role">PhD Researcher</span>
  <span class="dates">Mar 2021 – Jul 2025</span>
  <span class="org">Delft University of Technology, Delft Center for Systems and Control</span>
  <ul>
    <li>Research on battery modelling, state estimation and optimisation, supervised by Dr. Riccardo Ferrari.</li>
    <li>Moving horizon estimation and physics-informed machine learning for battery state estimation.</li>
    <!-- EDIT: add bullets for teaching, MSc supervision, collaborations -->
  </ul>
</div>

## Education

<div class="cv-entry">
  <span class="role">PhD, Systems and Control</span>
  <span class="dates">Defence: Jan 2027</span>
  <span class="org">Delft University of Technology</span>
  <ul><li>Thesis: <em><!-- EDIT: thesis title --></em></li></ul>
</div>

<div class="cv-entry">
  <span class="role">M.Sc., <!-- EDIT: programme --></span>
  <span class="dates"><!-- EDIT: years --></span>
  <span class="org">RWTH Aachen University</span>
</div>

## Publications

<!-- EDIT: one line per paper. Example format:
1. **T. Desai**, R. Ferrari. "Title of the paper." *Journal or Conference*, 2024. [doi](https://doi.org/...)
-->
1. *Add your publications here.*

## Projects

<div class="cv-entry">
  <span class="role">Battery bidding optimiser</span>
  <span class="dates">Ongoing</span>
  <span class="org">Personal project</span>
  <ul>
    <li>Co-optimised bidding of a battery across day-ahead, intraday and balancing markets (FCR, aFRR, mFRR), including block bids and re-trading.</li>
  </ul>
</div>

<div class="cv-entry">
  <span class="role">mFRR bidding strategy for a battery</span>
  <span class="dates"></span>
  <span class="org">Finnish balancing market</span>
  <ul>
    <li>Rolling-horizon bidding for an 8 MWh system with 15-minute settlement periods, state-of-charge safety margins and time-of-day activation probabilities.</li>
  </ul>
</div>

## Skills

<dl class="skills">
  <dt>Methods</dt>
  <dd>Nonlinear optimisation, model predictive control, moving horizon estimation, Kalman filtering, physics-informed ML, graph algorithms, network hydraulics</dd>
  <dt>Software</dt>
  <dd>Python (NumPy, pandas, CasADi), DuckDB, SQL, QGIS, Git<!-- EDIT: MATLAB, PyTorch, etc. --></dd>
  <dt>Domain</dt>
  <dd>District heating, lithium-ion batteries, European electricity markets (EPEX SPOT, SIDC, balancing)</dd>
  <dt>Languages</dt>
  <dd>English (fluent), Dutch (learning)<!-- EDIT: add others --></dd>
</dl>
