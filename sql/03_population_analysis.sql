# =========================================================
# PROJECT: Leipzig Demographic Analytics
# FILE: 03_population_analysis.sql
# PURPOSE: Analyze demographic and population trends
# =========================================================

USE leipzig_analytics;

# ---------------------------------------------------------
# 1. TOTAL POPULATION BY YEAR
# ---------------------------------------------------------

select Jahr , sum(Deutsche_Frauen+Deutsche_Maenner+Auslaendische_Frauen+Auslaendische_Maenner) as total_population
from leipzig_people
group by Jahr;
# ---------------------------------------------------------
# 2. HIGHEST AND LOWEST POPULATION YEARS
# ---------------------------------------------------------
select 
    Jahr ,  
    sum(Deutsche_Frauen+Deutsche_Maenner+Auslaendische_Frauen+Auslaendische_Maenner) as total_population
from leipzig_people
group by Jahr
order by Jahr desc;    

select 
    Jahr ,  
    sum(Deutsche_Frauen+Deutsche_Maenner+Auslaendische_Frauen+Auslaendische_Maenner) as total_population
from leipzig_people
group by Jahr
order by Jahr asc;    

#order use the union 
select Jahr,
sum(Deutsche_Frauen+Deutsche_Maenner+Auslaendische_Frauen+Auslaendische_Maenner) as total_population
from leipzig_people
group by Jahr
having Jahr = (select max(Jahr) from leipzig_people)
		or Jahr = (select min(Jahr) from leipzig_people)
order by jahr;

# ---------------------------------------------------------
# 3. YEAR-OVER-YEAR POPULATION CHANGE
# ---------------------------------------------------------

Select Jahr , sum(
Deutsche_Maenner+
Deutsche_Frauen+
Auslaendische_Frauen+
Auslaendische_Maenner) as total_population,
lag(
sum(Deutsche_Maenner+
Deutsche_Frauen+
Auslaendische_Frauen+
Auslaendische_Maenner),1)
over(order by Jahr) As pervious_population,
round(sum(
Deutsche_Maenner+
Deutsche_Frauen+
Auslaendische_Frauen+
Auslaendische_Maenner) -
lag(
sum(Deutsche_Maenner+
Deutsche_Frauen+
Auslaendische_Frauen+
Auslaendische_Maenner),1)
over(order by Jahr) ) as differnce_population
From leipzig_people
group by Jahr;
# ---------------------------------------------------------
# 4. GERMAN VS FOREIGN POPULATION
# ---------------------------------------------------------
Select Jahr, 
	sum(Deutsche_Frauen+Deutsche_Maenner) as Deutsche,
    sum(Auslaendische_Frauen+Auslaendische_Maenner) as Auslaendische
from leipzig_people
group by Jahr;

# ---------------------------------------------------------
# 5. MALE VS FEMALE POPULATION
# ---------------------------------------------------------
Select Jahr, 
	sum(Deutsche_Frauen+Auslaendische_Frauen) as Total_Frau,
    sum(Deutsche_Maenner+Auslaendische_Maenner) as Total_Maenner
from leipzig_people
group by Jahr;

# ---------------------------------------------------------
# 6. POPULATION BY AGE GROUP
# ---------------------------------------------------------
select `Alter`,
sum(Deutsche_Frauen+Deutsche_Maenner+Auslaendische_Frauen+Auslaendische_Maenner) as total_population
from leipzig_people
group by `Alter`;


# ---------------------------------------------------------
# 7. AGE GROUP PERCENTAGES
# ---------------------------------------------------------
WITH age_analysis AS (
    SELECT
        Jahr,

        SUM(
            Deutsche_Maenner +
            Deutsche_Frauen +
            Auslaendische_Maenner +
            Auslaendische_Frauen
        ) AS total_population,

        SUM(
            CASE WHEN `Alter` BETWEEN 0 AND 17
            THEN Deutsche_Maenner + Deutsche_Frauen +
                 Auslaendische_Maenner + Auslaendische_Frauen
            ELSE 0 END
        ) AS children,

        SUM(
            CASE WHEN `Alter` BETWEEN 18 AND 29
            THEN Deutsche_Maenner + Deutsche_Frauen +
                 Auslaendische_Maenner + Auslaendische_Frauen
            ELSE 0 END
        ) AS young_adults,

        SUM(
            CASE WHEN `Alter` BETWEEN 30 AND 44
            THEN Deutsche_Maenner + Deutsche_Frauen +
                 Auslaendische_Maenner + Auslaendische_Frauen
            ELSE 0 END
        ) AS adults,

        SUM(
            CASE WHEN `Alter` BETWEEN 45 AND 64
            THEN Deutsche_Maenner + Deutsche_Frauen +
                 Auslaendische_Maenner + Auslaendische_Frauen
            ELSE 0 END
        ) AS middle_aged,

        SUM(
            CASE WHEN `Alter` >= 65
            THEN Deutsche_Maenner + Deutsche_Frauen +
                 Auslaendische_Maenner + Auslaendische_Frauen
            ELSE 0 END
        ) AS seniors

    FROM leipzig_people
    GROUP BY Jahr
)

SELECT
    Jahr,
    total_population,

    ROUND(children * 100.0 / NULLIF(total_population, 0), 2)
        AS children_percentage,

    ROUND(young_adults * 100.0 / NULLIF(total_population, 0), 2)
        AS young_adults_percentage,

    ROUND(adults * 100.0 / NULLIF(total_population, 0), 2)
        AS adults_percentage,

    ROUND(middle_aged * 100.0 / NULLIF(total_population, 0), 2)
        AS middle_aged_percentage,

    ROUND(seniors * 100.0 / NULLIF(total_population, 0), 2)
        AS seniors_percentage

FROM age_analysis
ORDER BY Jahr;

# ---------------------------------------------------------
# 8. FOREIGN POPULATION PERCENTAGE
# ---------------------------------------------------------

SELECT
    Jahr,

    SUM(
        Deutsche_Maenner +
        Deutsche_Frauen +
        Auslaendische_Maenner +
        Auslaendische_Frauen
    ) AS total_population,

    SUM(
        Auslaendische_Maenner +
        Auslaendische_Frauen
    ) AS foreign_population,

    ROUND(
        SUM(
            Auslaendische_Maenner +
            Auslaendische_Frauen
        ) * 100.0 /
        NULLIF(
            SUM(
                Deutsche_Maenner +
                Deutsche_Frauen +
                Auslaendische_Maenner +
                Auslaendische_Frauen
            ),
            0
        ),
        2
    ) AS foreign_population_percentage

FROM leipzig_people
GROUP BY Jahr
ORDER BY Jahr;

# ---------------------------------------------------------
# 9. POPULATION GROWTH RATE
# ---------------------------------------------------------

WITH yearly_population AS (
    SELECT
        Jahr,
        SUM(
            Deutsche_Maenner +
            Deutsche_Frauen +
            Auslaendische_Maenner +
            Auslaendische_Frauen
        ) AS total_population
    FROM leipzig_people
    GROUP BY Jahr
),

population_change AS (
    SELECT
        Jahr,
        total_population,

        LAG(total_population) OVER (
            ORDER BY Jahr
        ) AS previous_population

    FROM yearly_population
)

SELECT
    Jahr,
    total_population,
    previous_population,

    total_population - previous_population
        AS population_change,

    ROUND(
        (total_population - previous_population) * 100.0 /
        NULLIF(previous_population, 0),
        2
    ) AS growth_rate_percentage

FROM population_change
ORDER BY Jahr;
# ---------------------------------------------------------
# 10. KEY ANALYTICAL FINDINGS
# ---------------------------------------------------------