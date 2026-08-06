-- ============================================================
-- Movies Performance Analysis — Data Load
-- ============================================================
-- Populates the `movies` table (see create_database.sql) with
-- the 27 verified rows from dataset/movies_2025_2026.csv.
-- Run create_database.sql first.
-- ============================================================

INSERT INTO movies (title, year, release_date, country, genre, runtime_min, budget_usd, worldwide_box_office_usd, imdb_rating, distributor, as_of_date, notes) VALUES
('Ne Zha 2', 2025, '2025-01-29', 'China', 'Animation', 144, 80000000, 2259822417, 8.2, NULL, '2026-02-14', 'Highest-grossing animated film of all time; ~98% of gross from China'),
('Zootopia 2', 2025, '2025-11-26', 'USA', 'Animation', 108, 150000000, 1868208796, 7.4, 'Disney', '2026-02-14', 'Fastest PG film to reach $1B; final theatrical run total'),
('Avatar: Fire and Ash', 2025, '2025-12-19', 'USA', 'Science Fiction', 198, 350000000, 1490477656, 7.2, '20th Century Studios (Disney)', '2026-02-14', '3rd highest-grossing film of 2025; ended theatrical run'),
('Lilo & Stitch', 2025, '2025-05-17', 'USA', 'Family', 108, 100000000, 1038027526, 6.7, 'Disney', '2026-02-14', 'Live-action remake; first 2025 film to reach $1B'),
('A Minecraft Movie', 2025, '2025-03-31', 'USA', 'Family', 101, 150000000, 960387780, 5.6, 'Warner Bros.', '2026-02-14', 'Highest domestic-grossing video game adaptation'),
('Jurassic World Rebirth', 2025, '2025-06-23', 'USA', 'Science Fiction', 134, 180000000, 869146189, 5.8, 'Universal', '2026-02-14', '7th installment in the Jurassic Park/World franchise'),
('Demon Slayer: Kimetsu no Yaiba Infinity Castle', 2025, '2025-07-18', 'Japan', 'Animation', 156, 20000000, 733030221, 8.4, 'Sony/Crunchyroll', '2026-02-14', 'Highest ROI (36.7x budget) among 2025''s top films'),
('How to Train Your Dragon', 2025, '2025-06-06', 'USA', 'Fantasy', 125, 150000000, 636351148, 7.7, 'Universal', '2026-02-14', 'Live-action remake of the 2010 animated film'),
('F1: The Movie', 2025, '2025-06-25', 'USA', 'Action', 156, 300000000, 634142436, 7.6, 'Apple Original Films/Warner Bros.', '2026-02-14', 'Widest theatrical release for an Apple Original Film'),
('Superman', 2025, '2025-07-09', 'USA', 'Science Fiction', 130, 225000000, 618723803, 7, 'Warner Bros.', '2026-02-14', 'First film of the rebooted DC Universe'),
('Mission: Impossible - The Final Reckoning', 2025, '2025-05-17', 'USA', 'Action', 170, 400000000, 598767057, 7.1, 'Paramount', '2026-02-14', '8th and reportedly final entry in the franchise'),
('Wicked: For Good', 2025, '2025-11-19', 'USA', 'Fantasy', 137, 150000000, 539042601, 6.6, 'Universal', '2026-02-14', 'Concludes the two-part Wicked film adaptation'),
('The Fantastic Four: First Steps', 2025, '2025-07-23', 'USA', 'Science Fiction', 115, 229600000, 521858728, 6.8, 'Disney/Marvel Studios', '2026-02-14', '2025''s second-highest-grossing superhero film after Superman'),
('Sinners', 2025, '2025-04-18', 'USA', 'Horror', 138, 95000000, 370000000, 7.5, 'Warner Bros.', '2025-07-26', 'Original horror film; 8th highest-grossing horror movie ever worldwide'),
('The Super Mario Galaxy Movie', 2026, '2026-04-01', 'USA', 'Animation', 98, 110000000, 1020000000, 6.3, 'Illumination/Universal', '2026-08-03', '2026''s first film to cross $1B; sequel to The Super Mario Bros. Movie'),
('Michael', 2026, '2026-04-22', 'USA', 'Music/Biopic', 128, 250000000, 1020000000, 7.4, 'Lionsgate', '2026-08-03', 'Michael Jackson biopic; highest-grossing musician biopic of all time'),
('Toy Story 5', 2026, '2026-06-17', 'USA', 'Animation', 102, 250000000, 1066000000, 7.5, 'Disney/Pixar', '2026-08-03', 'Highest-grossing film of 2026 so far; biggest Toy Story film to date'),
('Spider-Man: Brand New Day', 2026, '2026-07-31', 'USA', 'Action', NULL, NULL, 927000000, NULL, 'Sony/Marvel Studios', '2026-08-03', 'Still in theaters; 2nd-biggest domestic opening ever ($355M); no IMDb rating yet at time of writing'),
('The Odyssey', 2026, '2026-07-17', 'USA', 'Adventure', 173, 250000000, 911000000, 8.3, 'Universal', '2026-08-03', 'Christopher Nolan film; still in theaters and expected to cross $1B within days'),
('Project Hail Mary', 2026, '2026-03-20', 'USA', 'Science Fiction', 157, 200000000, 681404846, 8.2, 'Amazon MGM', '2026-08-03', 'Amazon MGM''s highest-grossing film to date'),
('The Devil Wears Prada 2', 2026, '2026-05-01', 'USA', 'Comedy', 119, 100000000, 677490830, 6.5, '20th Century Studios (Disney)', '2026-08-03', 'Sequel to the 2006 hit; strong international performance'),
('Pegasus 3', 2026, '2026-02-17', 'China', 'Drama', 126, 80000000, 656400000, 6.6, NULL, '2026-08-03', 'Highest-grossing film in its franchise; driven almost entirely by China box office'),
('Hoppers', 2026, '2026-03-06', 'USA', 'Animation', 104, 150000000, 372010783, 7.2, 'Disney/Pixar', '2026-08-03', 'Pixar''s 2nd-biggest original film since 2017''s Coco'),
('Obsession', 2026, '2026-05-15', 'USA', 'Horror', 108, 750000, 474700000, 8, 'Focus Features/Blumhouse', '2026-08-03', 'Low-budget horror breakout; highest-grossing Focus Features film ever'),
('The Mandalorian and Grogu', 2026, '2026-05-22', 'USA', 'Action', 132, 165000000, 321764990, 6.9, 'Disney/Lucasfilm', '2026-08-03', 'First live-action Star Wars film in 7 years'),
('Wuthering Heights', 2026, '2026-02-13', 'UK/USA', 'Romance', 136, 80000000, 241601072, 6.1, 'Warner Bros.', '2026-08-03', 'Emerald Fennell adaptation starring Margot Robbie and Jacob Elordi'),
('Backrooms', 2026, '2026-05-29', 'USA', 'Horror', 111, 10000000, 277353084, 7, 'A24', '2026-08-03', 'A24''s biggest domestic opening ever; based on the creepypasta phenomenon');
