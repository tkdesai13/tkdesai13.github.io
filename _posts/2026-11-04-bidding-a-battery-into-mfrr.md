---
title: "Bidding a battery into the Finnish mFRR market"
summary: Notes from a side project on how to offer a battery's flexibility as manual frequency restoration reserve without running it empty.
tags: [batteries, optimisation, electricity markets]
---

A battery connected to the grid can sell the same megawatt-hour in several places: the day-ahead auction, the intraday market, or one of the balancing markets that the transmission system operator uses to keep frequency at 50 Hz. Deciding where to offer it, and how much to hold back, is an optimisation problem with an awkward feature: the battery has a finite energy content, and in balancing markets you do not decide whether your bid is used. The TSO does.

I have been working on this as an independent side project. This post describes the first piece, a bidding strategy for the Finnish manual frequency restoration reserve (mFRR) energy market, and where I want to take it next. It is a description of the model and its reasoning; backtest results will follow in a later post.

## The market in brief

In mFRR the TSO activates reserve when it needs to correct a sustained imbalance. A battery can offer *up* regulation (discharge, which adds energy to the grid) and *down* regulation (charge, which removes energy). Settlement runs on 15-minute periods, which I will call PTUs.

Two properties of this market shape the strategy:

- **Uniform marginal pricing.** Every activated bid in a period is paid the price of the most expensive activated bid. My bid price therefore decides *whether* I am activated, not *what* I am paid when I am.
- **Up and down are never activated in the same period.** In a given PTU the system is either short or long. This limits the worst case the battery has to be prepared for.

## The battery and its limits

The system I modelled has 8 MWh of storage. Running a battery to 0% or 100% state of charge is bad for its life and leaves no room to react, so I keep the stored energy $$E_t$$ inside a narrower window:

$$
1.5 \text{ MWh} \;\le\; E_t \;\le\; 6.5 \text{ MWh}.
$$

These margins are conservative on purpose. A bid that is activated and cannot be delivered is worse than a bid that was never placed, because it can lead to penalties. The target I set is a failure rate below 5%, where a failure is a period in which the battery cannot deliver the volume it was activated for.

## A 3-1-3-1 bidding pattern

The difficulty with balancing markets is that activations accumulate. If the battery offers up regulation for several periods in a row and is activated in all of them, its energy drops each time. A strategy that only checks one period ahead can walk itself into an empty battery.

My approach is to alternate between bidding and recovering. Within a rolling horizon of 8 PTUs (two hours), three periods are used for bidding and the fourth is reserved for managing the state of charge:

<div class="ptu-strip" role="img" aria-label="Eight 15-minute periods: bid, bid, bid, manage, bid, bid, bid, manage">
  <span class="bid">Bid</span><span class="bid">Bid</span><span class="bid">Bid</span><span class="manage">Manage SOC</span>
  <span class="bid">Bid</span><span class="bid">Bid</span><span class="bid">Bid</span><span class="manage">Manage SOC</span>
</div>

In a manage period the battery places no reserve bids. Instead it charges or discharges on its own schedule to bring the stored energy back towards the middle of the window. The worst case the battery must survive is therefore three consecutive activations in the same direction, not an unbounded run of them. The horizon is re-solved every PTU as new information arrives, so only the first decision is ever executed.

## The optimisation problem

For each period $$t$$ in the horizon, let $$u_t^{\uparrow}$$ and $$u_t^{\downarrow}$$ be the up and down volumes offered (MW), with $$\Delta = 0.25$$ h the period length and $$\eta_c, \eta_d$$ the charging and discharging efficiencies. Let $$\mathcal{B}$$ be the set of bid periods in a block, and $$k$$ any period within it. The robust energy constraints require the battery to stay inside its window even if every bid in the direction that hurts it is activated:

$$
\begin{aligned}
E_k - \frac{\Delta}{\eta_d} \sum_{t \in \mathcal{B},\, t \le k} u_t^{\uparrow} &\;\ge\; E_{\min}, \\
E_k + \Delta\, \eta_c \sum_{t \in \mathcal{B},\, t \le k} u_t^{\downarrow} &\;\le\; E_{\max}, \\
0 \le u_t^{\uparrow},\, u_t^{\downarrow} &\;\le\; \bar{P}.
\end{aligned}
$$

Because up and down never occur in the same period, the two sums never have to be combined within one PTU. The objective is the expected value of the offers:

$$
\max_{u} \; \sum_{t \in \mathcal{B}} \Delta \Big[ p_t^{\uparrow} \big(\hat{\lambda}_t^{\uparrow} - c\big)\, u_t^{\uparrow} \;+\; p_t^{\downarrow} \big(w - \hat{\lambda}_t^{\downarrow} - c\big)\, u_t^{\downarrow} \Big],
$$

where $$p_t$$ is the probability that a bid is activated, $$\hat{\lambda}_t$$ is the expected marginal price given activation, $$c$$ is a degradation cost per MWh of throughput, and $$w$$ is the value I assign to a MWh of energy taken in during down regulation, since that energy can be sold later. Bids are placed in discrete volume steps, which makes this a small mixed-integer program.

## When does activation happen?

The activation probabilities $$p_t$$ carry most of the economics. If up regulation is rarely called at 03:00, there is little reason to reserve energy for it at that hour.

In the historical activation data I have looked at, the pattern by time of day is clear. Up regulation is called most often in the morning ramp (roughly 05:00 to 08:00) and in the late afternoon (15:00 to 17:00). Down regulation is more frequent at night, between about 22:00 and 04:00, when demand is low. The strategy uses this by leaning towards up offers during the morning and afternoon windows and towards down offers at night, which also helps to recharge the battery before the morning peak.

Estimating $$p_t$$ properly, rather than from simple time-of-day frequencies, is the part I am working on now.

## What comes next

mFRR is one market out of several. A battery in the Nordic and Central European markets can also trade in:

- the **day-ahead** auction (SDAC), including block products that span several consecutive hours;
- the **intraday** market, both the auctions and continuous trading;
- the other balancing products, **FCR** and **aFRR**.

The next version of the model offers into five or six of these markets simultaneously, so that a megawatt committed in one is not offered again in another. Two features matter here. The first is block bids that span four to six periods, which match how the battery's energy limits actually bind. The second is retrading. If the battery has sold energy for a later period and a higher price appears for an earlier one, it can deliver in the earlier period and buy back in the intraday market to cover the original commitment. Doing this well needs price forecasts, which is the other open piece of work.

I will write up the backtest against historical Finnish prices and activations once the activation model is in place.
