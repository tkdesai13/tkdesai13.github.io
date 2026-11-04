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
  &nbsp;·&nbsp; <a href="https://www.linkedin.com/in/{{ site.author.linkedin }}">LinkedIn</a>
  &nbsp;·&nbsp; <a href="https://scholar.google.com/citations?user={{ site.author.scholar }}">Google Scholar</a>
  &nbsp;·&nbsp; {{ site.author.location }}
</p>

## Profile

I build machine learning and forecasting models and take them from first analysis to use in operations.
At Gradyent I forecast heat demand from smart heat meter data and deploy the models as digital twins for
district heating operators. My PhD at TU Delft was on forecasting and state estimation for battery systems,
using streaming field data in Azure.

## Experience

<div class="cv-entry">
  <span class="role">Solutions Engineer</span>
  <span class="dates">08/2025 – present</span>
  <span class="org">Gradyent, Rotterdam</span>
  <span class="focus">Digital twin development and energy system optimisation</span>
  <ul>
    <li>Build heat demand forecasts from smart heat meter data and use them as input to dispatch optimisation that schedules boilers, heat pumps and thermal storage against day-ahead prices.</li>
    <li>Turn operator sensor and geo data into calibrated network models, check them against measured flows and temperatures, and deploy them as digital twins inside client operations.</li>
    <li>Run scenario studies on the deployed models (supply mix, network expansion, storage sizing) over multi-year horizons, and work out what the results mean for the operator's costs and investment decisions.</li>
    <li>Present findings to clients' engineering and asset teams, and revise the assumptions when their operating experience contradicts the model.</li>
  </ul>
  <span class="tools">Python (pandas, NumPy), Git, code reviews, Jira, forecasting, optimisation, model deployment</span>
</div>

<div class="cv-entry">
  <span class="role">PhD Candidate</span>
  <span class="dates">03/2021 – 05/2025</span>
  <span class="org">TU Delft, Delft</span>
  <span class="focus">Machine learning and forecasting models for batteries</span>
  <ul>
    <li>Developed a load forecasting model from temporal usage patterns; trained and compared several regression approaches on out-of-sample error to choose the one suited to the application.</li>
    <li>Developed a physics-informed machine learning model, trained with constrained multi-objective optimisation, that estimates battery state from sparse, unlabelled field data and holds up on data not seen in training.</li>
    <li>Worked with an industry partner to build and validate models on large volumes of streaming field data in Azure, processed with PySpark, covering data cleaning, feature engineering, model training and evaluation.</li>
    <li>Moving horizon estimation for joint battery state and parameter estimation (see publications).</li>
  </ul>
  <span class="tools">Python (pandas, NumPy, SciPy, scikit-learn), MATLAB, time-series forecasting, Bayesian filtering, Azure, PySpark</span>
</div>

<div class="cv-entry">
  <span class="role">Master Thesis</span>
  <span class="dates">12/2019 – 07/2020</span>
  <span class="org">Bertrandt Ingenieurbüro GmbH, Neckarsulm</span>
  <span class="focus">Machine learning model for emission forecasting</span>
  <ul>
    <li>Developed time-series regression models to predict ammonia and NOx emissions in automotive after-treatment systems, with prediction errors within ±5%.</li>
    <li>Handled the project from problem definition and proposal to technical documentation and presenting results to industrial partners.</li>
  </ul>
  <span class="tools">Python, Git, time-series modelling, statistical analysis, SQL, Azure</span>
</div>

<div class="cv-entry">
  <span class="role">Student Assistant</span>
  <span class="dates">04/2019 – 11/2019</span>
  <span class="org">Bertrandt Ingenieurbüro GmbH, Neckarsulm</span>
  <span class="focus">Feature engineering and anomaly detection</span>
  <ul>
    <li>Implemented feature selection with multivariate statistics and clustering, reducing data dimensionality by 50% while keeping 95% of the variance, and helped integrate the models into production software.</li>
    <li>Developed regression-based models for point and contextual anomaly detection in large time-series datasets.</li>
  </ul>
  <span class="tools">Python (OOP), SQL, software development, Git, Jira</span>
