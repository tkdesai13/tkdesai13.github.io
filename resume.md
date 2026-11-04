---
layout: default
title: Resume
permalink: /resume/
---
<header class="cv-head">
  <h1>Resume</h1>
  <p class="cv-actions">
    <!-- Save your PDF CV as assets/files/cv.pdf for this link to work -->
    <a class="pdf" href="{{ '/assets/files/cv.pdf' | relative_url }}">Download PDF</a>
    <a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a>
    <a href="https://www.linkedin.com/in/{{ site.author.linkedin }}">LinkedIn</a>
    <a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a>
  </p>
</header>

<p class="cv-summary">
  I build machine learning and forecasting models and take them from first analysis to use in
  operations. At Gradyent I forecast heat demand from smart heat meter data and deploy the models as
  digital twins for district heating operators. My PhD at TU Delft was on forecasting and state
  estimation for battery systems, using streaming field data in Azure.
</p>

<h2 id="experience">Experience</h2>
<ol class="timeline">
  <li class="current">
    <div class="when">Aug 2025 –<br> present</div>
    <div class="what">
      <div class="entry-head">
        <span class="tile">{{ site.data.icons.heat }}</span>
        <div><h3>Solutions Engineer</h3>
        <p class="where">Gradyent, Rotterdam</p></div>
      </div>
      <p class="focus">Digital twin development and energy system optimisation</p>
      <ul>
        <li>Build heat demand forecasts from smart heat meter data and use them as input to dispatch optimisation that schedules boilers, heat pumps and thermal storage against day-ahead prices.</li>
        <li>Turn operator sensor and geo data into calibrated network models, check them against measured flows and temperatures, and deploy them as digital twins inside client operations.</li>
        <li>Run scenario studies on the deployed models (supply mix, network expansion, storage sizing) over multi-year horizons, and work out what the results mean for the operator's costs and investment decisions.</li>
        <li>Present findings to clients' engineering and asset teams, and revise the assumptions when their operating experience contradicts the model.</li>
      </ul>
      <p class="tools">Python (pandas, NumPy), Git, code reviews, Jira, forecasting, optimisation, model deployment</p>
    </div>
  </li>
  <li>
    <div class="when">Mar 2021 –<br> May 2025</div>
    <div class="what">
      <div class="entry-head">
        <span class="tile">{{ site.data.icons.pinn }}</span>
        <div><h3>PhD Candidate</h3>
        <p class="where">TU Delft, Delft</p></div>
      </div>
      <p class="focus">Machine learning and forecasting models for batteries</p>
      <ul>
        <li>Developed a load forecasting model from temporal usage patterns; trained and compared several regression approaches on out-of-sample error to choose the one suited to the application.</li>
        <li>Developed a physics-informed machine learning model, trained with constrained multi-objective optimisation, that estimates battery state from sparse, unlabelled field data and holds up on data not seen in training.</li>
        <li>Worked with an industry partner to build and validate models on large volumes of streaming field data in Azure, processed with PySpark, covering data cleaning, feature engineering, model training and evaluation.</li>
        <li>Designed moving horizon estimators for joint battery state and parameter estimation (see publications).</li>
      </ul>
      <p class="tools">Python (pandas, NumPy, SciPy, scikit-learn), MATLAB, time-series forecasting, Bayesian filtering, Azure, PySpark</p>
    </div>
  </li>
  <li>
    <div class="when">Dec 2019 –<br> Jul 2020</div>
    <div class="what">
      <div class="entry-head">
        <span class="tile">{{ site.data.icons.ml }}</span>
        <div><h3>Master Thesis</h3>
        <p class="where">Bertrandt Ingenieurbüro GmbH, Neckarsulm</p></div>
      </div>
      <p class="focus">Machine learning model for emission forecasting</p>
      <ul>
        <li>Developed time-series regression models to predict ammonia and NOx emissions in automotive after-treatment systems, with prediction errors within ±5%.</li>
        <li>Handled the project from problem definition and proposal to technical documentation and presenting results to industrial partners.</li>
      </ul>
      <p class="tools">Python, Git, time-series modelling, statistical analysis, SQL, Azure</p>
    </div>
  </li>
  <li>
    <div class="when">Apr 2019 –<br> Nov 2019</div>
    <div class="what">
      <div class="entry-head">
        <span class="tile">{{ site.data.icons.anomaly }}</span>
        <div><h3>Student Assistant</h3>
        <p class="where">Bertrandt Ingenieurbüro GmbH, Neckarsulm</p></div>
      </div>
      <p class="focus">Feature engineering and anomaly detection</p>
      <ul>
        <li>Implemented feature selection with multivariate statistics and clustering, reducing data dimensionality by 50% while keeping 95% of the variance, and helped integrate the models into production software.</li>
        <li>Developed regression-based models for point and contextual anomaly detection in large time-series datasets.</li>
      </ul>
      <p class="tools">Python (OOP), SQL, software development, Git, Jira</p>
    </div>
  </li>
