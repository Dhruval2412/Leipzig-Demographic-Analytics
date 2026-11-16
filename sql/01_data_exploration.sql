# 01_data_exploration.sql
# Project: Leipzig Demographic Analytics
# Database: leipzig_analytics
# Tool: MySQL 8
# Purpose: Explore the structure, coverage and demographic patterns
#          of Leipzig's population dataset.

USE leipzig_analytics;


-- =====================================================
-- 1. DATASET OVERVIEW
-- =====================================================

-- 1.1 Count total number of records

SELECT
    COUNT(*) AS total_records
FROM leipzig_people;


-- 1.2 Count total number of columns

SELECT
    COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'leipzig_analytics'
  AND TABLE_NAME = 'leipzig_people';


-- 1.3 Inspect column names, data types and nullability

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'leipzig_analytics'
  AND TABLE_NAME = 'leipzig_people'
ORDER BY ORDINAL_POSITION;


-- =====================================================
-- 2. DATA PREVIEW
-- =====================================================

-- 2.1 Display the first 10 records

SELECT *
FROM leipzig_people
LIMIT 10;


-- =====================================================
-- 3. DATASET COVERAGE
-- =====================================================

-- 3.1 Identify the year range and dataset size

SELECT
    MIN(Jahr) AS first_year,
    MAX(Jahr) AS last_year,
    COUNT(*) AS total_records,
    COUNT(DISTINCT Jahr) AS total_years
FROM leipzig_people;


-- 3.2 Identify the youngest and oldest age in the dataset

SELECT
    MIN(`Alter`) AS youngest_age,
    MAX(`Alter`) AS oldest_age
FROM leipzig_people;


-- 3.3 Count records available for each year

SELECT
    Jahr,
    COUNT(*) AS records_per_year
FROM leipzig_people
GROUP BY Jahr
ORDER BY Jahr;


-- 3.4 Identify the age range for each year

SELECT
    Jahr,
    MIN(`Alter`) AS youngest_age,
    MAX(`Alter`) AS oldest_age
FROM leipzig_people
GROUP BY Jahr
ORDER BY Jahr;


-- =====================================================
-- 4. POPULATION EXPLORATION
-- =====================================================

-- 4.1 Calculate total population for each year
-- Combines German and foreign male and female population figures.

SELECT
    Jahr,
    SUM(
        Deutsche_Frauen +
        Deutsche_Maenner +
        Auslaendische_Frauen +
        Auslaendische_Maenner
    ) AS total_population
FROM leipzig_people
GROUP BY Jahr
ORDER BY Jahr;


-- 4.2 Calculate weighted average age for each year

SELECT
    Jahr,
    ROUND(
        SUM(
            `Alter` * (
                Deutsche_Frauen +
                Deutsche_Maenner +
                Auslaendische_Frauen +
                Auslaendische_Maenner
            )
        ) /
        NULLIF(
            SUM(
                Deutsche_Frauen +
                Deutsche_Maenner +
                Auslaendische_Frauen +
                Auslaendische_Maenner
            ),
            0
        ),
        2
    ) AS average_age
FROM leipzig_people
GROUP BY Jahr
ORDER BY Jahr;


-- =====================================================
-- 5. POPULATION RANKING
-- =====================================================

-- 5.1 Identify the year with the highest population

SELECT
    Jahr,
    SUM(
        Deutsche_Frauen +
        Deutsche_Maenner +
        Auslaendische_Frauen +
        Auslaendische_Maenner
    ) AS total_population
FROM leipzig_people
GROUP BY Jahr
ORDER BY total_population DESC
LIMIT 1;


-- 5.2 Identify the year with the lowest population

SELECT
    Jahr,
    SUM(
        Deutsche_Frauen +
        Deutsche_Maenner +
        Auslaendische_Frauen +
        Auslaendische_Maenner
    ) AS total_population
FROM leipzig_people
GROUP BY Jahr
ORDER BY total_population ASC
LIMIT 1;


-- =====================================================
-- END OF DATA EXPLORATION
-- Next: 02_data_quality.sql
-- =====================================================