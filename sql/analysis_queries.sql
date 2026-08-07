-- ============================================================
-- Movies Performance Analysis — Analysis Queries (Core)
-- ============================================================
-- Run create_database.sql and insert_data.sql first.
-- 25 queries covering box office, ratings, genre, studio, and
-- country-level analysis. Standard ANSI SQL (SQLite/MySQL/Postgres).
-- ============================================================


-- 1. Top 10 highest-grossing movies overall
SELECT title, year, worldwide_box_office_usd
FROM movies
ORDER BY worldwide_box_office_usd DESC
LIMIT 10;


-- 2. Highest-grossing movie of each year
SELECT year, title, worldwide_box_office_usd
FROM movies m
WHERE worldwide_box_office_usd = (
    SELECT MAX(worldwide_box_office_usd) FROM movies WHERE year = m.year
);


-- 3. Top 10 best IMDb-rated movies
SELECT title, year, imdb_rating, genre
FROM movies
WHERE imdb_rating IS NOT NULL
ORDER BY imdb_rating DESC
LIMIT 10;


-- 4. Bottom 5 rated movies among top box office earners
SELECT title, year, imdb_rating, worldwide_box_office_usd
FROM movies
WHERE imdb_rating IS NOT NULL
ORDER BY imdb_rating ASC
LIMIT 5;


-- 5. Return on investment (box office / budget)
SELECT title, year, budget_usd, worldwide_box_office_usd,
       ROUND(worldwide_box_office_usd * 1.0 / budget_usd, 2) AS roi_multiple
FROM movies
WHERE budget_usd IS NOT NULL AND budget_usd > 0
ORDER BY roi_multiple DESC
LIMIT 10;


-- 6. Average IMDb rating by genre
SELECT genre,
       COUNT(*) AS movie_count,
       ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
WHERE imdb_rating IS NOT NULL
GROUP BY genre
ORDER BY avg_rating DESC;


-- 7. Average box office by genre
SELECT genre,
       COUNT(*) AS movie_count,
       ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office
FROM movies
GROUP BY genre
ORDER BY avg_box_office DESC;


-- 8. Box office and average rating by distributor/studio
SELECT distributor,
       COUNT(*) AS movie_count,
       SUM(worldwide_box_office_usd) AS total_box_office,
       ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
WHERE distributor IS NOT NULL
GROUP BY distributor
ORDER BY total_box_office DESC;


-- 9. Year-over-year totals: 2025 vs 2026
SELECT year,
       COUNT(*) AS movie_count,
       SUM(worldwide_box_office_usd) AS total_box_office,
       ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office,
       ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
GROUP BY year;


-- 10. Movies by country of origin
SELECT country,
       COUNT(*) AS movie_count,
       SUM(worldwide_box_office_usd) AS total_box_office
FROM movies
GROUP BY country
ORDER BY total_box_office DESC;


-- 11. Rating distribution buckets
SELECT
    CASE
        WHEN imdb_rating >= 8.0 THEN '8.0+'
        WHEN imdb_rating >= 7.0 THEN '7.0-7.9'
        WHEN imdb_rating >= 6.0 THEN '6.0-6.9'
        ELSE 'Below 6.0'
    END AS rating_bucket,
    COUNT(*) AS movie_count,
    ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office
FROM movies
WHERE imdb_rating IS NOT NULL
GROUP BY rating_bucket
ORDER BY rating_bucket DESC;


-- 12. Budget tiers vs average box office
SELECT
    CASE
        WHEN budget_usd >= 200000000 THEN 'Blockbuster ($200M+)'
        WHEN budget_usd >= 100000000 THEN 'Big Budget ($100M-$200M)'
        WHEN budget_usd >= 20000000  THEN 'Mid Budget ($20M-$100M)'
        ELSE 'Low Budget (<$20M)'
    END AS budget_tier,
    COUNT(*) AS movie_count,
    ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office,
    ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
WHERE budget_usd IS NOT NULL
GROUP BY budget_tier
ORDER BY avg_box_office DESC;


-- 13. Animation genre deep-dive
SELECT title, year, worldwide_box_office_usd, imdb_rating
FROM movies
WHERE genre = 'Animation'
ORDER BY worldwide_box_office_usd DESC;


-- 14. Horror genre deep-dive (notably low-budget, high-ROI in this dataset)
SELECT title, year, budget_usd, worldwide_box_office_usd, imdb_rating
FROM movies
WHERE genre = 'Horror'
ORDER BY worldwide_box_office_usd DESC;


-- 15. Movies that crossed $1 billion worldwide
SELECT title, year, worldwide_box_office_usd
FROM movies
WHERE worldwide_box_office_usd >= 1000000000
ORDER BY worldwide_box_office_usd DESC;


-- 16. Movies still tracking toward $1B (900M-999M range) as of as_of_date
SELECT title, year, worldwide_box_office_usd, as_of_date, notes
FROM movies
WHERE worldwide_box_office_usd BETWEEN 900000000 AND 999999999
ORDER BY worldwide_box_office_usd DESC;


-- 17. Longest-running movies by runtime
SELECT title, year, runtime_min
FROM movies
WHERE runtime_min IS NOT NULL
ORDER BY runtime_min DESC
LIMIT 5;


-- 18. Shortest movies by runtime
SELECT title, year, runtime_min
FROM movies
WHERE runtime_min IS NOT NULL
ORDER BY runtime_min ASC
LIMIT 5;


-- 19. Average runtime by genre
SELECT genre, ROUND(AVG(runtime_min), 0) AS avg_runtime_min
FROM movies
WHERE runtime_min IS NOT NULL
GROUP BY genre
ORDER BY avg_runtime_min DESC;


-- 20. Disney-distributed movies performance (studio-specific example)
SELECT title, year, worldwide_box_office_usd, imdb_rating
FROM movies
WHERE distributor LIKE '%Disney%'
ORDER BY worldwide_box_office_usd DESC;


-- 21. Movies with budget data missing (data quality check)
SELECT title, year, worldwide_box_office_usd
FROM movies
WHERE budget_usd IS NULL;


-- 22. Movies with no IMDb rating yet (data quality check)
SELECT title, year, release_date, notes
FROM movies
WHERE imdb_rating IS NULL;


-- 23. Highest-grossing movie per genre
SELECT genre, title, worldwide_box_office_usd
FROM movies m
WHERE worldwide_box_office_usd = (
    SELECT MAX(worldwide_box_office_usd) FROM movies WHERE genre = m.genre
)
ORDER BY worldwide_box_office_usd DESC;


-- 24. Total industry box office tracked in this dataset
SELECT
    COUNT(*) AS total_movies,
    SUM(worldwide_box_office_usd) AS combined_box_office,
    ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office_per_movie
FROM movies;


-- 25. Non-USA movies performance (international box office strength)
SELECT title, year, country, worldwide_box_office_usd
FROM movies
WHERE country NOT LIKE '%USA%'
ORDER BY worldwide_box_office_usd DESC;