</ol>

<h2 id="education">Education</h2>
<ol class="timeline">
  <li>
    <div class="when">2021 – 2025</div>
    <div class="what">
      <h3>PhD, Machine Learning and Forecasting for Battery Systems</h3>
      <p class="where">TU Delft, supervised by Dr. Riccardo M. G. Ferrari</p>
      <ul>
        <li>Teaching assistant for the master's control systems lab.</li>
        <li>Supervised MSc students during their thesis projects.</li>
      </ul>
    </div>
  </li>
  <li>
    <div class="when">2017 – 2020</div>
    <div class="what">
      <h3>MSc, International Automotive Engineering</h3>
      <p class="where">FH Aachen University of Applied Sciences</p>
      <ul><li>Key courses: mathematical optimisation, machine learning, control theory. GPA 8.5/10.</li></ul>
    </div>
  </li>
  <li>
    <div class="when">2012 – 2016</div>
    <div class="what">
      <h3>BE, Mechanical Engineering</h3>
      <p class="where">The Maharaja Sayajirao University of Baroda, Vadodara</p>
      <ul><li>Research on a rotating-media liquid-air contacting device, published in <em>Energy Procedia</em> (2017). GPA 9.01/10.</li></ul>
    </div>
  </li>
</ol>

<h2 id="publications">Publications</h2>
<p class="more">Also on <a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a>.</p>
<h3 class="pub-group">Journal articles</h3>
{% include pubs.html type="journal" %}
<h3 class="pub-group">Conference papers</h3>
{% include pubs.html type="conference" %}
<h3 class="pub-group">Preprints</h3>
{% include pubs.html type="preprint" %}

<h2 id="projects">Projects</h2>
<ol class="timeline">
  <li class="current">
    <div class="when">2025 –<br> present</div>
    <div class="what">
      <div class="entry-head">
        <span class="tile">{{ site.data.icons.market }}</span>
        <div><h3>Battery storage bidding and dispatch optimiser</h3>
        <p class="where">Independent project, work in progress</p></div>
      </div>
      <ul>
        <li>An optimiser that bids and dispatches a battery across day-ahead, intraday and balancing markets, subject to state-of-charge limits, degradation costs and committed delivery obligations.</li>
        <li><strong>Built so far:</strong> a rolling-horizon dispatch model on 15-minute settlement periods, tested against historical price and activation data from the Finnish mFRR market.</li>
        <li><strong>In progress:</strong> estimating activation probabilities from time-of-day patterns to price reserve bids, and adding price forecasts to drive the bids.</li>
      </ul>
      <p class="tools">Python, mixed-integer optimisation, time-series forecasting, electricity market design, backtesting</p>
    </div>
  </li>
</ol>

<h2 id="skills">Skills</h2>
<dl class="skills">
  <dt>Programming</dt>
  <dd>Python (pandas, NumPy, SciPy, scikit-learn, OOP), MATLAB</dd>
  <dt>Machine learning and statistics</dt>
  <dd>Regression, classification, clustering, time-series forecasting, model validation, Bayesian inference and filtering, physics-informed ML, TensorFlow</dd>
  <dt>Optimisation and estimation</dt>
  <dd>Linear and mixed-integer programming, constrained nonlinear optimisation (CasADi), moving horizon estimation</dd>
  <dt>Data and compute</dt>
  <dd>Large time-series datasets, PySpark, SQL, DuckDB, Microsoft Azure</dd>
  <dt>Engineering practice</dt>
  <dd>Git, code reviews, Docker, Linux, Jupyter; GitHub Copilot and Claude in daily development</dd>
  <dt>Visualisation</dt>
  <dd>Matplotlib, Plotly, QGIS</dd>
  <dt>Working style</dt>
  <dd>Checking models against measured data; explaining model results to non-specialists; working across technical and business teams</dd>
</dl>

<h2 id="languages">Languages</h2>
<ul class="langs">
  <li>English<span>fluent</span></li>
  <li>Gujarati<span>native</span></li>
  <li>Hindi<span>native</span></li>
  <li>German<span>B1</span></li>
  <li>Dutch<span>A2, learning</span></li>
</ul>
