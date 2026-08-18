-- Hospital Database SQL Project
-- JOIN queries

-- 1. Appointment count per doctor
SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC;

-- 2. All patients including patients with no appointments
SELECT
    p.patient_name,
    COUNT(a.appointment_id) AS total_appointments
FROM patients AS p
LEFT JOIN appointments AS a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_name;

-- 3. Appointment count per department
SELECT
    dept.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM departments AS dept
INNER JOIN doctors AS d
    ON dept.department_id = d.department_id
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name;

-- 4. Doctor performance across three tables
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
