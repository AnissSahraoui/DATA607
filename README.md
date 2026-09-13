# DATA 607 — Assignment 1: Loading and Transforming EPL Match Data

Loading 25 seasons of English Premier League match data (2000–01 through 2024–25, 9,500 matches)
into R, selecting a subset of columns, renaming the abbreviations into readable names, and
decoding the target variable.

## The question

Researchers at Leeds and Northumbria found that home advantage in European football roughly
halved when COVID-19 forced matches to be played in empty stadiums. This assignment builds the
clean data frame you would need to check that claim against Premier League data — and takes a
first look.

**Article:** [How empty stadiums affected football during pandemic](https://www.leeds.ac.uk/news-science/news/article/4894/how-empty-stadiums-affected-football-during-pandemic) (University of Leeds)
**Paper:** McCarrick et al. (2021), [Home advantage during the COVID-19 pandemic](https://www.sciencedirect.com/science/article/pii/S146902922100131X), *Psychology of Sport and Exercise*

## Files

| File | What it is |
| --- | --- |
| `Assignment1_Sahraoui.Rmd` | The solution — knit this |
| `Assignment1_Sahraoui.html` | Knitted output |
| `data/raw/season-*.csv` | 25 unmodified season files, one per season |

## Data

Original source: [football-data.co.uk](https://www.football-data.co.uk/englandm.php), also
mirrored on Kaggle as
[English Premier League (EPL) Match Data 2000-2025](https://www.kaggle.com/datasets/marcohuiii/english-premier-league-epl-match-data-2000-2025).

The `.Rmd` reads the CSVs over HTTPS directly from this repository's `data/raw/`, so it reproduces
on any machine without local files.

## Raw column codes

`FTHG`/`FTAG` full-time home/away goals · `FTR` full-time result (H/D/A — the target) ·
`HTHG`/`HTAG`/`HTR` half-time equivalents · `HS`/`AS` shots · `HST`/`AST` shots on target ·
`HF`/`AF` fouls · `HC`/`AC` corners · `HY`/`AY` yellow cards · `HR`/`AR` red cards

## Result

`epl_clean`: 9,500 rows × 25 columns, no missing values, target spelled out as
Home Win / Draw / Away Win.

## Links

- RPubs: https://rpubs.com/benadam0/epl-loading-transformation
- GitHub: https://github.com/AnissSahraoui/DATA607

## Other assignments

- [Week 2: SQL and R, Movie Ratings](Week2/)
- [Week 2B: Evaluating Classification Model Performance](Week2B/)
