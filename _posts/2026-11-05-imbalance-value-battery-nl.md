---
title: "What is the Dutch imbalance market worth to a battery? Early results"
summary: Day-ahead arbitrage against imbalance trading for a 1 MW / 2 MWh battery, using 2025 Dutch market data.
date: 2026-11-05 00:30:00 +0100
icon: market
tags: [batteries, electricity markets, optimisation]
---

A grid-connected battery in the Netherlands has two straightforward ways to earn from price differences. It can trade in the day-ahead auction, where prices for every period of the next day are fixed in advance. Or it can deviate from its schedule in real time and settle the deviation at the imbalance price, which TenneT sets every 15 minutes depending on whether the grid is short or long.

The two compete for the same battery. Power and energy held back for the imbalance market cannot be used for day-ahead arbitrage. This post describes a study from a side project that asks two questions of 2025 data: how much is the imbalance market worth to a 1 MW / 2 MWh battery, and is it worth reserving part of the battery for it?

The results are preliminary. Several checks are still open, and I list them at the end.

## Data and model

Day-ahead prices for the Dutch bidding zone come from the Energy-Charts API, and imbalance settlement prices from TenneT's API: 35,028 imbalance settlement periods (ISPs) for 2025.[^isp]

The battery is 1 MW / 2 MWh with 90% round-trip efficiency, kept between 5% and 95% state of charge. Degradation is charged at €20 per MWh of throughput, counting both charging and discharging.[^deg]

For each day, a linear program chooses the discharging power $$p^{\text{dis}}_t$$ and charging power $$p^{\text{ch}}_t$$ that maximise the net revenue

$$
\max_{p} \; \sum_t \Big[ \lambda_t \big(p_t^{\text{dis}} - p_t^{\text{ch}}\big) - c_{\text{deg}} \big(p_t^{\text{dis}} + p_t^{\text{ch}}\big) \Big] \Delta t
$$

subject to the energy balance and limits

$$
\begin{aligned}
e_{t+1} &= e_t - \frac{p_t^{\text{dis}}}{\eta_d}\,\Delta t + \eta_c\, p_t^{\text{ch}}\,\Delta t, \\
E^{\min} &\le e_t \le E^{\max}, \qquad 0 \le p_t^{\text{dis}},\, p_t^{\text{ch}} \le P^{\max},
\end{aligned}
$$

where $$\lambda_t$$ is the price and $$\Delta t$$ the length of a period. It is solved with CasADi. Because day-ahead prices are known before delivery, optimising against the actual prices is a fair model of what a trader could do.

## A bug worth describing

On 1 October 2025 the Dutch day-ahead market moved from hourly to 15-minute products. My first backtest assumed one-hour steps throughout, so on the 15-minute days the optimiser treated each quarter-hour price as if it lasted an hour. It could hold 1 MW for a full hour in every 15-minute step, and revenue on those days came out roughly four times too high. About 21.5% of the reported annual profit came from these mis-modelled days. Inferring the step length for each day from the timestamps fixed it.

## Day-ahead baseline

With the step length corrected, day-ahead arbitrage alone earns **€47,975 a year** net of degradation, at about 358 full cycles. At a more conservative degradation cost of €28/MWh it falls to €37,607.

The more useful result is how this value is spread over the battery's power and energy. Running the backtest at lower power limits shows that power has strongly diminishing returns:

| Power limit | Net €/year | Marginal €/kW per year |
|---|---:|---:|
| 250 kW | 23,210 | 92.8 |
| 500 kW | 37,226 | 56.1 |
| 750 kW | 44,180 | 27.8 |
| 1000 kW | 47,975 | 15.2 |

Half the power earns 78% of the profit. The last 250 kW is only used in the hours with the widest spreads, so giving it up costs €3,795 a year.

Energy behaves differently. Narrowing the state-of-charge band costs about €44 per kWh per year, almost regardless of how much is reserved:

| Energy reserved per side | Usable band | Net €/year | Cost €/kWh per year |
|---|---:|---:|---:|
| 0 | 1,800 kWh | 47,975 | |
| 125 kWh | 1,550 kWh | 42,473 | 44.0 |
| 250 kWh | 1,300 kWh | 36,957 | 44.1 |
| 500 kWh | 800 kWh | 24,223 | 47.5 |

Every reserved kWh makes every cycle shallower, not only the marginal one. For a battery that wants to trade in a second market, energy rather than power is the expensive resource.

## How the imbalance price behaves

For every ISP, TenneT publishes a regulation state: −1 when the system is long and downward regulation is used, +1 when it is short, 0 when no regulation was needed, and 2 when both directions were activated. A battery that deviates from its day-ahead schedule gains, per MWh,

$$
g^{\text{sell}}_t = \lambda^{\text{surplus}}_t - \lambda^{\text{DA}}_t, \qquad g^{\text{buy}}_t = \lambda^{\text{DA}}_t - \lambda^{\text{shortage}}_t,
$$

when it sells more or buys more than scheduled. The averages for 2025:

| Regulation state | Share of ISPs | Gain from selling (€/MWh) | Gain from buying (€/MWh) |
|---|---:|---:|---:|
| −1, system long | 35.4% | −52.8 | +52.8 |
| 0, stable | 1.3% | −16.6 | +16.6 |
| +1, system short | 36.0% | +51.4 | −51.4 |
| 2, both directions | 27.3% | −51.9 | −30.5 |

Four things stand out.

