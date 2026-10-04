# DATA 607 — Week 5B: Chess Elo Calculations

Using the Project 1 tournament data, each player's **expected score** is calculated from the rating
difference in every game they played, then compared with their actual score.

## The formula

```
expected score = 1 / (1 + 10 ^ ((opponent rating - player rating) / 400))
```

Source: [Elo rating system](https://en.wikipedia.org/wiki/Elo_rating_system), Wikipedia. The same
expectancy appears as a lookup table in the [FIDE Handbook](https://handbook.fide.com/chapter/B022022)
rating regulations.

## Results

**Five biggest overperformers**

| Player | Rating | Actual | Expected | Difference |
| --- | --- | --- | --- | --- |
| Aditya Bajaj | 1384 | 6.0 | 1.95 | +4.05 |
| Zachary James Houghton | 1220 | 4.5 | 1.37 | +3.13 |
| Anvit Rao | 1365 | 5.0 | 1.94 | +3.06 |
| Jacob Alexander Lavalley | 377 | 3.0 | 0.04 | +2.96 |
| Stefano Lee | 1411 | 5.0 | 2.29 | +2.71 |

**Five biggest underperformers**

| Player | Rating | Actual | Expected | Difference |
| --- | --- | --- | --- | --- |
| Loren Schwiebert | 1745 | 3.5 | 6.28 | −2.78 |
| George Avery Jones | 1522 | 3.5 | 6.02 | −2.52 |
| Larry Hodge | 1270 | 1.0 | 3.40 | −2.40 |
| Jared Ge | 1332 | 3.0 | 5.01 | −2.01 |
| Rishi Shetty | 1494 | 3.5 | 5.09 | −1.59 |

## Checks

- Across 204 games the total expected score equals the total actual score exactly, as it must,
  since the two players' expected scores in any game sum to 1.
- The post-tournament ratings recorded in the source file correlate **0.78** with these
  differences, and all ten listed players moved in the expected direction.
- Byes and unplayed rounds are excluded from both scores, since they have no opponent and so no
  rating difference.

## Files

| File | What it is |
| --- | --- |
| `chess_elo.qmd` | The analysis (Quarto) |
| `chess_elo.html` | Rendered output |

The tournament file is read from `Week4/tournmentinfo.txt` in this repository.

## Reproduce

Requires R with `tidyverse`, and Quarto.

```bash
quarto render chess_elo.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/chess-elo
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week5B
