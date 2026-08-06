-- ============================================================
-- Movies Performance Analysis — Database Schema
-- ============================================================
-- Creates the `movies` table used by insert_data.sql,
-- analysis_queries.sql, and advanced_queries.sql.
--
-- Written in standard ANSI SQL; tested against MySQL, PostgreSQL,
-- and SQLite (minor type-name differences noted inline).
-- ============================================================

DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    movie_id                    INTEGER PRIMARY KEY AUTOINCREMENT, -- MySQL: use INT AUTO_INCREMENT; Postgres: use SERIAL/GENERATED ALWAYS AS IDENTITY
    title                       VARCHAR(150)   NOT NULL,
    year                        INT            NOT NULL,
    release_date                DATE           NOT NULL,
    country                     VARCHAR(50)    NOT NULL,
    genre                       VARCHAR(50)    NOT NULL,
    runtime_min                 INT,
    budget_usd                  BIGINT,
    worldwide_box_office_usd    BIGINT         NOT NULL,
    imdb_rating                 DECIMAL(3,1),
    distributor                 VARCHAR(100),
    as_of_date                  DATE           NOT NULL,
    notes                       VARCHAR(300)
);

-- Helpful indexes for the analysis queries
CREATE INDEX idx_movies_year   ON movies(year);
CREATE INDEX idx_movies_genre  ON movies(genre);
CREATE INDEX idx_movies_rating ON movies(imdb_rating);

-- ------------------------------------------------------------
-- Notes:
-- * AUTOINCREMENT is SQLite syntax. For MySQL replace the
--   movie_id line with: movie_id INT AUTO_INCREMENT PRIMARY KEY,
--   For PostgreSQL use: movie_id SERIAL PRIMARY KEY,
-- * imdb_rating and runtime_min/budget_usd allow NULL because a
--   couple of very recently released 2026 titles do not have
--   confirmed values yet (see dataset notes column).
-- ------------------------------------------------------------
