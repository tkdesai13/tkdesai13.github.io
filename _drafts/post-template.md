---
title: "Post title"
summary: One sentence shown under the title on the blog page.
tags: [optimisation]
# math: false   # uncomment to skip loading MathJax on this post
---

Drafts in this folder are NOT published. To publish, move the file to `_posts/`
and rename it to `YYYY-MM-DD-short-title.md`, e.g. `2026-11-20-mhe-for-batteries.md`.

## Section heading

Body text in Markdown. Inline maths: $a^2 + b^2 = c^2$. Display maths:

$$
\min_{u} \sum_{k=0}^{N-1} \ell(x_k, u_k) \quad \text{s.t.} \quad x_{k+1} = f(x_k, u_k)
$$

Figures: put images in `assets/img/` and use

![Short alt text]({{ '/assets/img/example.png' | relative_url }})
*Figure 1. Caption text.*

References can be plain links or numbered notes, e.g. Rawlings et al. (2017), *Model Predictive Control: Theory, Computation, and Design*.

Margin notes: put [^1] after a word, and the note text anywhere below, like the line at the end of this file.
They appear in the right margin on wide screens and under the paragraph on phones.

[^1]: This is a margin note.
