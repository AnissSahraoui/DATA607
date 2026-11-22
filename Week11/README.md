# DATA 607 — Week 11

Two assignments: a TidyVerse CREATE vignette, and an analysis of a commercial recommender system.

## Part 1: TidyVerse CREATE

A tidyverse vignette for the class repository
[acatlin/FALL2026TIDYVERSE](https://github.com/acatlin/FALL2026TIDYVERSE), demonstrating
**lubridate** on FiveThirtyEight's daily US births data (2000–2014, 5,479 days).

### What it covers

| Task | Functions |
| --- | --- |
| Build and parse dates | `make_date()`, `ymd()`, `mdy()`, `dmy()` |
| Extract components | `year()`, `month()`, `mday()`, `wday()`, `yday()` |
| Round dates | `floor_date()` |
| Date arithmetic | `days()`, `weeks()`, `months()`, `%m+%`, `days_in_month()` |
| Periods vs durations | `years()` vs `dyears()` |

### Findings along the way

- Sundays average **33.8% fewer** births than the daily mean; Saturdays 24.6% fewer.
- Monthly totals make February look lowest, but per day January is lowest and September highest.
- Christmas Day has **34.1% fewer** births than the same weekday a week either side; Independence
  Day 25.2% fewer.
- Friday the 13th has **6.4% fewer** births than the 6th and 20th, against 0.6–3.6% for 13ths on
  other weekdays.

### Files

| File | What it is |
| --- | --- |
| `aniss_s_lubridate_births.qmd` | The vignette (Quarto) |
| `aniss_s_lubridate_births.html` | Rendered output |

The data is read directly from FiveThirtyEight's public GitHub, so no data file is stored here.

### Reproduce

Requires R with `tidyverse` (2.0 or later, which attaches lubridate) and Quarto.

```bash
quarto render aniss_s_lubridate_births.qmd
```

## Part 2: Analyzing a Commercial Recommender — Amazon.com

[`amazon_recommender.qmd`](amazon_recommender.qmd) analyses Amazon's recommender system:

- **Scenario design, done twice:** once for Amazon the organization (retail, advertising and
  third-party sellers) and once for its customers, and where the two conflict.
- **Reverse engineering:** what each recommendation row on the site implies about its signal and
  method, plus what Amazon has published (Linden, Smith & York 2003; Smith & Linden 2017) and its
  conversational assistant (Rufus, now *Alexa for Shopping*).
- **A worked R example** of the 2017 scoring: raw co-purchase counts favour bestsellers, while
  scoring against an expected count, (N − E) / √E, surfaces genuinely related items.
- **Six recommendations:** purchase-cycle awareness, relevance standards for sponsored items,
  visible explanations, gift and household handling, satisfaction-based evaluation, and a grounded
  conversational assistant.

| File | What it is |
| --- | --- |
| `amazon_recommender.qmd` | The report (Quarto) |
| `amazon_recommender.html` | Rendered output |

```bash
quarto render amazon_recommender.qmd
```
