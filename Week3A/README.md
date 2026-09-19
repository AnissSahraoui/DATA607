# DATA 607 — Week 3A: Global Baseline Estimate

A Global Baseline Estimate movie recommender in R, applied to my Week 2 movie ratings.

**Estimate = overall average + movie's difference from average + person's difference from average**

## Results

- The R function reproduces the course spreadsheet's example: Param would rate Pitch Perfect 2 a
  **2.28**.
- On the spreadsheet data it recommends an unrated movie to each critic, most often Deadpool.
- My Week 2 survey has no unrated movies, so there is nothing to recommend. A new viewer would be
  recommended F1 or Wicked: For Good.
- Hiding one rating at a time and estimating it: the overall average alone is off by 0.79 points
  (RMSE), adding the movie's difference brings that to 0.35, and the full Global Baseline gives 0.41.

## Files

| File | What it is |
| --- | --- |
| `global_baseline.qmd` | The analysis (Quarto) |
| `global_baseline.html` | Rendered output |
| `MovieRatings.xlsx` | Course spreadsheet with the algorithm |

The ratings are read from `../Week2/movie_ratings.sqlite`.

## Reproduce

Requires R with `tidyverse`, `readxl`, `DBI`, `RSQLite`, and Quarto.

```bash
quarto render global_baseline.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/global-baseline
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week3A
