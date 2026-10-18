-- Q: What is the average rating in each month?
SELECT LEFT(createdAt, 7) AS month, AVG(ratings_overall) AS avg_rating
FROM reviews
GROUP BY month
ORDER BY month;
-- RESULT: 2022-11 2.8082 | 2022-12 2.7307 | 2023-01 2.8263 | 2023-02 2.8375
--         2023-03 2.7564 | 2023-04 2.7446 | 2023-05 2.8271 | 2023-06 2.7970
--         2023-07 2.7809 | 2023-08 2.8292 | 2023-09 2.8418 | 2023-10 2.8845
--         2023-11 2.9724 (partial month, 11,900 reviews)

-- Q: What is the average rating in each city, and how many reviews does each have?
SELECT city, COUNT(*) AS total_reviews, AVG(ratings_overall) AS avg_rating
FROM reviews
GROUP BY city
ORDER BY total_reviews DESC;
-- RESULT: Dhaka        266,091 reviews, avg 2.8228
--         Chittagong    38,290 reviews, avg 2.8038
--         Sylhet        14,821 reviews, avg 2.8279
--         Narayanganj    6,888 reviews, avg 2.8123
--         Savar          4,830 reviews, avg 2.7166
--         Gazipur        3,187 reviews, avg 2.6564
--         Moulvibazar       12 reviews, avg 3.5000 

-- Q: What is the average rating for each cuisine? (top 15 by number of reviews)
SELECT primary_cuisine, COUNT(*) AS total_reviews, AVG(ratings_overall) AS avg_rating
FROM reviews
GROUP BY primary_cuisine
ORDER BY total_reviews DESC
LIMIT 15;
-- RESULT: Rice Dishes  66,758 reviews, avg 2.7730
--         Snacks       52,392 reviews, avg 2.7914
--         Curry        49,409 reviews, avg 2.8494
--         Turkish      31,411 reviews, avg 2.6791
--         Italian      30,121 reviews, avg 2.8476
--         Chicken      28,367 reviews, avg 2.7989
--         Cakes        17,617 reviews, avg 2.8811
--         Beverage     12,096 reviews, avg 2.8665
--         Burgers       9,571 reviews, avg 3.0444
--         Dessert       5,676 reviews, avg 3.2491
--         Wraps         4,525 reviews, avg 2.9412
--         Juice Corner  4,097 reviews, avg 3.0676
--         Kebab         3,297 reviews, avg 2.4813
--         Sandwiches    2,415 reviews, avg 2.9089
--         Chinese       1,868 reviews, avg 3.3742


-- Q: How many reviews are 1 or 2 stars?
SELECT COUNT(*) FROM reviews WHERE ratings_overall <= 2;
-- RESULT:161,275 (48.3% of all reviews)

-- Q: How many 1-2 star reviews mention "late" or "delay"?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%late%' OR `text` LIKE '%delay%');
-- RESULT:4,650 (2.9% of 1-2 star reviews)

-- Q: How many 1-2 star reviews mention "cold"?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND `text` LIKE '%cold%';
-- RESULT:6,842 (4.2% of 1-2 star reviews)

-- Q: How many 1-2 star reviews mention "missing" or "wrong"?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%missing%' OR `text` LIKE '%wrong%');
-- RESULT:5,431 (3.4% of 1-2 star reviews)

-- Q: What do 1-star reviews actually say? (30 random examples)
SELECT `text` FROM reviews
WHERE ratings_overall = 1
ORDER BY RAND()
LIMIT 30;
-- RESULT: read 30 random 1-star reviews. Main complaints: poor taste/quality, small quantity,
--         stale or not fresh food, wrong/missing items, insects. Late delivery in only 2 of 30.

-- Q: How many 1-2 star reviews complain about small quantity?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%quantity%' OR `text` LIKE '%portion%' OR `text` LIKE '%small%'
  OR `text` LIKE '%amount%' OR `text` LIKE '%so less%' OR `text` LIKE '%too less%');
-- RESULT:20,260 (12.6% of 161,275)

-- Q: How many 1-2 star reviews say the food was stale, not fresh or spoiled?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%stale%' OR `text` LIKE '%not fresh%' OR `text` LIKE '%pocha%'
  OR `text` LIKE '%rotten%' OR `text` LIKE '%expired%' OR `text` LIKE '%smell%');
-- RESULT:12,633 (7.8%)

-- Q: How many 1-2 star reviews complain about taste or quality?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%taste%' OR `text` LIKE '% test %' OR `text` LIKE '%quality%');
-- RESULT:32,405 (20.1%)

