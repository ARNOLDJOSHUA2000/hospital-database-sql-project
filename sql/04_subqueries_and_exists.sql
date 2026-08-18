-- Hospital Database SQL Project
-- 04: Subqueries, IN, EXISTS and NOT EXISTS

-- Medicines above the average price
SELECT
    medicine_name,
    price
FROM medicines
WHERE price > (
    SELECT AVG(price)
    FROM medicines
)
ORDER BY price DESC;

-- Most expensive medicine(s)
SELECT
    medicine_name,
    price
FROM medicines
WHERE price = (
    SELECT MAX(price)
    FROM medicines
);

-- Patients with multiple appointments
SELECT
    patient_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM appointments
    GROUP BY patient_id
    HAVING COUNT(*) > 1
);

-- Doctors with at least two appointments
SELECT
    doctor_name
FROM doctors
WHERE doctor_id IN (
    SELECT doctor_id
    FROM appointments
    GROUP BY doctor_id
    HAVING COUNT(*) >= 2
);

-- Patients who have at least one appointment
SELECT
    patient_name
FROM patients AS p
WHERE EXISTS (
    SELECT 1
    FROM appointments AS a
    WHERE a.patient_id = p.patient_id
);

-- Patients who have no appointments
SELECT
    patient_name
FROM patients AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM appointments AS a
    WHERE a.patient_id = p.patient_id
);

-- Maximum appointment count held by any doctor
SELECT MAX(total_appointments) AS max_doctor_appointments
FROM (
    SELECT
        doctor_id,
        COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY doctor_id
) AS doctor_counts;
