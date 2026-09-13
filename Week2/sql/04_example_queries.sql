-- 04_example_queries.sql
-- Queries used to check the database. Run with:
--   sqlite3 movie_ratings.sqlite < sql/04_example_queries.sql

-- 1. Every observed rating, with names instead of ids (JOIN).
SELECT u.name, m.title, r.rating
FROM ratings r
JOIN users  u ON u.user_id  = r.user_id
JOIN movies m ON m.movie_id = r.movie_id
ORDER BY u.name, m.title;

-- 2. Every possible person-movie pair. Unseen movies come back as NULL.
--    CROSS JOIN builds all pairs; LEFT JOIN keeps pairs with no rating.
SELECT u.name, m.title, r.rating
FROM users u
CROSS JOIN movies m
LEFT JOIN ratings r
       ON r.user_id = u.user_id AND r.movie_id = m.movie_id
ORDER BY u.name, m.movie_id;

-- 3. How many ratings are missing?
SELECT COUNT(*) AS missing_ratings
FROM users u
CROSS JOIN movies m
LEFT JOIN ratings r
       ON r.user_id = u.user_id AND r.movie_id = m.movie_id
WHERE r.rating IS NULL;

-- 4. Average rating and number of ratings per movie.
SELECT m.title,
       COUNT(r.rating)          AS n_ratings,
       ROUND(AVG(r.rating), 2)  AS avg_rating
FROM movies m
LEFT JOIN ratings r ON r.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY avg_rating DESC;
