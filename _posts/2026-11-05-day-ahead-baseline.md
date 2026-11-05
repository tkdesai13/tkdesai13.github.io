---
title: "Day-ahead arbitrage: the baseline"
summary: What day-ahead arbitrage alone earns a 1 MW / 2 MWh battery on 2025 Dutch prices, and what each slice of its power and energy is worth.
date: 2026-11-05 00:20:00 +0100
icon: battery
series: bess-nl
part: 2
tags: [batteries, electricity markets, optimisation]
---

The day-ahead auction is the simplest market a battery can use. Before noon on the day before delivery it submits bids, and shortly after the auction clears it knows the price of every quarter-hour of the next day. Arbitrage then means charging in the cheap periods and discharging in the expensive ones.

This part sets the baseline that every later market is measured against. It asks two questions of 2025 data: how much does day-ahead arbitrage alone earn, and how is that value spread over the battery's power and its energy? The second question matters more than the first. A battery that wants to sell part of itself in another market has to take it from somewhere, and the cost of doing so is what day-ahead trading loses.

## Data and model

Day-ahead prices for the Dutch bidding zone come from the Energy-Charts API. They are hourly until 30 September 2025 and quarter-hourly from 1 October.

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

where $$\lambda_t$$ is the day-ahead price, $$e_t$$ the stored energy and $$\Delta t$$ the length of a period. Each day starts from the energy the previous day ended with. The problem is solved with CasADi.

The optimiser sees all of a day's prices at once. A trader does not: bids are submitted before the auction clears, and the prices are only known afterwards. The figures below are therefore an upper bound on what day-ahead arbitrage can earn. How much of it survives realistic information is the subject of Part 7.

## A bug worth describing

On 1 October 2025 the Dutch day-ahead market moved from hourly to 15-minute products. My first backtest assumed one-hour steps throughout, so on the 15-minute days the optimiser treated each quarter-hour price as if it lasted an hour. It could hold 1 MW for a full hour in every 15-minute step, and revenue on those days came out roughly four times too high. About 21.5% of the reported annual profit came from these mis-modelled days. Inferring the step length for each day from its timestamps fixed it, and the backtest now reports any day whose number of steps does not match.

## What day-ahead arbitrage earns

With the step length corrected, day-ahead arbitrage alone earns **€47,975 a year** net of degradation, at about 358 full cycles. At a more conservative degradation cost of €28/MWh it falls to €37,607.

The more useful result is how this value is spread over the battery's power and energy. Running the backtest at lower power limits shows that power has strongly diminishing returns:

| Power limit | Net €/year | Marginal €/kW per year |
|---|---:|---:|
| 250 kW | 23,210 | 92.8 |
| 500 kW | 37,226 | 56.1 |
| 750 kW | 44,180 | 27.8 |
| 1000 kW | 47,975 | 15.2 |

Half the power earns 78% of the profit. The last 250 kW is only used in the periods with the widest spreads, so giving it up costs €3,795 a year, or €15.2 per kW.

Energy behaves differently. Narrowing the state-of-charge band costs about €44 per kWh per year, almost regardless of how much is reserved:

| Energy reserved per side | Usable band | Net €/year | Cost €/kWh per year |
|---|---:|---:|---:|
| 0 | 1,800 kWh | 47,975 | |
| 125 kWh | 1,550 kWh | 42,473 | 44.0 |
| 250 kWh | 1,300 kWh | 36,957 | 44.1 |
| 500 kWh | 800 kWh | 24,223 | 47.5 |

The reason is that power and energy are used differently. Full power is needed only at the sharpest price peaks and troughs, so the last slice of it sits idle most of the day. The energy band, by contrast, sets the depth of every cycle, so each reserved kWh makes every cycle shallower, not only the marginal one.

For a battery that wants to trade in a second market, this is the main result of this part: energy, not power, is the expensive resource. A second market that needs power but little energy can be added cheaply. One that needs the battery to hold energy in reserve has to earn more than €44 per kWh per year to pay for it.

These marginal values are the hurdles for the rest of the series. Part 3 compares them with the imbalance market, and Part 4 with frequency reserves.

<aside class="assumes" markdown="1">
<p class="assumes-title">What this assumes</p>

- **Prices known in advance.** The optimiser uses the day-ahead prices that cleared, not a forecast of them, so the results are an upper bound. Part 7 measures the gap.
- **One day at a time.** Each day is optimised on its own, starting where the previous day ended. Energy left at midnight has no value in the model, so the battery tends to end each day empty. Optimising across days could only add to the result.
- **A price-taker.** A 1 MW battery is assumed not to move the clearing price.
- **One year.** All results are for 2025. The last quarter, with 15-minute products, may behave differently from the first three.
- **Linear degradation** at €20 per MWh of throughput, with €28 as a sensitivity. Real ageing depends on depth of discharge, temperature and state of charge.
- **Constant efficiency** of 90% round trip, independent of power and state of charge.
- **No network tariffs, taxes or exchange fees.** These reduce every figure here, and arbitrage with small spreads most.
</aside>

[^deg]: A battery costing €500,000 that lasts 4,500 full cycles gives about €28/MWh on this basis, so €20 is at the optimistic end.
