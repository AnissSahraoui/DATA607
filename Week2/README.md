# DATA 607 — Week 2: SQL and R, Movie Ratings

A small survey of movie ratings, stored in a normalized SQLite database and analyzed in R.

Six popular 2025 movies, rated 1–5 by six friends. The analysis asks how missing ratings should be
handled, and whether standardizing each person's ratings changes the results.

## Results

- **F1** and **Wicked: For Good** tied for first (5.00). **Weapons** came last (3.00, from every friend).
- All six friends had seen all six movies, so the survey itself has no gaps. To test the
  missing-data strategy, I hid ratings at random and compared the estimates to the known true
  averages. Filling gaps with 0 missed by up to 3.1 points. Averaging only the real ratings was the
  most accurate, and a damped mean was less accurate.
- Standardizing ratings changed nothing, because every friend's average rating is exactly 4.5.

## Files

| File | What it is |
| --- | --- |
| `movie_ratings.qmd` | The analysis write-up (Quarto) |
| `movie_ratings.html` | Rendered output |
| `sql/01_create_tables.sql` | `CREATE TABLE` for `users`, `movies`, `ratings` |
| `sql/02_insert_movies.sql` | `INSERT` for the six movies |
| `sql/03_insert_users_and_ratings.sql` | `INSERT` for people and ratings (generated from the survey) |
| `sql/04_example_queries.sql` | `JOIN` and `NULL` queries used to check the data |
| `R/build_database.R` | Validates the survey CSV and builds the database |
| `data/survey_responses.csv` | Raw survey responses: one row per person, blank = not seen |
| `movie_ratings.sqlite` | The database file |

## Schema

```
users (user_id PK, name)
movies (movie_id PK, title, release_year, genre)
ratings (user_id FK, movie_id FK, rating CHECK 1–5, PRIMARY KEY (user_id, movie_id))
```

`ratings` is a junction table for the many-to-many relationship between people and movies. A movie
someone hasn't seen has no row in it. It is never stored as 0.

## Reproduce

Requires R with `DBI`, `RSQLite`, `tidyverse`, and Quarto.

```bash
Rscript R/build_database.R
quarto render movie_ratings.qmd
```

Or build the database with SQL only:

```bash
cat sql/01_create_tables.sql sql/02_insert_movies.sql sql/03_insert_users_and_ratings.sql | sqlite3 movie_ratings.sqlite
```

SQLite is a local file, so there are no credentials in this project.

## Collaborators

Claude AI (Anthropic) and ChatGPT (OpenAI), used as AI assistants.

## Links

- RPubs: https://rpubs.com/benadam0/movie-ratings-sql
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week2
