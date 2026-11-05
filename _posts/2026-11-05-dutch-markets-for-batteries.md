---
title: "The markets a battery can trade in"
summary: Who does what in the Dutch electricity markets, when bids are due, and how each market pays a battery.
date: 2026-11-05 00:10:00 +0100
icon: grid
series: bess-nl
part: 1
tags: [electricity markets, batteries]
---

This series follows a side project: working out how a grid-scale battery in the Netherlands should earn money, one market at a time, using 2025 data. Throughout, the example is a 1 MW / 2 MWh battery. It can charge or discharge at up to 1 MW and stores up to 2 MWh, so it can run at full power for about two hours.

Before any optimisation, it helps to have a map. This post describes the markets a battery can use, who runs them, when each one closes, and how each one pays. The later parts take the markets one by one and put numbers on them.

## Who does what

<figure class="actors" aria-label="Diagram: the exchanges trade energy with the battery operator; the battery operator provides reserves to TenneT and settles imbalance with TenneT.">
<div class="actor"><b>Exchanges</b><span>EPEX SPOT, Nord Pool. Run the day-ahead and intraday markets.</span></div>
<div class="link both"><span>energy trades</span></div>
<div class="actor mid"><b>Battery operator</b><span>Trades energy as, or through, a balance responsible party (BRP). Sells reserves as, or through, a balancing service provider (BSP).</span></div>
<div class="link both"><span>reserves and imbalance</span></div>
<div class="actor"><b>TenneT</b><span>Keeps the grid in balance. Buys and activates reserves, settles imbalance.</span></div>
</figure>

Four kinds of party matter here.

- **The exchanges**, EPEX SPOT and Nord Pool, run the day-ahead and intraday markets, where electricity is traded for delivery in a given quarter-hour. These markets are coupled across Europe: one algorithm clears all bidding zones together, subject to the transmission capacity between them.
- **TenneT**, the transmission system operator, keeps supply and demand in balance in real time. It buys reserves in advance, activates them when needed, and settles the imbalance of everyone who deviated from their plan.
- **A balance responsible party (BRP)** is accountable for the balance of a portfolio of grid connections. Every connection belongs to one. A BRP reports its planned positions to TenneT and pays or receives the imbalance price on any deviation.
- **A balancing service provider (BSP)** is prequalified to deliver reserves to TenneT. Only BSPs can sell frequency reserves.

A battery operator usually needs both roles, either directly or through a partner that holds them: BRP for energy trading and imbalance, BSP for reserves.

## Four ways to be paid

A battery sells two physical things, power (MW) and energy (MWh), and the markets pay for them in different ways.

| Market | What the battery sells | How it is paid |
|---|---|---|
| Day-ahead | Energy for each quarter-hour of the next day | € per MWh, at one clearing price per quarter-hour |
| Intraday | Changes to that energy position | € per MWh, in three auctions or by continuous trading |
| Frequency reserves | Being available to respond | € per MW per hour of availability; for aFRR and mFRR also € per MWh when activated |
| Imbalance | Nothing is bid: the deviation from the reported plan | € per MWh deviated, at TenneT's imbalance price |

The difference between the first two and the last two matters. In day-ahead and intraday the battery chooses what it delivers. In the reserve markets it sells the right for TenneT to decide, within limits. In the imbalance market nobody decides anything in advance: the battery deviates from its plan and accepts a price that is only known afterwards.

## When each market opens and closes

Every market sells the same delivery day, but they close at different times. The chart follows one delivery day, D, from the morning before. Each row shows when bids are accepted, when the gate closes, when results come out, and when the battery has to deliver.

{% include market-gates.html %}

The order matters more than the exact times.[^times] The capacity auctions close before the day-ahead prices are known, so a battery has to decide how much of itself to reserve before it knows what that capacity could have earned in arbitrage. Every later step can only adjust what is left. That sequence is the core of the stacking problem in Part 6.

## What each market takes from the battery

