# =========================================================
# PROJECT: Leipzig Demographic Analytics
# FILE: 02_data_quality.sql
# PURPOSE: Identify missing, duplicate and invalid data
# DATABASE: leipzig_analytics
# =========================================================

USE leipzig_analytics;

# ---------------------------------------------------------
# 1. CHECK MISSING VALUES
# ---------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    SUM(Jahr IS NULL) AS missing_jahr,
    SUM(`Alter` IS NULL) AS missing_alter,
    SUM(Deutsche_Maenner IS NULL) AS missing_deutsche_maenner,
    SUM(Deutsche_Frauen IS NULL) AS missing_deutsche_frauen,
    SUM(Auslaendische_Maenner IS NULL) AS missing_auslaendische_maenner,
    SUM(Auslaendische_Frauen IS NULL) AS missing_auslaendische_frauen
FROM leipzig_people;


# ---------------------------------------------------------
# 2. CHECK DUPLICATE YEAR-AGE COMBINATIONS
# ---------------------------------------------------------

SELECT
    Jahr,
    `Alter`,
    COUNT(*) AS record_count
FROM leipzig_people
GROUP BY Jahr, `Alter`
HAVING COUNT(*) > 1;


# ---------------------------------------------------------
# 3. CHECK INVALID AGE VALUES
# Expected age range: 0 to 100
# ---------------------------------------------------------

SELECT
    Jahr,
    `Alter`
FROM leipzig_people
WHERE `Alter` < 0
   OR `Alter` > 100;


# ---------------------------------------------------------
# 4. CHECK NEGATIVE POPULATION VALUES
# ---------------------------------------------------------

SELECT
    Jahr,
    `Alter`,
    Deutsche_Maenner,
    Deutsche_Frauen,
    Auslaendische_Maenner,
    Auslaendische_Frauen
FROM leipzig_people
WHERE Deutsche_Maenner < 0
   OR Deutsche_Frauen < 0
   OR Auslaendische_Maenner < 0
   OR Auslaendische_Frauen < 0;


# ---------------------------------------------------------
# 5. CHECK NUMBER OF RECORDS PER YEAR
# Expected: 101 records per year
# ---------------------------------------------------------

SELECT
    Jahr,
    COUNT(*) AS total_records
FROM leipzig_people
GROUP BY Jahr
HAVING COUNT(*) != 101
ORDER BY Jahr;


# ---------------------------------------------------------
# 6. CHECK AGE COVERAGE PER YEAR
# Expected: minimum age 0, maximum age 100,
# and 101 distinct ages per year
# ---------------------------------------------------------

SELECT
    Jahr,
    MIN(`Alter`) AS minimum_age,
    MAX(`Alter`) AS maximum_age,
    COUNT(DISTINCT `Alter`) AS distinct_ages
FROM leipzig_people
GROUP BY Jahr
HAVING MIN(`Alter`) != 0
    OR MAX(`Alter`) != 100
    OR COUNT(DISTINCT `Alter`) != 101
ORDER BY Jahr;


# ---------------------------------------------------------
# 7. CHECK YEAR COVERAGE
# Expected: 1992 to 2025 (34 distinct years)
# ---------------------------------------------------------

SELECT
    MIN(Jahr) AS first_year,
    MAX(Jahr) AS last_year,
    COUNT(DISTINCT Jahr) AS distinct_years
FROM leipzig_people;