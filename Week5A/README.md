# DATA 607 — Week 5A: Tidying and Transforming Data

Arrival delays for two airlines, ALASKA and AM WEST, across five west-coast cities. The data is
tidied with `tidyr` and `dplyr`, then the airlines are compared overall and city by city.

## Results

| | Delayed arrivals |
| --- | --- |
| ALASKA | 13.3% |
| AM WEST | 10.9% |

**But ALASKA has a lower delay rate in all five cities:**

| City | ALASKA | AM WEST |
| --- | --- | --- |
| Los Angeles | 11.1% | 14.4% |
| Phoenix | 5.2% | 7.9% |
| San Diego | 8.6% | 14.5% |
| San Francisco | 16.9% | 28.7% |
| Seattle | 14.2% | 23.3% |

This reversal is **Simpson's paradox**. The overall rate is weighted by where each airline flies.
AM WEST runs 72.7% of its arrivals through Phoenix, the least delay-prone airport here, while
ALASKA runs 56.8% through Seattle and 16.0% through San Francisco, two of the worst.

Standardising removes the effect: flying ALASKA's mix of cities, AM WEST's delay rate would be
**21.4%**, well above ALASKA's 13.3%.

## Files

| File | What it is |
| --- | --- |
| `flight_delays.qmd` | The analysis (Quarto) |
| `flight_delays.html` | Rendered output |
| `data/flights.csv` | The data, in the same wide layout as the source table including its blank cells |

The report reads the CSV directly from GitHub.

## Reproduce

Requires R with `tidyverse` and `scales`, and Quarto.

```bash
quarto render flight_delays.qmd
```

## Links

- RPubs: https://rpubs.com/benadam0/airline-delays
- GitHub: https://github.com/AnissSahraoui/DATA607/tree/main/Week5A
