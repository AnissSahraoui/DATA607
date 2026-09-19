-- 01_create_table.sql
-- One row per stock per trading day.

DROP TABLE IF EXISTS stock_prices;

CREATE TABLE stock_prices (
  date    TEXT NOT NULL,   -- YYYY-MM-DD
  ticker  TEXT NOT NULL,
  close   REAL NOT NULL,   -- closing price in US dollars
  PRIMARY KEY (ticker, date)
);
