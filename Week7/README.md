# DATA 607 — Week 7: Working with HTML and JSON in R

Three books on data science, written by hand into an HTML table and a JSON file, loaded into R with
`rvest` and `jsonlite`, and compared.

## The books

| Title | Authors | Year | Publisher |
| --- | --- | --- | --- |
| R for Data Science (2nd ed.) | Hadley Wickham, Mine Çetinkaya-Rundel, Garrett Grolemund | 2023 | O'Reilly Media |
| An Introduction to Statistical Learning (2nd ed.) | Gareth James, Daniela Witten, Trevor Hastie, Robert Tibshirani | 2021 | Springer |
| The Art of Statistics | David Spiegelhalter | 2019 | Pelican Books |

Two of the three have multiple authors. Metadata was checked against the Open Library API, and the
author list for *R for Data Science* against <https://r4ds.hadley.nz>.

## Are the two data frames identical?

Not at first. `all.equal()` reports five messages, which come down to three differences:

| Difference | From HTML | From JSON |
| --- | --- | --- |
| Column names | `Title`, `Authors`, ... | `title`, `authors`, ... |
| `authors` column | one comma-separated string | a list of names |
| Object class | tibble | data frame |

After lowercasing the names, collapsing the JSON author lists, and comparing both as plain data
frames, `all.equal()` and `identical()` both return `TRUE`. The files always held the same
information; only the representation differed.

The structural difference is the interesting one: JSON can store a list of authors in one field and
HTML cannot, so the JSON version is closer to tidy data and flattening it loses information.

## Files

| File | What it is |
| --- | --- |
| `books.html` | Hand-written HTML table |
| `books.json` | Hand-written JSON, authors as arrays |
| `books_html_json.qmd` | The analysis (Quarto) |
| `books_html_json.html` | Rendered output |

Both data files are read over HTTPS from this repository, so the report runs from a clean R session.

## Reproduce

Requires R with `tidyverse`, `rvest` and `jsonlite`, and Quarto.

```bash
quarto render books_html_json.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/books-html-json
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week7
