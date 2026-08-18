# Hospital Database SQL Project — Interview Transcript

This document summarizes the SQL queries, concepts, corrections, and interview-ready explanations practiced in the Hospital Database project.

## 1. Doctor appointment counts
```sql
SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC;
```
**Explanation:** Join doctors to appointments by `doctor_id`, count appointments per doctor, group, then sort highest to lowest.

## 2. Doctors with at least 2 appointments
```sql
SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
LEFT JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
HAVING COUNT(a.appointment_id) >= 2
ORDER BY total_appointments DESC;
```
**Key:** `HAVING` filters aggregate results.

## 3. Patients with multiple appointments
```sql
SELECT p.patient_name, COUNT(a.appointment_id) AS total_appointments
FROM patients AS p
INNER JOIN appointments AS a ON p.patient_id = a.patient_id
GROUP BY p.patient_name
HAVING COUNT(a.appointment_id) > 1;
```

## 4. Patients by city
```sql
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;
```
**Interview:** `GROUP BY` groups rows with the same city so `COUNT()` can calculate patients per city.

## 5. LEFT JOIN — all patients and appointment counts
```sql
SELECT p.patient_name, COUNT(a.appointment_id) AS total_appointments
FROM patients AS p
LEFT JOIN appointments AS a ON p.patient_id = a.patient_id
GROUP BY p.patient_name;
```
**Why LEFT JOIN?** Every patient remains in the result, including patients with no appointments.

### Patients with zero appointments
```sql
SELECT p.patient_name, COUNT(a.appointment_id) AS total_appointments
FROM patients AS p
LEFT JOIN appointments AS a ON p.patient_id = a.patient_id
GROUP BY p.patient_name
HAVING COUNT(a.appointment_id) = 0;
```

## 6. Departments by appointment volume
```sql
SELECT dept.department_name, COUNT(a.appointment_id) AS total_appointments
FROM departments AS dept
INNER JOIN doctors AS d ON dept.department_id = d.department_id
INNER JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name;
```

### Highest appointment department
```sql
SELECT dept.department_name, COUNT(a.appointment_id) AS total_appointments
FROM departments AS dept
INNER JOIN doctors AS d ON dept.department_id = d.department_id
INNER JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name
ORDER BY total_appointments DESC
LIMIT 1;
```

## 7. Maximum medicine price — subquery
```sql
SELECT medicine_name, price
FROM medicines
WHERE price = (SELECT MAX(price) FROM medicines);
```
**Interview:** The inner query calculates the maximum price; the outer query finds medicine(s) matching it.

## 8. Patients with multiple appointments — IN subquery
```sql
SELECT patient_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    GROUP BY patient_id
    HAVING COUNT(*) > 1
);
```

## 9. EXISTS / NOT EXISTS
```sql
SELECT patient_name
FROM patients p
WHERE EXISTS (
    SELECT 1 FROM appointments a
    WHERE a.patient_id = p.patient_id
);
```
`EXISTS` returns patients for whom at least one matching appointment exists.

```sql
SELECT patient_name
FROM patients p
WHERE NOT EXISTS (
    SELECT 1 FROM appointments a
    WHERE a.patient_id = p.patient_id
);
```
`NOT EXISTS` returns patients with no matching appointment.

## 10. Maximum appointment count per doctor
```sql
SELECT MAX(total_appointments)
FROM (
    SELECT doctor_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
) AS doctor_counts;
```

# CTEs — Common Table Expressions

## 11. First CTE
```sql
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM medicines
)
SELECT * FROM average_price;
```
**Interview:** A CTE creates a temporary named result used by the main query and makes complex SQL easier to read.

## 12. Medicines above average price
```sql
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM medicines
)
SELECT medicine_name, price
FROM medicines
WHERE price > (SELECT avg_price FROM average_price);
```

## 13. Appointment count per doctor
```sql
WITH doctor_appointments AS (
    SELECT doctor_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
)
SELECT * FROM doctor_appointments;
```

## 14. CTE + JOIN
```sql
WITH doctor_appointments AS (
    SELECT doctor_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
)
SELECT d.doctor_name, da.total_appointments
FROM doctors AS d
INNER JOIN doctor_appointments AS da ON d.doctor_id = da.doctor_id;
```

## 15. CTE filtering
```sql
WITH doctor_appointments AS (
    SELECT doctor_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
)
SELECT *
FROM doctor_appointments
WHERE total_appointments > 2;
```

## 16. Average appointments per doctor
```sql
WITH doctor_counts AS (
    SELECT d.doctor_id, d.doctor_name,
           COUNT(a.appointment_id) AS total_appointments
    FROM doctors AS d
    LEFT JOIN appointments AS a ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, d.doctor_name
)
SELECT AVG(total_appointments) AS average_appointments
FROM doctor_counts;
```

# Window Functions

