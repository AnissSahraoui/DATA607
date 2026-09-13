-- 01_create_tables.sql
-- Normalized schema for a small user-item ratings dataset (SQLite).
--
--   users   1 ──< ratings >── 1   movies
--
-- A person can rate many movies and a movie can be rated by many people,
-- so the many-to-many relationship lives in the `ratings` junction table.
-- A movie someone has NOT seen is simply absent from `ratings`; it is never
-- stored as a 0, because 0 would look like a (terrible) rating.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id  INTEGER PRIMARY KEY,
  name     TEXT    NOT NULL UNIQUE        -- first name or pseudonym only
);

CREATE TABLE movies (
  movie_id      INTEGER PRIMARY KEY,
  title         TEXT    NOT NULL UNIQUE,
  release_year  INTEGER NOT NULL,
  genre         TEXT    NOT NULL
);

CREATE TABLE ratings (
  user_id   INTEGER NOT NULL REFERENCES users(user_id)   ON DELETE CASCADE,
  movie_id  INTEGER NOT NULL REFERENCES movies(movie_id) ON DELETE CASCADE,
  rating    INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  PRIMARY KEY (user_id, movie_id)          -- one rating per person per movie
);