-- Q: How many 1-2 star reviews mention wrong or missing items? (wider than before)
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%missing%' OR `text` LIKE '%wrong%' OR `text` LIKE '%not provide%'
  OR `text` LIKE '%not send%' OR `text` LIKE '%not according%' OR `text` LIKE '%did not get%');
-- RESULT:6,422 (4.0%)

-- Q: How many 1-2 star reviews mention insects or hygiene problems?
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '%insect%' OR `text` LIKE '% ant %' OR `text` LIKE '%cockroach%'
  OR `text` LIKE '%worm%' OR `text` LIKE '% hair %');
-- RESULT:1,283 (0.8%)


-- Q: How many 1-2 star reviews mention late delivery? (fixed: "% late %" no longer matches "plate")
SELECT COUNT(*) FROM reviews
WHERE ratings_overall <= 2
AND (`text` LIKE '% late %' OR `text` LIKE '%delay%');
-- RESULT:2,475 (1.5%)


-- Q: What do 1-2 star reviews say when they match none of my keywords? (30 examples)
SELECT `text` FROM reviews
WHERE ratings_overall <= 2
AND `text` NOT LIKE '%quantity%' AND `text` NOT LIKE '%portion%' AND `text` NOT LIKE '%small%'
AND `text` NOT LIKE '%amount%' AND `text` NOT LIKE '%so less%' AND `text` NOT LIKE '%too less%'
AND `text` NOT LIKE '%stale%' AND `text` NOT LIKE '%not fresh%' AND `text` NOT LIKE '%pocha%'
AND `text` NOT LIKE '%rotten%' AND `text` NOT LIKE '%expired%' AND `text` NOT LIKE '%smell%'
AND `text` NOT LIKE '%taste%' AND `text` NOT LIKE '% test %' AND `text` NOT LIKE '%quality%'
AND `text` NOT LIKE '%missing%' AND `text` NOT LIKE '%wrong%' AND `text` NOT LIKE '%not provide%'
AND `text` NOT LIKE '%not send%' AND `text` NOT LIKE '%not according%' AND `text` NOT LIKE '%did not get%'
AND `text` NOT LIKE '%insect%' AND `text` NOT LIKE '% ant %' AND `text` NOT LIKE '%cockroach%'
AND `text` NOT LIKE '%worm%' AND `text` NOT LIKE '% hair %'
AND `text` NOT LIKE '% late %' AND `text` NOT LIKE '%delay%'
AND `text` NOT LIKE '%cold%'
ORDER BY RAND()
LIMIT 30;
-- RESULT: read 30 random 1-2 star reviews that match none of my keywords.
--         About 8 of 30 are generic one-word reviews ("worst", "poor", "not good at all").
--         About 22 of 30 name a specific problem that my keywords missed because of spelling or phrasing:
--         "tasty", "test", "bugs", "telapoka" (cockroach), "bashi" (stale), "took so long", "took hrs",
--         "didn t give" (the data removes apostrophes). New themes: undercooked or raw food,
--         price and value, broken packaging, rider behavior.


-- Allow UPDATE without a key column (MySQL Workbench blocks this by default)
SET SQL_SAFE_UPDATES = 0;

-- Q: Copy all 1-2 star reviews into a new table

CREATE TABLE bad_reviews_themed AS
SELECT uuid, LEFT(createdAt, 7) AS month, city, primary_cuisine, ratings_overall, `text`
FROM reviews
WHERE ratings_overall <= 2;
-- RESULT: 161,275 bad reviews copied into bad_reviews_themed

-- Add an empty theme column
ALTER TABLE bad_reviews_themed ADD COLUMN theme VARCHAR(40);

-- Q: Give each review one theme (specific problems first, broad ones last)

UPDATE bad_reviews_themed SET theme = 'Insects or hygiene'
WHERE theme IS NULL
AND (`text` LIKE '%insect%' OR `text` LIKE '%bug%' OR `text` LIKE '%cockroach%'
  OR `text` LIKE '%telapoka%' OR `text` LIKE '%worm%' OR `text` LIKE '% ant %'
  OR `text` LIKE '% hair %');

UPDATE bad_reviews_themed SET theme = 'Raw or undercooked'
WHERE theme IS NULL
AND (`text` LIKE '% raw %' OR `text` LIKE '%half boiled%' OR `text` LIKE '%undercooked%'
  OR `text` LIKE '%not cooked%');

