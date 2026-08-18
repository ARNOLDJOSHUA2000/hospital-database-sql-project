-- Hospital Database SQL Project
-- Common Table Expressions (CTEs)

-- 1. Average medicine price
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM medicines
)
SELECT *
FROM average_price;

-- 2. Medicines priced above average
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM medicines
)
SELECT medicine_name, price
FROM medicines
WHERE price > (
    SELECT avg_price
    FROM average_price
);

-- 3. Appointment count per doctor
WITH doctor_appointments AS (
    SELECT
        doctor_id,
        COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
)
SELECT
    d.doctor_name,
    da.total_appointments
FROM doctors AS d
INNER JOIN doctor_appointments AS da
    ON d.doctor_id = da.doctor_id;

-- 4. Doctors with more than two appointments
WITH doctor_appointments AS (
    SELECT
        doctor_id,
        COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
)
SELECT
    d.doctor_name,
    da.total_appointments
FROM doctors AS d
INNER JOIN doctor_appointments AS da
    ON d.doctor_id = da.doctor_id
WHERE da.total_appointments > 2;

-- 5. Average number of appointments per doctor
WITH doctor_counts AS (
    SELECT
        d.doctor_id,
        d.doctor_name,
        COUNT(a.appointment_id) AS total_appointments
    FROM doctors AS d
    LEFT JOIN appointments AS a
        ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, d.doctor_name
)
SELECT AVG(total_appointments) AS average_appointments
FROM doctor_counts;
