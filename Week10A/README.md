# DATA 607 — Week 10A: Sentiment Analysis

Reproducing the sentiment analysis example from Chapter 2 of *Text Mining with R* (Silge &
Robinson, 2017), then extending it with a different corpus and two more lexicons.

## Step 1 — Reproduce

The chapter's Austen example runs as published: the joy words in *Emma* (good, young, friend, hope,
happy, love), the three sentiment trajectories through *Pride and Prejudice*, and the finding that
NRC rates text more positively than Bing.

## Step 2 — Extend

**A different corpus:** five gothic novels from Project Gutenberg — *Dracula*, *Frankenstein*,
*The Picture of Dorian Gray*, *The Turn of the Screw* and *Dr Jekyll and Mr Hyde* (392,375 words).

**Two more lexicons:** the **syuzhet** dictionary (Jockers, 10,748 entries) and **sentimentr**,
which scores whole sentences and handles negation and intensifiers.

## The main finding

The four lexicons disagree about the gothic novels — they do not even agree on the sign:

| Lexicon | Austen | Gothic | Gothic verdict |
| --- | --- | --- | --- |
| bing | +0.171 | **−0.087** | negative |
| afinn | +0.540 | +0.054 | positive |
| nrc | +0.338 | +0.105 | positive |
| syuzhet | +0.202 | +0.036 | positive |

Austen is positive on every lexicon, so the method works when the signal is strong. On the gothic
novels it is marginal, and the answer depends on which dictionary you pick: Bing is only 29.5%
positive while NRC is 41%, and that baseline difference drives the result.

Two further limits the report quantifies:

- **Negation** affects only 2.16% of matched words (591 of 27,310), so it is a real but minor flaw.
  `sentimentr`, which handles it, broadly agrees with the simple word counts.
- **Coverage** is 7–12% — these lexicons score roughly one word in ten and ignore the rest.

## Files

| File | What it is |
| --- | --- |
| `sentiment_analysis.qmd` | The analysis (Quarto) |
| `sentiment_analysis.html` | Rendered output |
| `data/gothic_books.csv` | The five novels, downloaded once with `gutenbergr` |

## A note on the lexicons

The book calls `get_sentiments()`, which downloads afinn and nrc through `textdata` after asking
you to accept each licence — a prompt that cannot be answered during an automatic render. This
report takes those two from `syuzhet`, which ships its own copies; `bing` still comes from
`tidytext` as in the book.

## Reproduce

Requires R with `tidyverse`, `tidytext`, `janeaustenr`, `syuzhet`, `sentimentr`, and Quarto.

```bash
quarto render sentiment_analysis.qmd
```
