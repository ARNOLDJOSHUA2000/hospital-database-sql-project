-- Hospital Database SQL Project
-- 02: Aggregation, GROUP BY and HAVING

-- Count total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- Count total doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

-- Patients by city
SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

-- Doctors by department
SELECT
    department_id,
    COUNT(*) AS doctors_in_department
FROM doctors
GROUP BY department_id
ORDER BY doctors_in_department DESC;

-- Medicine price summary
SELECT
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    SUM(price) AS total_price
FROM medicines;

-- Appointments by status
SELECT
    status,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY status
ORDER BY total_appointments DESC;

-- Patients with more than one appointment
SELECT
    patient_id,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY patient_id
HAVING COUNT(*) > 1
ORDER BY total_appointments DESC;

-- Doctors with at least two appointments
SELECT
    doctor_id,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
HAVING COUNT(*) >= 2
ORDER BY total_appointments DESC;

-- Average medicine price by stock category
SELECT
    CASE
        WHEN stock_quantity < 20 THEN 'Low Stock'
        ELSE 'Good Stock'
    END AS stock_category,
    AVG(price) AS average_price
FROM medicines
GROUP BY
    CASE
        WHEN stock_quantity < 20 THEN 'Low Stock'
        ELSE 'Good Stock'
    END;
