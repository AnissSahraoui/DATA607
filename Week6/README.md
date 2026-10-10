# DATA 607 — Project 2: Data Tidying and Transformation

Three independent wide-format datasets, each taken from a different Discussion 5A post, tidied with
`tidyr` and `dplyr` and analysed as the original post asked. Each dataset has its own Quarto file
and its own published output.

## The three datasets

| # | Dataset | Discussion 5A post | How it is wide |
| --- | --- | --- | --- |
| 1 | World Bank life expectancy, 2000–2023 | "Life Expectancy by Country — World Bank" (Mohd Afwan Shaikh) | 24 year columns |
| 2 | Electricity production by country | "Total Energy Production by Country" (Ellie Wilser) | Two-level header grouping sources under Fossil fuels / Nuclear / Renewables |
| 3 | BLS state unemployment, 2023–24 | "U.S. Bureau of Labor Statistics Table" (Zaina Hassan) | Five measures × two years spread across ten columns |

## Files

| File | What it is |
| --- | --- |
| `life_expectancy.qmd` / `.html` | Dataset 1: tidying and analysis |
| `electricity_production.qmd` / `.html` | Dataset 2: tidying and analysis |
| `state_unemployment.qmd` / `.html` | Dataset 3: tidying and analysis |
| `data/life_expectancy_wide.csv` | Raw wide file, 217 countries × 24 years |
| `data/electricity_production_wide.csv` | Raw wide file, 216 rows, grouped headers preserved as `Group \| Source` |
| `data/state_unemployment_wide.csv` | Raw wide file, 66 rows, headers preserved as `Measure \| Year` |

Each `.qmd` reads its CSV straight from this repository over HTTPS, so every report runs from a
clean R session with no local files.

## Headline findings

1. **Life expectancy** — the country average rose from 67.6 years (2000) to 73.0 (2019), fell to
   71.8 in 2021, and reached 73.8 by 2023. Malawi gained the most since 2000 (+21.2 years); Bolivia
   lost the most during COVID (−6.4). 186 of 217 countries were back at their 2019 level by 2023.
2. **Electricity** — "most sustainable" has three different answers. China produces the most
   renewable electricity (3,913 TWh) but only 37% of its own mix; nine countries are ~100%
   renewable but mostly tiny; among large producers Norway (99%) and Brazil (87%) lead. Fossil fuels
   are the dominant source in 139 of 213 countries.
3. **Unemployment** — rose in 46 of 51 states between 2023 and 2024 and fell in only 3. Nevada was
   highest in 2024 (5.6%), South Dakota lowest (1.8%), and Rhode Island rose the most (+1.3 points).

## Reproduce

Requires R with `tidyverse` and `knitr`, and Quarto.

```bash
quarto render life_expectancy.qmd
quarto render electricity_production.qmd
quarto render state_unemployment.qmd
```

## Submission links

| Dataset | `.qmd` on GitHub | Published on RPubs |
| --- | --- | --- |
| Life expectancy | [life_expectancy.qmd](https://github.com/AnissSahraoui/DATA607/blob/main/Week6/life_expectancy.qmd) | <https://rpubs.com/benadam0/tidy-life-expectancy> |
| Electricity production | [electricity_production.qmd](https://github.com/AnissSahraoui/DATA607/blob/main/Week6/electricity_production.qmd) | <https://rpubs.com/benadam0/tidy-electricity-production> |
| State unemployment | [state_unemployment.qmd](https://github.com/AnissSahraoui/DATA607/blob/main/Week6/state_unemployment.qmd) | <https://rpubs.com/benadam0/tidy-state-unemployment> |
