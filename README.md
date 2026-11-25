# Leipzig Demographic Analytics | SQL Portfolio Project

<p align="center">
  <strong>Exploring population demographics in Leipzig, Germany with MySQL 8</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL%208-4479A1?logo=mysql&logoColor=white" alt="MySQL 8" />
  <img src="https://img.shields.io/badge/Analysis-Exploratory%20Data%20Analysis-blue" alt="Exploratory Data Analysis" />
  <img src="https://img.shields.io/badge/Data-Leipzig%20Open%20Data-green" alt="Leipzig Open Data" />
  <img src="https://img.shields.io/badge/Status-In%20Progress-orange" alt="Status: In Progress" />
</p>

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Business Questions](#2-business-questions)
3. [Dataset](#3-dataset)
4. [Tech Stack](#4-tech-stack)
5. [SQL Skills Demonstrated](#5-sql-skills-demonstrated)
6. [Repository Structure](#6-repository-structure)
7. [Getting Started](#7-getting-started)
8. [Analysis Roadmap](#8-analysis-roadmap)
9. [Key Findings](#9-key-findings)
10. [Project Status](#10-project-status)
11. [Data License and Attribution](#11-data-license-and-attribution)
12. [Author](#12-author)

---

## 1. Project Overview

This project analyses demographic data from the city of Leipzig, Germany, using SQL on MySQL 8. It takes raw municipal open data (population by single year of age, split by gender and year) and turns it into structured, queryable tables and analytical insights.

The goal is to show a practical, end-to-end SQL workflow:

- importing and cleaning a real-world CSV,
- checking data quality before analysing,
- answering business questions with aggregation, joins, CTEs, and window functions.

## 2. Business Questions

Understanding population structure matters for urban planning, infrastructure, healthcare, education, and social services. This project aims to answer:

- How has Leipzig's population changed over time?
- How is the population distributed across age groups?
- How do male and female populations compare?
- Which age groups are the largest, and how has that changed?
- What demographic patterns (e.g. ageing, growth in young cohorts) can be identified?

## 3. Dataset

| Property | Value |
|---|---|
| **Source** | [Leipzig Open Data Portal](https://opendata.leipzig.de/) |
| **Dataset** | *Einwohner nach Altersjahrgang* (residents by single year of age) |
| **Location** | Leipzig, Germany |
| **Format** | CSV |
| **Content** | Population counts by year and age, with male and female figures |

[Download the original CSV](https://opendata.leipzig.de/dataset/409072d9-66d3-47a0-82a5-645cf881137e/resource/782fb780-3e37-4bb5-90f5-c5f97152e27d/download/einwohner_altersjahrgang.csv)

> The raw CSV is not committed to this repository. See [`data/README.md`](data/README.md) for download and import notes. Column names were renamed to English snake_case after import; the renaming is documented in `sql/01_data_exploration.sql`.

## 4. Tech Stack

| Technology | Purpose |
|---|---|
| MySQL 8 | Database and SQL analysis |
| MySQL Workbench | Administration, CSV import, query execution |
| Visual Studio Code | SQL editing |
| Git & GitHub | Version control and documentation |

## 5. SQL Skills Demonstrated

The scripts build up progressively:

| Level | Concepts |
|---|---|
| Foundations | Database and table creation, altering tables and columns, `SELECT`, `WHERE`, sorting, filtering |
| Aggregation | `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING` |
| Logic | `CASE` expressions (e.g. age-band bucketing) |
| Relational | `JOIN` operations |
| Advanced | Subqueries, Common Table Expressions (CTEs), window functions, ranking |
| Reliability | Data quality checks (nulls, duplicates, range and consistency checks) |

## 6. Repository Structure

```text
leipzig-demographic-sql-analysis/
│
├── README.md
│
├── data/
│   └── README.md                    # Data source and import instructions
│
├── sql/
│   ├── 01_data_exploration.sql      # Structure, columns, years, age range
│   ├── 02_data_quality.sql          # Nulls, duplicates, consistency checks
│   ├── 03_population_analysis.sql   # Totals, gender split, trends over time
│   ├── 04_age_group_analysis.sql    # Age bands and distribution
│   └── 05_advanced_sql.sql          # CTEs, window functions, rankings
│
├── analysis/
│   └── findings.md                  # Written insights and conclusions
│
└── screenshots/
    └── query_results/               # Result screenshots for key queries
```

## 7. Getting Started

### Prerequisites

- MySQL 8.0 or later
- MySQL Workbench (or any MySQL client)

### Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/Dhruval2412/leipzig-demographic-sql-analysis.git
   cd leipzig-demographic-sql-analysis
   ```

2. **Download the dataset** using the link in [Section 3](#3-dataset) and save it locally (it is not stored in this repo).

3. **Create the database and import the CSV**, for example with the Workbench *Table Data Import Wizard*, into a database such as `leipzig_demographics`.

4. **Run the scripts in order** from the `sql/` folder, `01` through `05`.

## 8. Analysis Roadmap

### A. Data Exploration
- Inspect table structure and column types.
- Identify available years and the age range.
- Review value ranges for male, female, and total counts.

### B. Data Quality
- Check for missing values and duplicate year/age rows.
- Verify that male + female equals the total, where a total is provided.
- Flag implausible or inconsistent values.

### C. Population Analysis
- Total population per year and growth over time.
- Male vs. female comparison.
- Distribution of population by age.

### D. Age Group Analysis
- Group ages into bands (e.g. children, working age, seniors) with `CASE`.
- Compare band shares across years.

### E. Advanced SQL
- Rank age groups per year with window functions.
- Use CTEs to build year-over-year comparisons.

## 9. Key Findings

*Findings will be added to [`analysis/findings.md`](analysis/findings.md) and summarised here once the analysis is complete.*

## 10. Project Status

- [x] Database creation
- [x] CSV import
- [x] Initial column renaming
- [x] Basic SQL exploration
- [x] Data quality investigation
- [x] Population analysis
- [x] Age group analysis
- [ ] Advanced SQL queries
- [ ] Final business insights

## 11. Data License and Attribution

The data is published by the City of Leipzig via its Open Data Portal. Please check the licence shown on the dataset page for the current terms of use and attribution requirements. All SQL code in this repository is my own work.

## 12. Author

**Dhruval Makwana**
M.Sc. SAP Engineering & Analytics student

Interests: Data Analytics · SQL · SAP · Applied AI · Data Engineering

[GitHub](https://github.com/Dhruval2412/) · [LinkedIn](https://linkedin.com/in/dhruval-makwana/)

---

*Developed as part of a hands-on SQL learning and portfolio-building journey using publicly available German municipal data.*