## 17. ROW_NUMBER
```sql
SELECT doctor_name, department_id,
       ROW_NUMBER() OVER (ORDER BY doctor_name) AS row_num
FROM doctors;
```

## 18. ROW_NUMBER with PARTITION BY
```sql
SELECT doctor_name, department_id,
       ROW_NUMBER() OVER (
           PARTITION BY department_id
           ORDER BY doctor_name
       ) AS row_num
FROM doctors;
```
**Important syntax:** `PARTITION BY`, not `PARTITION_BY`.

## 19. RANK and DENSE_RANK
```sql
SELECT doctor_name, doctor_id,
       RANK() OVER (ORDER BY doctor_id DESC) AS doctor_rank
FROM doctors;
```

```sql
SELECT doctor_name, doctor_id,
       DENSE_RANK() OVER (ORDER BY doctor_id DESC) AS doctor_rank
FROM doctors;
```

**Interview:** `ROW_NUMBER()` gives unique numbers; `RANK()` gives tied values the same rank with gaps; `DENSE_RANK()` gives tied values the same rank without gaps. The `ORDER BY` determines what is ranked.

## 20. COUNT OVER
```sql
SELECT appointment_id, patient_id, doctor_id,
       COUNT(*) OVER () AS total_appointments
FROM appointments;
```

## 21. Doctors per department
```sql
SELECT doctor_name, department_id,
       COUNT(*) OVER (PARTITION BY department_id) AS doctors_in_department
FROM doctors;
```

## 22. Average medicine price
```sql
SELECT medicine_name, price,
       AVG(price) OVER () AS average_price
FROM medicines;
```

## 23. Total medicine price
```sql
SELECT medicine_name, price,
       SUM(price) OVER () AS total_price
FROM medicines;
```

## 24. Running total
```sql
SELECT medicine_name, price,
       SUM(price) OVER (ORDER BY price) AS running_total
FROM medicines;
```

## 25. LAG / LEAD
```sql
SELECT medicine_name, price,
       LAG(price) OVER (ORDER BY price) AS previous_price
FROM medicines;
```

```sql
SELECT medicine_name, price,
       LEAD(price) OVER (ORDER BY price) AS next_price
FROM medicines;
```

## 26. Current vs previous price
```sql
SELECT medicine_name, price,
       price - LAG(price) OVER (ORDER BY price) AS price_difference
FROM medicines;
```

## 27. Medicine price ranking
```sql
SELECT medicine_name, price,
       DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
FROM medicines;
```

# CASE

## 28. Medicine price category
```sql
SELECT medicine_name, price,
       CASE
           WHEN price < 100 THEN 'Cheap'
           WHEN price < 300 THEN 'Moderate'
           ELSE 'Expensive'
       END AS price_category
FROM medicines;
```
**Interview:** `CASE` works like if/else-if/else and checks conditions from top to bottom.

## 29. Stock category
```sql
SELECT medicine_name, stock_quantity,
       CASE
           WHEN stock_quantity = 0 THEN 'No Stock'
           WHEN stock_quantity < 20 THEN 'Low Stock'
           ELSE 'Good Stock'
       END AS stock_status
FROM medicines;
```

## 30. Appointment status category
```sql
SELECT appointment_id, status,
       CASE
           WHEN status = 'Completed' THEN 'Finished'
           WHEN status = 'Scheduled' THEN 'Upcoming'
           WHEN status = 'Cancelled' THEN 'Cancelled'
           ELSE 'Other'
       END AS status_category
FROM appointments;
```

## 31. Conditional aggregation
```sql
SELECT
    COUNT(CASE WHEN stock_quantity < 20 THEN 1 END) AS low_stock_count,
    COUNT(CASE WHEN stock_quantity >= 20 THEN 1 END) AS good_stock_count
FROM medicines;
```

## 32. Average price by stock category
```sql
SELECT
    CASE WHEN stock_quantity < 20 THEN 'Low Stock' ELSE 'Good Stock' END AS stock_category,
    AVG(price) AS average_price
FROM medicines
GROUP BY CASE WHEN stock_quantity < 20 THEN 'Low Stock' ELSE 'Good Stock' END;
```

# Date Functions

## 33. Birth year
```sql
SELECT patient_name, date_of_birth,
       EXTRACT(YEAR FROM date_of_birth) AS birth_year
FROM patients;
```

## 34. Patient age
```sql
SELECT patient_name, date_of_birth,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age
FROM patients;
```

## 35. Patients born after 2000
```sql
SELECT patient_name, date_of_birth
FROM patients
WHERE date_of_birth > '2000-01-01';
```

## 36. Appointment date range
```sql
SELECT appointment_id, patient_id, doctor_id, appointment_date
FROM appointments
WHERE appointment_date BETWEEN '2026-01-01' AND '2026-03-31';
```

