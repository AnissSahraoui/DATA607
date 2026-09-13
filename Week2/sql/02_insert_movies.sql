-- 02_insert_movies.sql
-- The six movies in the survey. Titles must match the column headers in
-- data/survey_responses.csv exactly.

INSERT INTO movies (movie_id, title, release_year, genre) VALUES
  (1, 'Sinners',            2025, 'Horror'),
  (2, 'Superman',           2025, 'Superhero'),
  (3, 'F1',                 2025, 'Sports drama'),
  (4, 'Weapons',            2025, 'Horror'),
  (5, 'KPop Demon Hunters', 2025, 'Animated musical'),
  (6, 'Wicked: For Good',   2025, 'Musical');
