USE foodpanda;

-- Q: How many reviews are in the table?
SELECT COUNT(*) FROM reviews;
-- RESULT: 334,119

-- Q: What do the first 5 rows look like?
SELECT * FROM reviews LIMIT 5;
-- RESULT: text in English (some Banglish), dates like 2023-11-02T06:48:08Z, ratings holds topic scores

-- Q: How many reviews have an overall score?
SELECT COUNT(*) FROM reviews WHERE ratings LIKE '%overall%';
-- RESULT: 334,119

-- Q: How many reviews have a food score?
SELECT COUNT(*) FROM reviews WHERE ratings LIKE '%restaurant_food%';
-- RESULT: 334,119

-- Q: How many reviews have a rider score?
SELECT COUNT(*) FROM reviews WHERE ratings LIKE '%rider%';
-- RESULT: 199,378

-- Q: Is there a delivery score?
SELECT COUNT(*) FROM reviews WHERE ratings LIKE '%delivery%';
-- RESULT: 0

-- Q: Is there a packaging score?
SELECT COUNT(*) FROM reviews WHERE ratings LIKE '%packag%';
-- RESULT: 0

-- Q: How many reviews mention "rider" in the review text?
SELECT COUNT(*) FROM reviews WHERE `text` LIKE '%rider%';
-- RESULT: 1,252

-- Q: Does the type column have different values?
SELECT type, COUNT(*) FROM reviews GROUP BY type;
-- RESULT: user = 334,119 (type column dropped)

-- Q: What do the labels mean? How do labels relate to star ratings?
SELECT labels, ratings_overall, COUNT(*)
FROM reviews
GROUP BY labels, ratings_overall
ORDER BY labels, ratings_overall;
-- RESULT: label 1, 1 star = 127,409
--         label 1, 2 stars = 33,866
--         label 2, 3 stars = 39,315
--         label 3, 4 stars = 39,330
--         label 3, 5 stars = 94,199

-- Q: What is the average star rating of all reviews?
SELECT AVG(ratings_overall) FROM reviews;
-- RESULT: 2.82

-- Q: How many reviews are there in each month?
SELECT LEFT(createdAt, 7) AS month, COUNT(*) AS total_reviews
FROM reviews
GROUP BY month
ORDER BY month;
-- RESULT: 2022-11 14,830 | 2022-12 20,310 | 2023-01 18,671 | 2023-02 16,774
--         2023-03 20,415 | 2023-04 20,685 | 2023-05 31,248 | 2023-06 31,616
--         2023-07 33,935 | 2023-08 38,796 | 2023-09 36,332 | 2023-10 38,607
--         2023-11 11,900

-- Q: In which months does the rider score appear, and how often?
SELECT LEFT(createdAt, 7) AS month, COUNT(*) AS reviews_with_rider_score
FROM reviews
WHERE ratings LIKE '%rider%'
GROUP BY month
ORDER BY month;
-- RESULT: 2022-11 10,269 | 2022-12 14,263 | 2023-01 15,242 | 2023-02 15,339
--         2023-03 19,134 | 2023-04 16,010 | 2023-05 10,607 | 2023-06 19,787
--         2023-07 27,971 | 2023-08 31,619 | 2023-09 17,236 | 2023-10 924
--         2023-11 977

-- Q: Are there duplicate reviews? (compare total rows with different review IDs)
SELECT COUNT(*) FROM reviews;
SELECT COUNT(DISTINCT uuid) FROM reviews;
-- RESULT: 334,119 and 334,119 (no duplicates)

-- Q: Is the food score the same as the overall star rating in every review?
SELECT COUNT(*) FROM reviews
WHERE ratings LIKE CONCAT("%'restaurant_food', 'score': ", ratings_overall, "}%");
-- RESULT: 334,119 (food score is identical to the overall rating in every review).

-- Q: What is the average rating of reviews that HAVE a rider score?
SELECT AVG(ratings_overall) FROM reviews WHERE ratings LIKE '%rider%';
-- RESULT:-- RESULT: 2.8298.

-- Q: What is the average rating of reviews that DO NOT have a rider score?
SELECT AVG(ratings_overall) FROM reviews WHERE ratings NOT LIKE '%rider%';
-- RESULT:-- RESULT: 2.7995.

