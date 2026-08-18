-- Hospital Database SQL Project
-- 08: Date Functions

-- Extract birth year
SELECT
    patient_name,
    date_of_birth,
    EXTRACT(YEAR FROM date_of_birth) AS birth_year
FROM patients;

-- Calculate patient age
SELECT
    patient_name,
    date_of_birth,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age
FROM patients;

-- Patients born after January 1, 2000
SELECT
    patient_name,
    date_of_birth
FROM patients
WHERE date_of_birth > '2000-01-01';

-- Appointments in Q1 2026
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date
FROM appointments
WHERE appointment_date BETWEEN '2026-01-01' AND '2026-03-31';

-- Extract appointment month
SELECT
    appointment_id,
    appointment_date,
    EXTRACT(MONTH FROM appointment_date) AS appointment_month
FROM appointments;

-- Appointments by month
SELECT
    EXTRACT(MONTH FROM appointment_date) AS appointment_month,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY EXTRACT(MONTH FROM appointment_date)
ORDER BY appointment_month;

-- Appointments from the last 30 days relative to today
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date
FROM appointments
WHERE appointment_date >= CURRENT_DATE - INTERVAL '30 days';

-- Appointments by year and month
SELECT
    EXTRACT(YEAR FROM appointment_date) AS appointment_year,
    EXTRACT(MONTH FROM appointment_date) AS appointment_month,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY
    EXTRACT(YEAR FROM appointment_date),
    EXTRACT(MONTH FROM appointment_date)
ORDER BY
    appointment_year,
    appointment_month;
