# DATA 607 — Week 2B: Evaluating Classification Model Performance

How a probability threshold changes a binary classifier's errors and metrics, using a model that
predicts whether a penguin is female. Female is the positive class.

## Results

- **Null error rate: 41.9%.** 54 of 93 penguins are male, so always guessing "male" is right 58.1%
  of the time.
- The model is very confident: only 5 of 93 penguins have a predicted probability between 0.2
  and 0.8. The three thresholds therefore differ by just a few penguins.

| Threshold | TP | FP | TN | FN | Accuracy | Precision | Recall | F1 |
|---|---|---|---|---|---|---|---|---|
| 0.2 | 37 | 6 | 48 | 2 | 0.914 | 0.860 | 0.949 | 0.902 |
| 0.5 | 36 | 3 | 51 | 3 | 0.935 | 0.923 | 0.923 | 0.923 |
| 0.8 | 36 | 2 | 52 | 3 | 0.946 | 0.947 | 0.923 | 0.935 |

- **0.2 suits cases where missing a positive is costly** (e.g. cancer screening).
- **0.8 suits cases where a false alarm is costly** (e.g. automatically blocking a credit card).

## Files

| File | What it is |
| --- | --- |
| `classification_metrics.qmd` | The analysis (Quarto) |
| `classification_metrics.html` | Rendered output |
| `data/penguin_predictions.csv` | Copy of the course data file |

The `.qmd` reads the data directly from the
[course repository](https://github.com/acatlin/data/blob/master/penguin_predictions.csv).

## Reproduce

Requires R with `tidyverse`, and Quarto.

```bash
quarto render classification_metrics.qmd
```
