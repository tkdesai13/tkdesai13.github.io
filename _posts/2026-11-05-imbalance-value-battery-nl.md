---
title: "Imbalance: is it worth deviating from the schedule?"
summary: The value of the Dutch imbalance market to a 1 MW / 2 MWh battery in 2025, bounded by a perfect-foresight ceiling and a persistence floor.
date: 2026-11-05 00:30:00 +0100
icon: market
series: bess-nl
part: 3
tags: [batteries, electricity markets, optimisation]
---

Part 2 set the baseline. Day-ahead arbitrage alone earns about €48,000 a year for the 1 MW / 2 MWh battery, but the value is uneven: the first 250 kW of power earns €92.8 per kW per year, the last 250 kW only €15.2. This part asks whether some of that power would earn more in the imbalance market.

The imbalance market is not a market in the usual sense. Nothing is bid. The battery's balance responsible party reports a schedule to TenneT, and any deviation from it is settled at the imbalance price, which TenneT sets for every 15-minute imbalance settlement period (ISP).[^isp] In the Netherlands a deliberate deviation that helps the system is allowed, and TenneT publishes balancing volumes and prices in near real time so that parties can respond to them. This is called passive balancing. A battery that discharges when the grid is short, or charges when it is long, is usually settled at a price that rewards it for doing so.

The power used for this cannot also be used for day-ahead arbitrage, so the two compete. The study below asks how much the imbalance market is worth, and whether it is worth reserving part of the battery for it. The results are preliminary; the open checks are listed at the end.

## Data

Imbalance settlement prices and regulation states come from TenneT's API: 35,028 ISPs for 2025. Day-ahead prices and the battery are as in Part 2.

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

Running the same linear program on imbalance prices, selling at the surplus price and buying at the shortage price, gives a ceiling of **€180 per kW per year**, against €15–93 for day-ahead. This is not achievable: imbalance prices are only published after each ISP has ended, so nobody trades with that foresight.

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

The comparison that matters is per kW, against the day-ahead values from Part 2. To beat the last 250 kW of day-ahead trading (€15.2/kW-year), imbalance trading needs 8.4% of the ceiling. To beat the first 250 kW (€92.8/kW-year), it needs 51.6%.

So reserving the marginal slice of the battery for imbalance is justified even with a forecast that does no real work: persistence clears that hurdle five times over. Replacing day-ahead trading entirely is not justified yet, as persistence falls about 8 percentage points short, but that gap looks small enough for a modest classifier of the regulation state to close. Read naively, the chart suggests keeping only the first 250 kW for day-ahead. That reading is premature until the battery's energy limit is in the simulation.

One methodological note. My first version of the persistence calculation applied the decision made from the state of ISP $$t$$ to the prices of ISP $$t$$ itself, which is knowing the current state rather than forecasting the next one. It reported 80.8% capture, nearly double the correct figure. A forecast must be settled against the prices of the period after the decision, and that shift is now checked by a test.

<aside class="assumes" markdown="1">
<p class="assumes-title">What this assumes</p>

- **Unlimited energy.** Both the ceiling and the persistence result assume the reserved power is always available. A battery that deviates in the same direction for several ISPs runs full or empty, so the real value is lower. This is the most important simplification here.
- **The ceiling has perfect foresight.** It optimises against imbalance prices that are only published after each ISP has ended. No strategy can reach it.
- **The persistence floor knows the current state.** It assumes the regulation state of an ISP is known by the start of the next one. TenneT's near-real-time data make this close to true, but not exact.
- **Deviations are measured against the day-ahead schedule.** Intraday trading, which could move that schedule, is left for Part 5.
- **A price-taker.** A 1 MW deviation is assumed not to change TenneT's activations or the imbalance price.
- **One year, 2025,** with the same degradation cost and efficiency as Part 2, and no network tariffs or fees.
</aside>

## Checks still open

These numbers are not final. Before I would quote them:

- **An energy-constrained simulation.** This is the next step, and it decides whether the conclusion holds.
- **A confidence interval.** Because a small number of ISPs hold much of the value, the point estimate is sensitive to the tails. A bootstrap by day will give a range.
- **The reserve duration.** How much energy to hold per kW of reserved power, from a sweep of the sustain duration at fixed power.
- **The joint cost of reserving power and energy.** Part 2 measured the two separately. Their sum, €9,297 a year for 250 kW held for 30 minutes, is an upper bound.
- **The regime change.** The fourth quarter of 2025, with 15-minute day-ahead products, may behave differently from January to September, and it is the more relevant period for the future.

Part 8 looks at forecasts better than persistence, and Part 6 at combining imbalance with the other markets. I will update this post when the energy-constrained results are in.

[^isp]: An ISP is the 15-minute interval over which TenneT settles imbalances. A full year has 35,040; the last ISP of each month is missing from my download, which does not affect the results here.
[^single]: In 2025 the Netherlands settled at a single imbalance price in 72.7% of ISPs, and at two prices almost only in state 2.
