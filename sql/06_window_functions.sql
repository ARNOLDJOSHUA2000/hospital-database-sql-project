-- Hospital Database SQL Project
-- Window functions

-- Total appointment count while preserving individual appointment rows
SELECT
    appointment_id,
    patient_id,
    doctor_id,
    COUNT(*) OVER () AS total_appointments
FROM appointments;

-- Number of doctors in each department
SELECT
    doctor_name,
    department_id,
    COUNT(*) OVER (
        PARTITION BY department_id
    ) AS doctors_in_department
FROM doctors;

-- Average medicine price while preserving each medicine row
SELECT
    medicine_name,
    price,
    AVG(price) OVER () AS average_price
FROM medicines;

-- Running total of medicine prices
SELECT
    medicine_name,
    price,
    SUM(price) OVER (
        ORDER BY price
    ) AS running_total
FROM medicines;

-- Previous medicine price
SELECT
    medicine_name,
    price,
    LAG(price) OVER (
        ORDER BY price
    ) AS previous_price
FROM medicines;

-- Next medicine price
SELECT
    medicine_name,
    price,
    LEAD(price) OVER (
        ORDER BY price
    ) AS next_price
FROM medicines;

-- Difference from previous price
SELECT
    medicine_name,
    price,
    price - LAG(price) OVER (
        ORDER BY price
    ) AS price_difference
FROM medicines;

-- Dense ranking by medicine price
SELECT
    medicine_name,
    price,
    DENSE_RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM medicines;
