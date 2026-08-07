-- ============================================================
-- Movies Performance Analysis — Advanced Queries
-- ============================================================
-- CTEs, window functions, and views. Run create_database.sql
-- and insert_data.sql first.
-- Tested against SQLite; window functions also work as-is in
-- MySQL 8.0+ and PostgreSQL.
-- ============================================================


-- 1. RANK() — rank every movie by box office within its year
SELECT
    title, year, worldwide_box_office_usd,
    RANK() OVER (PARTITION BY year ORDER BY worldwide_box_office_usd DESC) AS box_office_rank
FROM movies
ORDER BY year, box_office_rank;


-- 2. ROW_NUMBER() — top 3 highest-grossing movies per genre
WITH ranked_by_genre AS (
    SELECT
        title, genre, year, worldwide_box_office_usd,
        ROW_NUMBER() OVER (PARTITION BY genre ORDER BY worldwide_box_office_usd DESC) AS rn
    FROM movies
)
SELECT title, genre, year, worldwide_box_office_usd
FROM ranked_by_genre
WHERE rn <= 3
ORDER BY genre, worldwide_box_office_usd DESC;


-- 3. DENSE_RANK() — rank movies by IMDb rating (ties share a rank, no gaps)
SELECT
    title, year, imdb_rating,
    DENSE_RANK() OVER (ORDER BY imdb_rating DESC) AS rating_rank
FROM movies
WHERE imdb_rating IS NOT NULL
ORDER BY rating_rank;


-- 4. Running total of box office, ordered by release date
SELECT
    title, release_date, worldwide_box_office_usd,
    SUM(worldwide_box_office_usd) OVER (ORDER BY release_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_box_office
FROM movies
ORDER BY release_date;


-- 5. Moving average — 3-movie trailing average box office, ordered by release date
SELECT
    title, release_date, worldwide_box_office_usd,
    ROUND(AVG(worldwide_box_office_usd) OVER (ORDER BY release_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 0) AS trailing_3_movie_avg
FROM movies
ORDER BY release_date;


-- 6. LAG() — compare each movie's box office to the previous release (chronologically)
SELECT
    title, release_date, worldwide_box_office_usd,
    LAG(worldwide_box_office_usd) OVER (ORDER BY release_date) AS previous_movie_box_office,
    worldwide_box_office_usd - LAG(worldwide_box_office_usd) OVER (ORDER BY release_date) AS change_from_previous
FROM movies
ORDER BY release_date;


-- 7. LEAD() — box office of the *next* released movie, per title
SELECT
    title, release_date, worldwide_box_office_usd,
    LEAD(title) OVER (ORDER BY release_date) AS next_movie_released
FROM movies
ORDER BY release_date;


-- 8. NTILE() — split all movies into 4 box office performance quartiles
SELECT
    title, worldwide_box_office_usd,
    NTILE(4) OVER (ORDER BY worldwide_box_office_usd DESC) AS box_office_quartile
FROM movies
ORDER BY box_office_quartile, worldwide_box_office_usd DESC;


-- 9. CTE + window function — each movie's box office vs. its genre's average
WITH genre_avg AS (
    SELECT genre, AVG(worldwide_box_office_usd) AS avg_genre_box_office
    FROM movies
    GROUP BY genre
)
SELECT
    m.title, m.genre, m.worldwide_box_office_usd,
    ROUND(g.avg_genre_box_office, 0) AS genre_avg_box_office,
    ROUND(m.worldwide_box_office_usd - g.avg_genre_box_office, 0) AS diff_from_genre_avg
FROM movies m
JOIN genre_avg g ON m.genre = g.genre
ORDER BY diff_from_genre_avg DESC;


-- 10. Multi-level CTE — best ROI movie per year
WITH roi_calc AS (
    SELECT
        title, year, budget_usd, worldwide_box_office_usd,
        worldwide_box_office_usd * 1.0 / budget_usd AS roi_multiple
    FROM movies
    WHERE budget_usd IS NOT NULL AND budget_usd > 0
),
ranked_roi AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY roi_multiple DESC) AS rn
    FROM roi_calc
)
SELECT year, title, ROUND(roi_multiple, 2) AS roi_multiple
FROM ranked_roi
WHERE rn = 1;


-- 11. PERCENT_RANK() — percentile standing of each movie by box office
SELECT
    title, worldwide_box_office_usd,
    ROUND(PERCENT_RANK() OVER (ORDER BY worldwide_box_office_usd) * 100, 1) AS percentile
FROM movies
ORDER BY worldwide_box_office_usd DESC;


-- 12. CUME_DIST() — cumulative distribution of IMDb ratings
SELECT
    title, imdb_rating,
    ROUND(CUME_DIST() OVER (ORDER BY imdb_rating) * 100, 1) AS cumulative_pct
FROM movies
WHERE imdb_rating IS NOT NULL
ORDER BY imdb_rating DESC;


-- ============================================================
-- VIEWS
-- ============================================================

-- View 1: Simplified leaderboard for dashboard/reporting use
CREATE VIEW IF NOT EXISTS vw_top_movies AS
SELECT
    title, year, genre, worldwide_box_office_usd, imdb_rating,
    RANK() OVER (ORDER BY worldwide_box_office_usd DESC) AS overall_rank
FROM movies;

-- Usage: SELECT * FROM vw_top_movies WHERE overall_rank <= 10;


-- View 2: Genre-level summary stats, ready for Power BI to consume directly
CREATE VIEW IF NOT EXISTS vw_genre_summary AS
SELECT
    genre,
    COUNT(*) AS movie_count,
    SUM(worldwide_box_office_usd) AS total_box_office,
    ROUND(AVG(worldwide_box_office_usd), 0) AS avg_box_office,
    ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
GROUP BY genre;

-- Usage: SELECT * FROM vw_genre_summary ORDER BY total_box_office DESC;


-- View 3: Movies still climbing (in theaters as of as_of_date) — for a "live" dashboard filter
CREATE VIEW IF NOT EXISTS vw_still_in_theaters AS
SELECT title, year, release_date, worldwide_box_office_usd, as_of_date, notes
FROM movies
WHERE notes LIKE '%still in theaters%' OR notes LIKE '%expected to cross%';

-- Usage: SELECT * FROM vw_still_in_theaters;
