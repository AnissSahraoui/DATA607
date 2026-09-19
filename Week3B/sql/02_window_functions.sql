-- 02_window_functions.sql
-- Year-to-date average and six-day moving average of the closing price, for each stock.

SELECT
  date,
  ticker,
  close,

  -- Year-to-date average: every day from January 1 of the same year up to this day.
  -- PARTITION BY ticker and year makes the average restart each January for each stock.
  AVG(close) OVER (
    PARTITION BY ticker, strftime('%Y', date)
    ORDER BY date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS ytd_avg,

  -- Six-day moving average: this trading day and the five before it.
  -- The first five days of each stock have fewer than six days of history, so they are NULL.
  CASE
    WHEN COUNT(close) OVER six_days = 6 THEN AVG(close) OVER six_days
  END AS moving_avg_6d

FROM stock_prices
WINDOW six_days AS (
  PARTITION BY ticker
  ORDER BY date
  ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
)
ORDER BY ticker, date;
