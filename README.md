# 🏥 Hospital Database SQL Project

A PostgreSQL-based SQL portfolio project focused on analyzing hospital operations, including patients, doctors, departments, appointments, and medicines.

The project demonstrates practical SQL skills through progressively more advanced queries, from filtering and aggregation to joins, subqueries, CTEs, window functions, date/string functions, and business KPIs.

## 📌 Project Objective

The objective is to use SQL to answer realistic hospital-management questions and turn relational data into useful operational insights.

Examples include:

- Which doctors handle the most appointments?
- Which departments have the highest appointment volume?
- Which patients have multiple or no appointments?
- What percentage of appointments are completed, scheduled, or cancelled?
- Which medicines are cheap, moderate, or expensive?
- Which medicines have low stock?
- What is the average and maximum medicine price?
- How can appointment activity be analyzed by month and year?

## 🗂️ Database Entities

| Table | Purpose |
|---|---|
| `patients` | Patient information such as name, date of birth, and city |
| `doctors` | Doctor information and department relationships |
| `departments` | Hospital department information |
| `appointments` | Patient-doctor appointment records and status |
| `medicines` | Medicine names, prices, and stock quantities |

### Main relationships

```text
patients ───────< appointments >─────── doctors
                                      │
                                      ▼
                                 departments

medicines
```

## 🛠️ Technology

- **Database:** PostgreSQL
- **Language:** SQL
- **Tools:** PostgreSQL / pgAdmin
- **Version control:** Git & GitHub

## 📚 SQL Concepts Demonstrated

### Fundamentals

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `DISTINCT`

### Aggregation

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()` / `MAX()`
- `GROUP BY`
- `HAVING`

### Joins

- `INNER JOIN`
- `LEFT JOIN`
- Multi-table joins

### Advanced SQL

- Subqueries
- `IN`
- `EXISTS`
- `NOT EXISTS`
- Common Table Expressions (`WITH`)
- `CASE`
- Conditional aggregation

### Window Functions

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `PARTITION BY`
- `LAG()`
- `LEAD()`
- Running totals
- Window aggregates such as `COUNT(*) OVER()` and `AVG() OVER()`

### Date & String Functions

- `EXTRACT()`
- `AGE()`
- `CURRENT_DATE`
- `INTERVAL`
- `UPPER()`
- `LOWER()`
- `LENGTH()`
- `TRIM()`
- `REPLACE()`

## 📁 Project Structure

```text
hospital-database-sql-project/
│
├── README.md
│
├── sql/
│   ├── schema.sql
│   ├── sample_data.sql
│   ├── 01_basics_and_filtering.sql
│   ├── 02_aggregation_groupby_having.sql
│   ├── 03_joins.sql
│   ├── 04_subqueries_and_exists.sql
│   ├── 05_ctes.sql
│   ├── 06_window_functions.sql
│   ├── 07_case_and_conditional_aggregation.sql
│   ├── 08_date_functions.sql
│   ├── 09_string_functions.sql
│   └── 10_business_kpis.sql
│
└── docs/
    └── hospital_sql_project_interview_transcript.md
```

## 🚀 Quick Start

### 1. Create a PostgreSQL database

Create a database in PostgreSQL, for example:

```sql
CREATE DATABASE hospital_db;
```

Connect to `hospital_db` before continuing.

### 2. Create the schema

Run:

```text
sql/schema.sql
```

This creates the five tables, relationships, constraints, and indexes.

### 3. Load the sample data

Run:

```text
sql/sample_data.sql
```

The sample dataset is synthetic and contains patients, doctors, departments, appointments, and medicines designed for SQL practice.

### 4. Run the analysis

Run the numbered files in order:

```text
01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 09 → 10
```

You can execute them in pgAdmin Query Tool or another PostgreSQL client.

## 🔎 Example Business Queries

### 1. Doctor with the highest appointment count

```sql
SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC
LIMIT 1;
```

### 2. Appointment completion percentage

```sql
SELECT
    COUNT(CASE WHEN status = 'Completed' THEN 1 END)
        * 100.0 / COUNT(*) AS completed_percentage
FROM appointments;
```

### 3. Appointment percentage by status

```sql
SELECT
    status,
    COUNT(*) AS total_appointments,
    COUNT(*) * 100.0 / COUNT(*) OVER () AS percentage
FROM appointments
GROUP BY status;
```

### 4. Doctors with at least two appointments

```sql
SELECT
    d.doctor_name,
    dept.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN departments AS dept
    ON d.department_id = dept.department_id
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name, dept.department_name
HAVING COUNT(a.appointment_id) >= 2
ORDER BY total_appointments DESC;
```

## 💡 Key SQL Lessons

### `WHERE` vs `HAVING`

`WHERE` filters individual rows before grouping. `HAVING` filters groups after aggregation.

### `COUNT(*)` vs `COUNT(column)`

`COUNT(*)` counts rows, while `COUNT(column)` counts non-NULL values. This distinction is particularly important when using `LEFT JOIN`.

### `GROUP BY` vs `PARTITION BY`

`GROUP BY` collapses rows into groups. `PARTITION BY` divides rows into groups for a window calculation while keeping the individual rows visible.

### `RANK()` vs `DENSE_RANK()`

`RANK()` leaves gaps after ties; `DENSE_RANK()` does not.

### CTEs

CTEs make complex queries easier to read by breaking them into named logical steps.

## 🎯 Portfolio Skills Demonstrated

This project demonstrates the ability to:

- Understand relational database structure
- Identify and use primary/foreign-key relationships
- Join multiple tables correctly
- Aggregate and summarize business data
- Filter grouped results using `HAVING`
- Build reusable CTE-based queries
- Use window functions for analytical calculations
- Create business KPIs from raw records
- Explain SQL decisions in interview-style discussions

## 🧪 Dataset Notes

The repository uses **synthetic sample data** for learning and portfolio purposes. It does not contain real patient or medical records.

The sample data intentionally includes useful edge cases such as:

- Patients with multiple appointments
- A patient with no appointments
- Doctors with different appointment volumes
- Completed, scheduled, and cancelled appointments
- Medicines with zero, low, normal, and high stock
- A broad range of medicine prices

## 📈 Future Improvements

- Add an ER diagram
- Add data-quality validation queries
- Add PostgreSQL views
- Add stored procedures/functions where appropriate
- Add a Power BI or Tableau dashboard
- Add query-result screenshots
- Add performance analysis with `EXPLAIN ANALYZE`
- Add automated SQL checks in GitHub Actions

## 👤 Author

**Arnold Joshua**

GitHub: [@ARNOLDJOSHUA2000](https://github.com/ARNOLDJOSHUA2000)

## 📄 Documentation

See [`docs/hospital_sql_project_interview_transcript.md`](docs/hospital_sql_project_interview_transcript.md) for the complete SQL practice and interview transcript.

---

⭐ This project is part of a hands-on SQL learning portfolio and demonstrates practical PostgreSQL querying, relational thinking, and analytical problem solving.