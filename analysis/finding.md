
# Leipzig Demographic Analytics

## SQL Investigation Findings

**Project:** Leipzig Demographic Analytics
**Database:** `leipzig_analytics`
**Table:** `leipzig_people`
**Tools:** MySQL 8, MySQL Workbench, VS Code

---

# 1. Data Exploration Findings

**SQL file:** `01_data_exploration.sql`

### 1.1 Dataset Overview

The project uses Leipzig's open demographic dataset containing population information by year, age, nationality and gender.

| Attribute           | Dataset information |
| ------------------- | ------------------- |
| Total records       | 3,434               |
| Time period         | 1992–2025          |
| Distinct years      | 34                  |
| Age range           | 0–100              |
| Age groups per year | 101                 |
| Total columns       | 6                   |

### 1.2 Dataset Structure

The dataset contains the following columns:

| Column                    | Description   |
| ------------------------- | ------------- |
| `Jahr`                  | Year          |
| `Alter`                 | Age           |
| `Deutsche_Maenner`      | German men    |
| `Deutsche_Frauen`       | German women  |
| `Auslaendische_Maenner` | Foreign men   |
| `Auslaendische_Frauen`  | Foreign women |

### 1.3 Exploration Performed

The following SQL techniques were used:

- `COUNT()` to count records.
- `MIN()` and `MAX()` to identify minimum and maximum values.
- `DISTINCT` to identify unique years.
- `GROUP BY` to aggregate data by year.
- `SUM()` to calculate population totals.
- `AVG()` and weighted averages to investigate average age.
- `ORDER BY` and `LIMIT` to identify highest and lowest population years.

### 1.4 Key Observations

- The dataset covers 34 years, from 1992 to 2025.
- Each year is expected to contain 101 age-group records.
- Population totals can be calculated by combining the four demographic categories.
- Weighted average age provides a more meaningful population average than a simple average of age labels.

---

# 2. Data Quality Findings

**SQL file:** `02_data_quality.sql`

### 2.1 Data Quality Checks

Several checks were performed to evaluate the reliability and consistency of the dataset.

| Check                           | SQL technique                             | Expected result              |
| ------------------------------- | ----------------------------------------- | ---------------------------- |
| Missing values                  | `IS NULL`, `SUM()`                    | 0 missing values             |
| Duplicate year-age combinations | `GROUP BY`, `HAVING`                  | No duplicates                |
| Invalid age values              | `WHERE`                                 | No ages below 0 or above 100 |
| Negative population values      | `WHERE`, `OR`                         | No negative values           |
| Records per year                | `COUNT()`, `HAVING`                   | 101 records per year         |
| Age coverage                    | `MIN()`, `MAX()`, `COUNT(DISTINCT)` | Ages 0–100                  |
| Year coverage                   | `MIN()`, `MAX()`, `COUNT(DISTINCT)` | 1992–2025, 34 years         |

### 2.2 Missing Values

Checked all six columns for NULL values.

**SQL methods:** `COUNT(*)`, `SUM(column IS NULL)`

**Expected finding:** No missing values in the source dataset.

### 2.3 Duplicate Records

Checked whether any combination of `Jahr` and `Alter` appeared more than once.

**SQL methods:** `GROUP BY`, `COUNT(*)`, `HAVING`

**Expected finding:** Each year-age combination should be unique.

### 2.4 Invalid Age Values

Checked for ages outside the expected range of 0–100.

**SQL method:** `WHERE` with `OR`

**Expected finding:** No invalid age values.

### 2.5 Negative Population Values

Checked all four demographic population columns individually.

**SQL method:** `WHERE` with multiple `OR` conditions.

**Expected finding:** No negative population counts.

### 2.6 Records and Age Coverage

Checked whether each year contains 101 records and all 101 distinct age groups.

**SQL methods:** `COUNT(*)`, `COUNT(DISTINCT)`, `MIN()`, `MAX()`, `HAVING`

**Expected finding:** Every year should contain ages 0 through 100 exactly once.

---

# 3. Overall Conclusion

The dataset has a clear structure and can be investigated using SQL aggregation, filtering and validation techniques.

The exploration phase established the dataset's structure, time period and demographic categories. The data-quality phase established a set of validation checks to identify missing values, duplicate combinations, invalid ages and negative population counts.

No data-cleaning operations have been performed at this stage. The purpose was to investigate the data before making any modifications.

**Next step:** Perform demographic population analysis to identify population trends, changes across years and differences between demographic groups.

---

# 4. Project Progress

- [X] Dataset selected
- [X] Database and table created
- [X] Data exploration SQL drafted
- [X] Data quality SQL drafted
- [ ] Execute and verify all data-quality checks
- [ ] Record actual findings and query results
- [ ] Population trend analysis
- [ ] Demographic comparisons
- [ ] Final insights and visualizations
