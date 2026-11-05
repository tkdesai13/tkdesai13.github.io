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
| Frequency reserves | Being available to respond, and energy when called | € per MW per hour of availability (FCR, aFRR); € per MWh when activated (aFRR, mFRR) |
| Imbalance | Nothing is bid: the deviation from the reported plan | € per MWh deviated, at TenneT's imbalance price |

The difference between the first two and the last two matters. In day-ahead and intraday the battery chooses what it delivers. In the reserve markets it sells the right for TenneT to decide, within limits. In the imbalance market nobody decides anything in advance: the battery deviates from its plan and accepts a price that is only known afterwards.

## When each market opens and closes

Every market sells the same delivery day, but they close at different times. The chart follows one delivery day, D, from the morning before. Each row shows when bids are accepted, when the gate closes, when results come out, and when the battery has to deliver.

{% include market-gates.html %}

The order matters more than the exact times.[^times] The capacity auctions close before the day-ahead prices are known, so a battery has to decide how much of itself to reserve before it knows what that capacity could have earned in arbitrage. Every later step can only adjust what is left. That sequence is the core of the stacking problem in Part 6.

### Why mFRR has no auction in the chart

In several European countries, manual frequency restoration reserve (mFRR) is a market of its own, with a daily capacity auction next to aFRR. In the Netherlands it matters much less to a battery, and it appears in the chart only as energy bids.

- **TenneT balances mainly with aFRR.** Manual reserve is kept for incidents and large, long-lasting deviations, so it is called rarely.
- **The emergency reserve is moving to energy bids.** TenneT bought this reserve, mFRRda, in a daily auction on the day before delivery. According to its website, an incident reserve based on energy bids takes over from 1 September 2026.
- **Standard mFRR is energy-only.** TenneT joined the European MARI platform on 2 December 2025. It does not expect to request standard mFRR under normal conditions, so Dutch bids mainly answer requests from other system operators.

For a battery this means mFRR pays only when it is activated, and it is activated seldom. There is little or no capacity payment to plan the day around, which is why the stacking problem in this series is built mainly on FCR, aFRR, day-ahead, intraday and imbalance. Part 4 checks whether mFRR energy bids are still worth making.

## What each market takes from the battery

Each market uses the battery's power and energy differently.

- **Day-ahead and intraday** use both. Arbitrage charges the battery when prices are low and empties it when they are high, so it drives the state of charge towards its limits.
- **Frequency reserves** reserve power, but the battery also needs enough energy in store to deliver that power for as long as the product requires, in the direction it was sold. Capacity for FCR, for example, is symmetric: the battery must be able to go both up and down.
- **Imbalance** uses whatever is left in real time, with no commitment in advance.

This is why the markets compete. A battery that has emptied itself into an evening price peak cannot also offer to discharge for TenneT in that hour. Part 2 shows that the energy, not the power, is usually the scarce resource.

## Terms used in this series

<div class="glossary">
<section class="gl-group"><h3>Markets and timing</h3><dl>
<div class="gl-item" id="g-bidding-zone"><dt>Bidding zone</dt><dd>An area with one wholesale price. The Netherlands is one bidding zone.</dd></div>
<div class="gl-item" id="g-mtu"><dt>Market time unit<span class="gl-short">MTU</span></dt><dd>The period one day-ahead or intraday price applies to. In the Netherlands: 15 minutes since 1 October 2025, one hour before that.</dd></div>
<div class="gl-item" id="g-gct"><dt>Gate closure</dt><dd>The deadline for bids in a market. After it, the market clears and the position is fixed.</dd></div>
<div class="gl-item" id="g-pac"><dt>Pay-as-cleared</dt><dd>Every accepted bid receives the same clearing price, whatever it bid. Under pay-as-bid, each bid receives its own price.</dd></div>
<div class="gl-item" id="g-price-taker"><dt>Price-taker</dt><dd>A participant too small to move the price. The 1 MW battery is treated as one throughout.</dd></div>
</dl></section>
<section class="gl-group gl-cap"><h3>Frequency reserves</h3><dl>
<div class="gl-item" id="g-fcr"><dt>FCR<span class="gl-full">Frequency containment reserve</span></dt><dd>The fastest reserve. It reacts automatically to the grid frequency within seconds, in both directions, and is bought in 4-hour blocks.</dd></div>
<div class="gl-item" id="g-afrr"><dt>aFRR<span class="gl-full">Automatic frequency restoration reserve</span></dt><dd>The second line. TenneT's control system steers it continuously to bring the balance back. Upward and downward are sold separately.</dd></div>
<div class="gl-item" id="g-mfrr"><dt>mFRR<span class="gl-full">Manual frequency restoration reserve</span></dt><dd>The slowest reserve, activated on request. In the Netherlands it is called rarely and is paid mainly through energy bids (see above).</dd></div>
<div class="gl-item" id="g-capacity"><dt>Capacity and activation payment</dt><dd>Capacity: € per MW per hour for being available. Activation: € per MWh for energy actually delivered when called.</dd></div>
</dl></section>
<section class="gl-group gl-rt"><h3>Imbalance</h3><dl>
<div class="gl-item" id="g-isp"><dt>Imbalance settlement period<span class="gl-short">ISP</span></dt><dd>The 15 minutes over which TenneT measures and settles imbalance. A year has 35,040 of them.</dd></div>
<div class="gl-item" id="g-regulation-state"><dt>Regulation state</dt><dd>TenneT's label for each ISP: +1 when it regulated up (grid short), &minus;1 down (grid long), 2 both ways, 0 neither.</dd></div>
<div class="gl-item" id="g-imbalance-price"><dt>Imbalance price</dt><dd>The price for deviations from the reported plan, set by the regulation state. Usually one price; two when TenneT regulated both ways.</dd></div>
<div class="gl-item" id="g-passive"><dt>Passive balancing</dt><dd>Deviating from the plan on purpose to help the grid, paid through the imbalance price. TenneT allows and encourages it.</dd></div>
</dl></section>
<section class="gl-group"><h3>The battery and the model</h3><dl>
<div class="gl-item" id="g-soc"><dt>State of charge<span class="gl-short">SoC</span></dt><dd>How full the battery is, as a share of its capacity. The example battery stays between 5% and 95%.</dd></div>
<div class="gl-item" id="g-rte"><dt>Round-trip efficiency</dt><dd>The share of energy that comes back out. At 90%, 1 MWh charged returns 0.9 MWh.</dd></div>
<div class="gl-item" id="g-efc"><dt>Equivalent full cycle</dt><dd>Throughput equal to one full charge and one full discharge. Used to compare how hard strategies work the battery.</dd></div>
<div class="gl-item" id="g-degradation"><dt>Degradation cost</dt><dd>A charge per MWh of throughput that stands in for wear, so the optimiser does not cycle the battery for tiny price differences.</dd></div>
<div class="gl-item" id="g-perfect-foresight"><dt>Perfect foresight</dt><dd>Optimising against prices that are only known afterwards. It gives an upper bound on what any real strategy can earn.</dd></div>
</dl></section>
</div>

## The rest of the series

{% include series-list.html id="bess-nl" %}

[^times]: Checked against the system operators' and exchanges' published rules in November 2026. These rules change regularly; the exact result times of the capacity auctions are left out because I could not confirm them.
