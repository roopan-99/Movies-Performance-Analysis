# 🎬 Movies Performance Analysis

Analysis of the top-performing movies of 2025 and 2026 — real worldwide box
office figures and IMDb ratings, researched from Box Office Mojo, Variety,
Deadline, Forbes, ScreenRant, and IMDb (see **Data Sources** below).

## 📁 Folder Structure
```
Movies-Performance-Analysis/
│
├── dataset/
│   ├── movies_2025_2026.csv     # 27 verified movies with box office & ratings
│   └── data_dictionary.xlsx     # column definitions, types, sources
│
├── sql/
│   ├── create_database.sql      # table schema + indexes
│   ├── insert_data.sql          # INSERT statements for all 27 rows
│   ├── analysis_queries.sql     # 25 core analysis queries
│   └── advanced_queries.sql     # CTEs, window functions, views
│
├── powerbi/
│   └── PowerBI_Setup_Guide.md   # step-by-step guide + DAX measures
│
├── images/
│   ├── top10_box_office.png
│   ├── avg_rating_by_genre.png
│   ├── budget_vs_boxoffice.png
│   └── year_comparison.png
│
├── README.md
└── LICENSE
```

## 📊 Dataset

`dataset/movies_2025_2026.csv` — 27 movies (14 from 2025, 13 from 2026).
Full column definitions, types, nullability, and sources are in
`dataset/data_dictionary.xlsx` (2 sheets: column reference + data quality notes).

| Column | Description |
|---|---|
| `title` | Movie title |
| `year` | Release year |
| `release_date` | Theatrical release date |
| `country` | Country of origin |
| `genre` | Primary genre |
| `runtime_min` | Runtime in minutes |
| `budget_usd` | Production budget (USD) |
| `worldwide_box_office_usd` | Worldwide theatrical gross (USD) |
| `imdb_rating` | IMDb rating out of 10 |
| `distributor` | Studio/distributor |
| `as_of_date` | Date the box office figure was last confirmed accurate |
| `notes` | Context (records set, franchise notes, etc.) |

## ⚠️ Important note on box office figures
Box office totals are a **moving target** for any movie still in theaters.
Several 2026 titles (*The Odyssey*, *Spider-Man: Brand New Day*, *Toy Story 5*,
*Michael*, *The Super Mario Galaxy Movie*) were still playing in theaters as
of the `as_of_date` for their row (early August 2026) and were actively
climbing — by the time you read this, their real totals will be higher. This
is normal for box office data and not an error; check the `as_of_date`
column and update from Box Office Mojo / The Numbers for the latest figures
if needed.

*Spider-Man: Brand New Day* has no `imdb_rating` because it was released too
recently (July 31, 2026) to have an established rating at data collection time.

## 🗄️ SQL

Run in this order:
1. `sql/create_database.sql` — creates the `movies` table + indexes
2. `sql/insert_data.sql` — loads all 27 rows
3. `sql/analysis_queries.sql` — 25 queries: top grossing, best-rated, ROI,
   genre/studio/country breakdowns, budget tiers, data-quality checks, etc.
4. `sql/advanced_queries.sql` — window functions (`RANK`, `ROW_NUMBER`,
   `LAG`/`LEAD`, moving averages, `NTILE`, `PERCENT_RANK`, `CUME_DIST`),
   multi-level CTEs, and 3 reusable views (`vw_top_movies`,
   `vw_genre_summary`, `vw_still_in_theaters`)

All queries validated to run against the actual dataset (SQLite tested;
compatible with MySQL 8.0+ and PostgreSQL with no changes).

## 📈 Reference Charts (images/)


![Top 10 box office](images/top10_box_office.png)


## 🔍 Key insights
- **Ne Zha 2** ($2.26B) is the highest-grossing film across both years, and
  the highest-grossing animated film of all time — driven almost entirely by
  the Chinese box office.
- **Demon Slayer: Kimetsu no Yaiba Infinity Castle** has the best ROI among
  2025's top films: a $20M budget returned $733M (36.7x).
- Animation was the strongest-performing genre by average box office across
  both years, led by Ne Zha 2, Zootopia 2, and Toy Story 5.
- 2026 already has multiple $1B+ films (*Super Mario Galaxy*, *Michael*,
  *Toy Story 5*) with *The Odyssey* and *Spider-Man: Brand New Day* both
  expected to join that club within days of this dataset's `as_of_date`.
- Critically-acclaimed originals like **Obsession** (IMDb 8.0, $750K budget)
  and **Backrooms** ($10M budget) show low-budget horror had an unusually
  strong run in 2026.

## 🚀 How to use
- **SQL:** load into MySQL/PostgreSQL/SQLite using the 4 scripts in `sql/`
  in order (see above).
- **Power BI:** follow `powerbi/PowerBI_Setup_Guide.md` for the data model,
  DAX measures, and page-by-page visual layout.
- **Data dictionary:** open `dataset/data_dictionary.xlsx` for full column
  documentation before building on top of the dataset.

## 📚 Data Sources
All figures were manually researched and cross-checked across multiple
outlets in August 2026:
- Box Office Mojo / The Numbers (box office aggregation)
- Forbes — "Highest-Grossing Movies of 2025" (Tim Lammers, Olivia Singh)
- Variety & Deadline — 2026 box office milestone reporting (*The Odyssey*,
  *Spider-Man: Brand New Day*, *Toy Story 5*)
- ScreenRant — "10 Highest-Grossing Movies of 2026 (So Far)"
- Wikipedia — 2025/2026 box office number-one film lists
- IMDb — title ratings (imdb.com)
- NewMovieToWatch (TMDb-sourced) — supplementary ratings, budgets, runtimes

No AI-generated or estimated figures are used — every number traces back to
a dated news source or IMDb/Box Office Mojo listing.

## 📌 Possible extensions
- Add domestic vs. international box office split per movie
- Track weekly box office trajectory instead of a single point-in-time total
- Add Rotten Tomatoes critic/audience scores alongside IMDb
- Expand to a full top-50 list per year