Each market uses the battery's power and energy differently.

- **Day-ahead and intraday** use both. Arbitrage charges the battery when prices are low and empties it when they are high, so it drives the state of charge towards its limits.
- **Frequency reserves** reserve power, but the battery also needs enough energy in store to deliver that power for as long as the product requires, in the direction it was sold. Capacity for FCR, for example, is symmetric: the battery must be able to go both up and down.
- **Imbalance** uses whatever is left in real time, with no commitment in advance.

This is why the markets compete. A battery that has emptied itself into an evening price peak cannot also offer to discharge for TenneT in that hour. Part 2 shows that the energy, not the power, is usually the scarce resource.

## Terms used in this series

<dl class="glossary">
<dt id="g-bidding-zone">Bidding zone</dt>
<dd>An area with a single wholesale price. The Netherlands is one bidding zone.</dd>
<dt id="g-mtu">Market time unit (MTU)</dt>
<dd>The period one price applies to in the day-ahead and intraday markets: 15 minutes in the Netherlands since 1 October 2025, one hour before.</dd>
<dt id="g-isp">Imbalance settlement period (ISP)</dt>
<dd>The 15-minute period over which TenneT measures and settles imbalance. A year has 35,040.</dd>
<dt id="g-gct">Gate closure time</dt>
<dd>The deadline for bids in a market.</dd>
<dt id="g-pac">Pay-as-cleared</dt>
<dd>Every accepted bid receives the same clearing price, regardless of its own bid price. The alternative, pay-as-bid, pays each bid its own price.</dd>
<dt id="g-fcr">FCR (frequency containment reserve)</dt>
<dd>The fastest reserve. It responds automatically to deviations of the grid frequency from 50 Hz, within seconds, in both directions.</dd>
<dt id="g-afrr">aFRR (automatic frequency restoration reserve)</dt>
<dd>Activated automatically by TenneT's control system to restore the balance after a disturbance, upward or downward separately.</dd>
<dt id="g-mfrr">mFRR (manual frequency restoration reserve)</dt>
<dd>Slower reserve activated on request. Standard mFRR in the Netherlands runs through the European MARI platform since 2 December 2025; TenneT also contracts emergency reserve, called mFRRda.</dd>
<dt id="g-capacity">Capacity and activation payments</dt>
<dd>A capacity payment is for being available (€ per MW per hour). An activation payment is for energy actually delivered when called (€ per MWh).</dd>
<dt id="g-regulation-state">Regulation state</dt>
<dd>TenneT's label for each quarter-hour: whether it regulated up (the grid was short), down (the grid was long), both, or neither. It determines the imbalance price.</dd>
<dt id="g-imbalance-price">Imbalance price</dt>
<dd>The price at which deviations from the reported plan are settled. In most quarter-hours there is a single price; when TenneT regulated in both directions there are two.</dd>
<dt id="g-soc">State of charge</dt>
<dd>How full the battery is, as a fraction of its capacity. The example battery is kept between 5% and 95%.</dd>
<dt id="g-efc">Equivalent full cycle</dt>
<dd>Throughput equal to fully charging and fully discharging the battery once. Used to compare how hard strategies work the battery.</dd>
<dt id="g-degradation">Degradation cost</dt>
<dd>A charge per MWh of throughput that stands in for the wear on the battery, so the optimiser does not cycle it for tiny price differences.</dd>
<dt id="g-perfect-foresight">Perfect foresight</dt>
<dd>Optimising against prices that are only known afterwards. It gives an upper bound on what any real strategy can earn.</dd>
<dt id="g-price-taker">Price-taker</dt>
<dd>A participant too small to move the price. A 1 MW battery is treated as one throughout.</dd>
</dl>

## The rest of the series

{% include series-list.html id="bess-nl" %}

[^times]: Checked against the system operators' and exchanges' published rules in November 2026. These rules change regularly; the exact result times of the capacity auctions are left out because I could not confirm them.