- **The system is almost never balanced.** State 0 occurs in 1.3% of ISPs, so imbalance prices differ from day-ahead prices nearly all the time. The question is the size of the spread, not how often it appears.
- **In states −1, 0 and +1 there is a single price.**[^single] The gains from selling and buying are then equal and opposite, so the state alone decides which way to deviate. Forecasting becomes a classification of the regulation state rather than a regression on the price.
- **State 2 behaves like a bid–ask spread.** Two prices apply, with a median gap of €52/MWh, and on average both directions lose money. The sensible action there is to stay on schedule.
- **The value is concentrated.** The top 1% of ISPs hold 48.6% of the value of discharging but only 13.2% of the value of charging. The median event lasts two ISPs, or 30 minutes.

## A ceiling and a floor

Running the same linear program on imbalance prices, selling at the surplus price and buying at the shortage price, gives a ceiling of **€180 per kW per year**, against €15–93 for day-ahead. This is not achievable: imbalance prices are published about 30 minutes after each ISP ends, so nobody trades with that foresight.

For a floor I used the simplest forecast available, persistence. Assume the next ISP has the same regulation state as the current one; sell if it is +1, buy if it is −1 or 0, and do nothing in state 2. Each decision is settled at the prices of the following ISP. Persistence picks the right direction 63.3% of the time and captures **43.7%** of the perfect-foresight value, about €79 per kW per year.

<figure class="hbars" aria-label="Bar chart: day-ahead value of each 250 kW slice of battery power is 93, 56, 28 and 15 euro per kW per year. Imbalance value is 79 with a persistence forecast and 180 with perfect foresight.">
<div class="hb-grid">
<span class="hb-label r1">First 250 kW</span><span class="hb-track r1"><span class="hb-bar" style="width:48.9%"></span></span><span class="hb-val r1">93</span>
<span class="hb-label r2">Second 250 kW</span><span class="hb-track r2"><span class="hb-bar" style="width:29.5%"></span></span><span class="hb-val r2">56</span>
<span class="hb-label r3">Third 250 kW</span><span class="hb-track r3"><span class="hb-bar" style="width:14.6%"></span></span><span class="hb-val r3">28</span>
<span class="hb-label r4">Last 250 kW</span><span class="hb-track r4"><span class="hb-bar" style="width:8.0%"></span></span><span class="hb-val r4">15</span>
<span class="hb-overlay"><span class="hb-mark floor" style="left:41.4%"></span><span class="hb-mark ceil" style="left:94.7%"></span></span>
<span class="hb-axis"><span style="left:0%">0</span><span style="left:26.3%">50</span><span style="left:52.6%">100</span><span style="left:78.9%">150</span></span>
</div>
<div class="hb-legend"><span><i class="sw-bar"></i>Day-ahead, value of each 250 kW slice</span><span><i class="sw-floor"></i>Imbalance with a persistence forecast (79)</span><span><i class="sw-ceil"></i>Imbalance with perfect foresight (180)</span></div>
<figcaption>Value in € per kW per year, 2025 Dutch prices, 1 MW / 2 MWh battery, degradation €20/MWh. The imbalance figures ignore the battery's energy limit, so they are optimistic.</figcaption>
</figure>

The comparison that matters is per kW. To beat the last 250 kW of day-ahead trading (€15.2/kW-year), imbalance trading needs 8.4% of the ceiling. To beat the first 250 kW (€92.8/kW-year), it needs 51.6%.

So reserving the marginal slice of the battery for imbalance is justified even with a forecast that does no real work: persistence clears that hurdle five times over. Replacing day-ahead trading entirely is not justified yet, as persistence falls about 8 percentage points short, but that gap looks small enough for a modest classifier of the regulation state to close. Read naively, the chart suggests keeping only the first 250 kW for day-ahead. That reading is premature until the battery's energy limit is in the simulation.

One methodological note. My first version of the persistence calculation applied the decision made from the state of ISP $$t$$ to the prices of ISP $$t$$ itself, which is knowing the current state rather than forecasting the next one. It reported 80.8% capture, nearly double the correct figure. A forecast must be settled against the prices of the period after the decision, and that shift is now checked by a test.

## What is still missing

These numbers are not final. Before I would quote them:

- **The battery's energy limit.** The 43.7% assumes the reserved power is always available. Consecutive deviations in the same direction drain the battery, so the real figure is lower. An energy-constrained simulation is the next step, and it decides whether the conclusion holds.
- **A confidence interval.** Because a small number of ISPs hold much of the value, the point estimate is sensitive to the tails. A bootstrap by day will give a range.
- **The reserve duration.** How much energy to hold per kW of reserved power, from a sweep of the sustain duration at fixed power.
- **The joint cost of reserving power and energy.** I measured the two separately. Their sum, €9,297 a year for 250 kW held for 30 minutes, is an upper bound.
- **The regime change.** The fourth quarter of 2025, with 15-minute day-ahead products, may behave differently from January to September, and it is the more relevant period for the future.
- **Degradation.** €20/MWh is at the optimistic end of the plausible range.

The study also leaves out revenue from the balancing capacity markets (FCR, aFRR, mFRR), joint optimisation of day-ahead and imbalance positions, forecasts better than persistence, and any year other than 2025. I will update this post when the energy-constrained results are in.

[^isp]: An ISP is the 15-minute interval over which TenneT settles imbalances. A full year has 35,040; the last ISP of each month is missing from my download, which does not affect the results here.
[^deg]: A battery costing €500,000 that lasts 4,500 full cycles gives about €28/MWh on this basis, so €20 is at the optimistic end.
[^single]: In 2025 the Netherlands settled at a single imbalance price in 72.7% of ISPs, and at two prices almost only in state 2.
