-- Hospital Database SQL Project
-- Business KPI queries

-- 1. Doctor with the most appointments
SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors AS d
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name
ORDER BY total_appointments DESC
LIMIT 1;

-- 2. Department with the most appointments
SELECT
    dept.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM departments AS dept
INNER JOIN doctors AS d
    ON dept.department_id = d.department_id
INNER JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name
ORDER BY total_appointments DESC
LIMIT 1;

-- 3. Completed appointment percentage
SELECT
    COUNT(
        CASE
            WHEN status = 'Completed' THEN 1
        END
    ) * 100.0 / COUNT(*) AS completed_percentage
FROM appointments;

-- 4. Appointment distribution by status
SELECT
    status,
    COUNT(*) AS total_appointments,
    COUNT(*) * 100.0 / COUNT(*) OVER () AS percentage
FROM appointments
GROUP BY status;

-- 5. Medicine pricing summary
SELECT
    AVG(price) AS average_price,
    MAX(price) AS maximum_price
FROM medicines;

-- 6. Doctors with at least two appointments, including department
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