## 37. Appointment month
```sql
SELECT appointment_id, appointment_date,
       EXTRACT(MONTH FROM appointment_date) AS appointment_month
FROM appointments;
```

## 38. Appointments by month
```sql
SELECT EXTRACT(MONTH FROM appointment_date) AS appointment_month,
       COUNT(*) AS total_appointments
FROM appointments
GROUP BY EXTRACT(MONTH FROM appointment_date)
ORDER BY appointment_month;
```

## 39. Last 30 days
```sql
SELECT appointment_id, patient_id, doctor_id, appointment_date
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '30 days';
```

## 40. Year and month
```sql
SELECT appointment_id, appointment_date,
       EXTRACT(YEAR FROM appointment_date) AS appointment_year,
       EXTRACT(MONTH FROM appointment_date) AS appointment_month
FROM appointments;
```

## 41. Appointments by year and month
```sql
SELECT EXTRACT(YEAR FROM appointment_date) AS appointment_year,
       EXTRACT(MONTH FROM appointment_date) AS appointment_month,
       COUNT(*) AS total_appointments
FROM appointments
GROUP BY EXTRACT(YEAR FROM appointment_date), EXTRACT(MONTH FROM appointment_date)
ORDER BY appointment_year, appointment_month;
```

# String Functions

## 42. UPPER
```sql
SELECT patient_name, UPPER(patient_name) AS uppercase_name
FROM patients;
```

## 43. LOWER
```sql
SELECT doctor_name, LOWER(doctor_name) AS lowercase_name
FROM doctors;
```

## 44. LENGTH
```sql
SELECT patient_name, LENGTH(patient_name) AS name_length
FROM patients;
```

## 45. TRIM
```sql
SELECT patient_name, TRIM(patient_name) AS cleaned_name
FROM patients;
```

## 46. REPLACE
```sql
SELECT doctor_name,
       REPLACE(doctor_name, 'Dr.', 'Doctor') AS full_title
FROM doctors;
```

# Business KPIs

## 47. Highest appointment doctor
```sql
SELECT d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC
LIMIT 1;
```

## 48. Completed appointment percentage
```sql
SELECT
    COUNT(CASE WHEN status = 'Completed' THEN 1 END) * 100.0 / COUNT(*)
        AS completed_percentage
FROM appointments;
```

## 49. Appointment status percentages
```sql
SELECT status,
       COUNT(*) AS total_appointments,
       COUNT(*) * 100.0 / COUNT(*) OVER () AS percentage
FROM appointments
GROUP BY status;
```

## 50. Medicine price summary
```sql
SELECT AVG(price) AS average_price,
       MAX(price) AS maximum_price
FROM medicines;
```

## 51. Final doctor performance query
```sql
SELECT d.doctor_name,
       dept.department_name,
       COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN departments AS dept ON d.department_id = dept.department_id
INNER JOIN appointments AS a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name, dept.department_name
HAVING COUNT(a.appointment_id) >= 2
ORDER BY total_appointments DESC;
```

# Interview Quick Answers

### WHERE vs HAVING
`WHERE` filters individual rows before grouping; `HAVING` filters groups after aggregation.

### GROUP BY
Groups rows with the same value so aggregate functions can calculate results per group.

### LEFT JOIN
Keeps every row from the left table, including rows with no matching right-side record.

### PARTITION BY
Divides rows into groups for a window calculation while keeping individual rows in the result.

### CTE
Common Table Expression: a temporary named result used within a query to make complex SQL easier to read and organize.

### EXISTS
Checks whether at least one matching row exists.

### COUNT(*) vs COUNT(column)
`COUNT(*)` counts rows; `COUNT(column)` counts non-NULL values in that column.

### Window functions
Perform calculations across a window/set of rows without collapsing the individual rows like GROUP BY does.

# Common mistakes corrected

1. `ON d.doctor_id = a.appointment_id` → should be `a.doctor_id`.
2. `PARTITION_BY` → should be `PARTITION BY`.
3. Missing comma between SELECT expressions.
4. Aggregate filtering belongs in `HAVING`, not `WHERE`.
5. In `FROM patients p LEFT JOIN appointments a`, `patients` is the left table.
6. For LEFT JOIN counts, `COUNT(a.appointment_id)` is preferred when unmatched rows should produce zero.
7. CTE means **Common Table Expression**.

# Final checklist

- SELECT / WHERE / ORDER BY
- Aggregate functions
- GROUP BY / HAVING
- INNER JOIN / LEFT JOIN
- Subqueries / IN / EXISTS / NOT EXISTS
- CTEs
- CASE
- ROW_NUMBER / RANK / DENSE_RANK
- PARTITION BY
- LAG / LEAD / running totals
- Date functions
- String functions
- Conditional aggregation
- Business KPIs
- Interview explanations

## Final learning goal

For every query, be able to explain:

**What does it do? → Why was this clause/function used? → What result does it produce? → What alternative could be used?**
