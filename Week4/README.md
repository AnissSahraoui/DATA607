# DATA 607 — Project 1: Chess Tournament Results

Parsing a formatted chess tournament text file into a tidy CSV with one row per player.

## Output

`tournament_results.csv`, 64 rows:

| Column | Meaning |
| --- | --- |
| `player_name` | Player's name |
| `player_state` | Player's state |
| `total_points` | Total number of points |
| `player_pre_rating` | Pre-tournament rating |
| `avg_opponent_pre_rating` | Average pre-tournament rating of the opponents played |

The first row matches the example in the project:

```
Gary Hua,ON,6.0,1794,1605
```

## The parsing problem

Each player takes up two lines of the text file, and opponents are listed only by pair number, so
each opponent's rating has to be looked up elsewhere in the file. Two details matter:

- Provisional ratings are written like `1641P17`, so only the digits before the `P` are the rating.
- Byes and unplayed rounds (`H`, `U`, `X`) have no opponent, so they are not counted as games.

## Checks

- Gary Hua's opponent ratings and average of 1605 reproduce the project's example exactly.
- All 64 players are present, pair numbers 1 to 64, with no missing values.
- Every game appears in both players' round lists, so no opponent number was misread.

## Files

| File | What it is |
| --- | --- |
| `chess_tournament.qmd` | The analysis (Quarto) |
| `chess_tournament.html` | Rendered output |
| `tournament_results.csv` | The generated CSV |
| `tournmentinfo.txt` | The tournament text file (read from GitHub by the report) |

## Reproduce

Requires R with `tidyverse`, and Quarto.

```bash
quarto render chess_tournament.qmd
```
