-- Setup for the Foodpanda Bangladesh review project
-- Data: BDFoodSent (BRAC University). The CSV used here is a cleaned copy
-- (updatedAt column deleted in Excel)

CREATE DATABASE foodpanda;

USE foodpanda;

CREATE TABLE reviews (
  uuid VARCHAR(60),
  createdAt VARCHAR(30),
  `text` TEXT,
  ratings_overall INT,
  labels INT,
  ratings TEXT,
  `type` VARCHAR(20),
  likeCount INT,
  `name` VARCHAR(60),
  city VARCHAR(60),
  primary_cuisine VARCHAR(100),
  cuisines TEXT,
  review_number INT,
  restaurant_overall_rating DECIMAL(3,1),
  vertical_type_ids VARCHAR(100)
) CHARACTER SET utf8mb4;

-- Step 1: Tell MySQL where to get the data from
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Foodpanda-clean.csv'

-- Step 2: Choose which database table will receive the data
INTO TABLE reviews

-- Step 3: Handle Bengali language characters and emojis safely
CHARACTER SET utf8mb4

-- Step 4: Tell MySQL how values are separated in the CSV file
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'

-- Step 5: Tell MySQL how each row ends (Windows style line break)
LINES TERMINATED BY '\r\n'

-- Step 6: Skip the top row because it contains column headers (like "review_id", "rating")
IGNORE 1 LINES;

-- RESULT: 334,119 rows loaded, 0 skipped, 0 warnings.

ALTER TABLE reviews DROP COLUMN `type`;
-- RESULT: type dropped (it was 'user' in all 334,119 rows)