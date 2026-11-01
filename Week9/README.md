# DATA 607 — Week 9: Using a New York Times API in R

Using the **Article Search API** to ask how the Times' coverage of artificial intelligence changed
between January–June 2019 and the same months in 2026.

## Findings

- **Volume grew 5.6×**, from 460 articles to 2,568. These counts are exact, taken from the API's
  own `meta.hits` rather than from a sample. Every month of 2026 beats every month of 2019.
- **Technology stayed the home section** at roughly 30% in both periods, with Business at 21–23%.
- **The shift is from commentary to news.** Opinion fell from 20.8% of sampled articles to 6.7%,
  while the U.S. section rose from 3.3% to 13.3% and New York went from nothing to 6.7%. Commentary
  article types fell from 20.8% to 6.7%.
- **Coverage spread out:** the top three sections held 74.2% of sampled articles in 2019 and 64.2%
  in 2026. Median article length fell from 1,100 to 933 words.

Read together, AI looks like a subject that became a beat: argued *about* in 2019, reported *on* by
2026.

## The API key

The key is read from `~/.Renviron` as `NYT_API_KEY` and never appears in the code, the data files,
or the rendered HTML — all three were checked. To run the collection yourself:

```bash
printf 'NYT_API_KEY=your_key_here\n' >> ~/.Renviron
Rscript fetch_nyt.R
```

## Two API limitations worth knowing

- `facet_fields` and `fq` return no results on the standard access tier, so exact per-section counts
  are not available. The section breakdown is therefore a sample of 20 articles per month (120 per
  period); the volume figures are exact.
- The API allows roughly five requests per minute, so `fetch_nyt.R` pauses 13 seconds between calls.

## Files

| File | What it is |
| --- | --- |
| `nyt_api.qmd` | The analysis (Quarto) |
| `nyt_api.html` | Rendered output |
| `fetch_nyt.R` | Collection script: requests, flattening, snapshot |
| `data/nyt_ai_articles.csv` | 240 flattened articles |
| `data/nyt_ai_monthly_totals.csv` | Exact monthly hit counts |

The report reads the snapshot from GitHub, so it renders without a key.

## Reproduce

Requires R with `tidyverse`, `httr2` and `jsonlite`, and Quarto.

```bash
quarto render nyt_api.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/nyt-ai-coverage
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week9
