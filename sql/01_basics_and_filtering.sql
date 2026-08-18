-- Hospital Database SQL Project
-- 01: Basics and Filtering

-- View all patients
SELECT *
FROM patients;

-- Select specific patient columns
SELECT
    patient_id,
    patient_name,
    city
FROM patients;

-- Patients from a specific city
SELECT
    patient_name,
    city
FROM patients
WHERE city = 'Mumbai';

-- Patients born after 2000-01-01
SELECT
    patient_name,
    date_of_birth
FROM patients
WHERE date_of_birth > '2000-01-01';

-- Appointments within a date range
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    status
FROM appointments
WHERE appointment_date BETWEEN '2026-01-01' AND '2026-03-31';

-- Completed appointments
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date
FROM appointments
WHERE status = 'Completed';

-- Medicines priced below 300
SELECT
    medicine_name,
    price
FROM medicines
WHERE price < 300
ORDER BY price ASC;

-- Unique appointment statuses
SELECT DISTINCT status
FROM appointments
ORDER BY status;

-- Most expensive medicines first
SELECT
    medicine_name,
    price
FROM medicines
ORDER BY price DESC
LIMIT 5;
