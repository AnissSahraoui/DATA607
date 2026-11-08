# DATA 607 — Week 10B: More JSON Practice (Nobel Prize API)

Four questions answered from the Nobel Prize API's nested JSON, flattened into two tidy data frames
in R. No API key is required.

## The data

`https://api.nobelprize.org/2.1/laureates` — 1,028 laureates, flattened into 1,036 laureate-prize
rows (the 8 extra rows are the 7 repeat winners), covering 1901 to 2026.

## The four questions and answers

1. **How has the number of laureates changed over time?** Roughly doubled, 57 in the 1900s to 123
   in the 2000s — mostly because prizes are now split between two or three people.
2. **How has the share of women changed?** From 5.4% in the 1900s to 19.5% in the 2020s. The gap
   between categories is wider than the change over time: Peace 18.6%, Physics 2.2%.
3. **How old are laureates when they win?** Mean 60.6, median 61, range 17 (Malala Yousafzai) to 97
   (John B. Goodenough). Laureates awarded since 1970 average 64.0 against 55.2 before — nearly
   nine years older.
4. **Which countries lost laureates, and which gained them?** *(the join-and-compare question)*
   Comparing each laureate's country of birth with the country of the institution they worked at
   when they won: **the USA has a net gain of 130**, gaining 134 and losing 4. Poland is the biggest
   loser at −19. 35.7% of these laureates were born in the USA but 52.8% were working there.

## Cleaning decisions

- **Organizations** (28 of them) carry `orgName` and `founded` instead of `knownName` and `birth`,
  and have no gender. They are excluded from the gender and age questions.
- **Country names come from `countryNow`**, so Marie Curie's birthplace reads Poland rather than
  "Russian Empire", making countries comparable across 125 years.
- **48 birth dates record only a year** (`1948-00-00`), so age is award year minus birth year —
  accurate to within a year, and keeps those laureates in rather than dropping them.
- **273 prizes have no affiliation**, mostly Peace and Literature. Question 4 uses the 761 rows
  where both countries are known, and says so.

## Files

| File | What it is |
| --- | --- |
| `nobel_api.qmd` | The analysis (Quarto) |
| `nobel_api.html` | Rendered output |
| `fetch_nobel.R` | Collection script: pagination, flattening, snapshot |
| `data/nobel_laureates.csv` | 1,028 laureates |
| `data/nobel_prizes.csv` | 1,036 laureate-prize rows |

The report reads the snapshot from GitHub, so it renders without a live API call.

## Reproduce

Requires R with `tidyverse`, `httr2` and `jsonlite`, and Quarto.

```bash
Rscript fetch_nobel.R     # optional: refresh the snapshot
quarto render nobel_api.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/nobel-prize-api
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week10B