</div>

## Education

<div class="cv-entry">
  <span class="role">PhD, Machine Learning and Forecasting for Battery Systems</span>
  <span class="dates">03/2021 – 05/2025</span>
  <span class="org">TU Delft · supervisor Dr. Riccardo M. G. Ferrari</span>
  <ul>
    <li>Teaching assistant for the master's control systems lab.</li>
    <li>Supervised MSc students during their thesis projects.</li>
  </ul>
</div>

<div class="cv-entry">
  <span class="role">MSc, International Automotive Engineering</span>
  <span class="dates">09/2017 – 08/2020</span>
  <span class="org">FH Aachen University of Applied Sciences</span>
  <ul>
    <li>Key courses: mathematical optimisation, machine learning, control theory. GPA 8.5/10.</li>
  </ul>
</div>

<div class="cv-entry">
  <span class="role">BE, Mechanical Engineering</span>
  <span class="dates">06/2012 – 04/2016</span>
  <span class="org">The Maharaja Sayajirao University of Baroda, Vadodara</span>
  <ul>
    <li>Research on a rotating-media liquid-air contacting device (published in <em>Energy Procedia</em>, 2017). GPA 9.01/10.</li>
  </ul>
</div>

## Publications

Full list on [Google Scholar](https://scholar.google.com/citations?user={{ site.author.scholar }}).

**Journal articles**

1. **T. Desai**, F. Oliva, D. Carnevale, R. M. G. Ferrari. "Adaptive multirate moving horizon estimator for real-time battery state and parameter estimation." *IEEE Transactions on Control Systems Technology*, 2026.
2. **T. Desai**, A. J. Gallo, R. M. G. Ferrari. "Multi timescale battery modeling: Integrating physics insights to data-driven model." *Applied Energy* 393, 126040, 2025. [doi](https://doi.org/10.1016/j.apenergy.2025.126040)
3. J. R. Mehta, **T. K. Desai**, A. K. Patel, H. B. Diyora, A. S. Rabadiya. "Preliminary investigations on a novel rotating media liquid-air contacting device without liquid pool." *Energy Procedia* 109, 167–173, 2017.

**Conference papers**

1. **T. Desai**, R. M. G. Ferrari. "Separating multiscale battery dynamics and predicting multi-step ahead voltage simultaneously through a data-driven approach." *IEEE Vehicle Power and Propulsion Conference (VPPC)*, 2023. [arXiv](https://arxiv.org/abs/2310.14289)
2. **T. Desai**, F. Oliva, R. M. G. Ferrari, D. Carnevale. "Real-time battery state of charge and parameters estimation through multi-rate moving horizon estimator." *IFAC World Congress*, IFAC-PapersOnLine 56(2), 6124–6129, 2023. [doi](https://doi.org/10.1016/j.ifacol.2023.10.709) · [arXiv](https://arxiv.org/abs/2310.14332)

**Preprints**

1. **T. Desai**, R. M. G. Ferrari. "Forecasting battery capacity with dynamic transitions in operational conditions." SSRN 5482169.

## Projects

<div class="cv-entry">
  <span class="role">Battery storage bidding and dispatch optimiser</span>
  <span class="dates">2025 – present</span>
  <span class="org">Independent project, work in progress</span>
  <ul>
    <li>An optimiser that bids and dispatches a battery across day-ahead, intraday and balancing markets, subject to state-of-charge limits, degradation costs and committed delivery obligations.</li>
    <li><strong>Built so far:</strong> a rolling-horizon dispatch model on 15-minute settlement periods, tested against historical price and activation data from the Finnish mFRR market.</li>
    <li><strong>In progress:</strong> estimating activation probabilities from time-of-day patterns to price reserve bids, and adding price forecasts to drive the bids.</li>
  </ul>
  <span class="tools">Python, mixed-integer optimisation, time-series forecasting, electricity market design, backtesting</span>
</div>

## Skills

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

## Languages

English (fluent) · Gujarati (native) · Hindi (native) · German (B1) · Dutch (A2, learning)
