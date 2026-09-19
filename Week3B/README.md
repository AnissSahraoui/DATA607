# DATA 607 — Week 3B: SQL Window Functions

Year-to-date and six-day moving averages of daily closing prices for Apple, Microsoft and Amazon
(January 2022 to September 2026), calculated with SQL window functions in SQLite and loaded into R.

## The query

```sql
AVG(close) OVER (PARTITION BY ticker, strftime('%Y', date) ORDER BY date
                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)   -- year-to-date
AVG(close) OVER (PARTITION BY ticker ORDER BY date
                 ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)           -- six-day moving average
```

The full query is in `sql/02_window_functions.sql`. The results match the same calculation done
with `dplyr` on all 3,546 rows.

## Files

| File | What it is |
| --- | --- |
| `window_functions.qmd` | The analysis (Quarto) |
| `window_functions.html` | Rendered output |
| `sql/01_create_table.sql` | `CREATE TABLE` for the prices |
| `sql/02_window_functions.sql` | The window function query |
| `data/stock_prices.csv` | Daily closing prices from Yahoo Finance (read from GitHub by the report) |

## Reproduce

Requires R with `tidyverse`, `DBI`, `RSQLite`, and Quarto.

```bash
quarto render window_functions.qmd
```

Or run the SQL directly:

```bash
sqlite3 prices.sqlite < sql/01_create_table.sql
sqlite3 prices.sqlite ".import --csv --skip 1 data/stock_prices.csv stock_prices"
sqlite3 -header -column prices.sqlite < sql/02_window_functions.sql
```

## Links

- RPubs: https://rpubs.com/benadam0/sql-window-functions
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week3B