UPDATE bad_reviews_themed SET theme = 'Stale or spoiled'
WHERE theme IS NULL
AND (`text` LIKE '%stale%' OR `text` LIKE '%not fresh%' OR `text` LIKE '%pocha%'
  OR `text` LIKE '%rotten%' OR `text` LIKE '%expired%' OR `text` LIKE '%bashi%'
  OR `text` LIKE '%smell%');

UPDATE bad_reviews_themed SET theme = 'Wrong or missing items'
WHERE theme IS NULL
AND (`text` LIKE '%missing%' OR `text` LIKE '%wrong%' OR `text` LIKE '%not provide%'
  OR `text` LIKE '%didn t give%' OR `text` LIKE '%not send%' OR `text` LIKE '%not according%'
  OR `text` LIKE '%did not get%');

UPDATE bad_reviews_themed SET theme = 'Late delivery'
WHERE theme IS NULL
AND (`text` LIKE '% late %' OR `text` LIKE '%delay%' OR `text` LIKE '%took so long%'
  OR `text` LIKE '%took hrs%' OR `text` LIKE '%took hours%');

UPDATE bad_reviews_themed SET theme = 'Cold or soggy'
WHERE theme IS NULL
AND (`text` LIKE '%cold%' OR `text` LIKE '%soggy%');

UPDATE bad_reviews_themed SET theme = 'Packaging'
WHERE theme IS NULL
AND (`text` LIKE '%broken%' OR `text` LIKE '%spill%' OR `text` LIKE '%leak%'
  OR `text` LIKE '%packag%' OR `text` LIKE '%packing%');

UPDATE bad_reviews_themed SET theme = 'Small quantity'
WHERE theme IS NULL
AND (`text` LIKE '%quantity%' OR `text` LIKE '%portion%' OR `text` LIKE '%small%'
  OR `text` LIKE '%amount%' OR `text` LIKE '%so less%' OR `text` LIKE '%too less%'
  OR `text` LIKE '%less weight%' OR `text` LIKE '%only bones%');

UPDATE bad_reviews_themed SET theme = 'Price or value'
WHERE theme IS NULL
AND (`text` LIKE '%value for money%' OR `text` LIKE '%overpriced%'
  OR `text` LIKE '%expensive%' OR `text` LIKE '%price%');

UPDATE bad_reviews_themed SET theme = 'Rider behavior'
WHERE theme IS NULL
AND (`text` LIKE '%rider%' OR `text` LIKE '%delivery man%'
  OR `text` LIKE '%delivery boy%' OR `text` LIKE '%rude%');

UPDATE bad_reviews_themed SET theme = 'Taste or quality'
WHERE theme IS NULL
AND (`text` LIKE '%taste%' OR `text` LIKE '%tasty%' OR `text` LIKE '% test %'
  OR `text` LIKE '%quality%');

-- Very short reviews with no reason, like "worst" or "poor"
UPDATE bad_reviews_themed SET theme = 'Generic, no reason given'
WHERE theme IS NULL
AND CHAR_LENGTH(`text`) < 25;

-- Everything else
UPDATE bad_reviews_themed SET theme = 'Other'
WHERE theme IS NULL;
-- RESULT: 55,812 reviews fell into "Other". Every bad review now has one theme.

-- Q: How many reviews are in the new table? 
SELECT COUNT(*) FROM bad_reviews_themed;
-- RESULT: 161275

-- Q: How many bad reviews does each theme have?
SELECT theme, COUNT(*) FROM bad_reviews_themed
GROUP BY theme
ORDER BY COUNT(*) DESC;
-- RESULT: Other                      55,812  (34.6%)
--         Generic, no reason given   25,749  (16.0%)
--         Taste or quality           20,426  (12.7%)
--         Small quantity             17,745  (11.0%)
--         Stale or spoiled           13,171   (8.2%)
--         Wrong or missing items      7,143   (4.4%)
--         Cold or soggy               6,214   (3.9%)
--         Price or value              3,860   (2.4%)
--         Packaging                   3,490   (2.2%)
--         Late delivery               2,516   (1.6%)
--         Raw or undercooked          2,282   (1.4%)
--         Rider behavior              1,435   (0.9%)
--         Insects or hygiene          1,432   (0.9%)


