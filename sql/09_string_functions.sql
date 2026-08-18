-- Hospital Database SQL Project
-- 09: String Functions

-- Convert patient names to uppercase
SELECT
    patient_name,
    UPPER(patient_name) AS uppercase_name
FROM patients;

-- Convert doctor names to lowercase
SELECT
    doctor_name,
    LOWER(doctor_name) AS lowercase_name
FROM doctors;

-- Calculate patient name length
SELECT
    patient_name,
    LENGTH(patient_name) AS name_length
FROM patients;

-- Remove leading and trailing whitespace
SELECT
    patient_name,
    TRIM(patient_name) AS cleaned_name
FROM patients;

-- Replace the Dr. title
SELECT
    doctor_name,
    REPLACE(doctor_name, 'Dr.', 'Doctor') AS full_title
FROM doctors;

-- Find patients whose names contain 'a'
SELECT
    patient_name
FROM patients
WHERE LOWER(patient_name) LIKE '%a%'
ORDER BY patient_name;

-- Create a simple display label
SELECT
    UPPER(patient_name) || ' - ' || city AS patient_label
FROM patients;