-- Q: What do the reviews in the Other theme say? (30 random examples)
SELECT `text` FROM bad_reviews_themed
WHERE theme = 'Other'
ORDER BY RAND()
LIMIT 30;
-- RESULT: read 30 random "Other" reviews. About 13 of 30 are written mostly in Banglish (Bangla in English letters),
--         so my English keywords cannot match them. Many of those complain about small quantity or bad taste.
--         About 6 are specific English complaints with unusual wording ("not even a piece of meat", "foamy rice",
--         "only pcs", "too sweet", "too much chilli", "did not follow my order"). About 5 are order mix-ups
--         ("gave me puri", "did not follow my order", "chas is not served"). About 3 mention slow delivery in other words
--         ("delivery time is too long", "delivery khub bje"). The rest are vague or personal ("sadly to give such poor ratings").

-- Q: Move Banglish quantity complaints out of Other ("kom", "tuku", "only pcs", "not even a piece")
UPDATE bad_reviews_themed SET theme = 'Small quantity'
WHERE theme = 'Other'
AND (`text` LIKE '% kom%' OR `text` LIKE '%tuku%' OR `text` LIKE '%only pcs%'
  OR `text` LIKE '%not even a piece%' OR `text` LIKE '%less%');
-- RESULT:2,490 reviews moved from Other to Small quantity.

-- Q: Move wrong-order complaints out of Other
UPDATE bad_reviews_themed SET theme = 'Wrong or missing items'
WHERE theme = 'Other'
AND (`text` LIKE '%follow my order%' OR `text` LIKE '%not served%' OR `text` LIKE '%gave me%'
  OR `text` LIKE '%ordered%' OR `text` LIKE '%instead%');
-- RESULT:9,456 reviews moved from Other to Wrong or missing items.

-- Q: Move slow-delivery complaints out of Other
UPDATE bad_reviews_themed SET theme = 'Late delivery'
WHERE theme = 'Other'
AND (`text` LIKE '%too long%' OR `text` LIKE '%delivery khub%' OR `text` LIKE '%slow%'
  OR `text` LIKE '%waiting%');
-- RESULT:245 reviews moved from Other to Late delivery.


SELECT theme, COUNT(*) FROM bad_reviews_themed GROUP BY theme ORDER BY COUNT(*) DESC;

-- Q: How many bad reviews does each theme have? (final ranking, after the three updates)
-- RESULT: Other                      43,621  (27.0%)
--         Generic, no reason given   25,749  (16.0%)
--         Taste or quality           20,426  (12.7%)
--         Small quantity             20,235  (12.5%)
--         Wrong or missing items     16,599  (10.3%)
--         Stale or spoiled           13,171   (8.2%)
--         Cold or soggy               6,214   (3.9%)
--         Price or value              3,860   (2.4%)
--         Packaging                   3,490   (2.2%)
--         Late delivery               2,761   (1.7%)
--         Raw or undercooked          2,282   (1.4%)
--         Rider behavior              1,435   (0.9%)
--         Insects or hygiene          1,432   (0.9%)

UPDATE bad_reviews_themed SET theme = 'Other'
WHERE theme = 'Wrong or missing items'
AND `text` NOT LIKE '%missing%' AND `text` NOT LIKE '%wrong%' AND `text` NOT LIKE '%not provide%'
AND `text` NOT LIKE '%didn t give%' AND `text` NOT LIKE '%not send%' AND `text` NOT LIKE '%not according%'
AND `text` NOT LIKE '%did not get%' AND `text` NOT LIKE '%follow my order%'
AND `text` NOT LIKE '%not served%';


-- theme_ranking.csv
SELECT theme, COUNT(*) AS bad_reviews
FROM bad_reviews_themed
GROUP BY theme
ORDER BY bad_reviews DESC;
-- RESULT: exported as theme_ranking.csv (13 rows)

-- theme_by_cuisine.csv
SELECT primary_cuisine, theme, COUNT(*) AS bad_reviews
FROM bad_reviews_themed
WHERE primary_cuisine IN ('Rice Dishes','Snacks','Curry','Turkish','Italian',
                          'Chicken','Cakes','Beverage','Burgers','Dessert')
GROUP BY primary_cuisine, theme;
-- RESULT: exported as theme_by_cuisine.csv

-- monthly.csv
SELECT LEFT(createdAt, 7) AS month, COUNT(*) AS total_reviews, AVG(ratings_overall) AS avg_rating
FROM reviews
GROUP BY month
ORDER BY month;
-- RESULT: exported as monthly.csv (13 rows)

-- cuisine.csv
SELECT primary_cuisine, COUNT(*) AS total_reviews, AVG(ratings_overall) AS avg_rating
FROM reviews
GROUP BY primary_cuisine
HAVING COUNT(*) >= 1000
ORDER BY avg_rating;
-- RESULT: exported as cuisine.csv