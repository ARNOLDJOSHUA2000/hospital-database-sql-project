-- Hospital Database SQL Project
-- Sample data for PostgreSQL
-- Run schema.sql before running this file.

INSERT INTO departments (department_name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics'),
('Dermatology'),
('General Medicine');

INSERT INTO patients (patient_name, date_of_birth, city) VALUES
('Aarav Sharma', '1990-04-15', 'Mumbai'),
('Priya Patel', '1985-09-22', 'Pune'),
('Rahul Mehta', '2002-01-10', 'Mumbai'),
('Sneha Iyer', '1998-07-05', 'Nashik'),
('Vikram Singh', '1978-11-30', 'Thane'),
('Ananya Rao', '2005-03-18', 'Mumbai'),
('Rohan Joshi', '1992-12-01', 'Pune'),
('Meera Nair', '1989-06-25', 'Navi Mumbai'),
('Karan Shah', '2001-10-12', 'Mumbai'),
('Neha Kulkarni', '1995-02-28', 'Pune'),
('Arjun Desai', '1975-08-09', 'Thane'),
('Kavya Menon', '2003-05-21', 'Nashik'),
('Aditya Kapoor', '1982-03-14', 'Mumbai'),
('Isha Verma', '1999-11-07', 'Pune'),
('Dev Malhotra', '1968-01-19', 'Thane'),
('Tara Fernandes', '2006-09-03', 'Mumbai');

INSERT INTO doctors (doctor_name, department_id) VALUES
('Dr. Amit Shah', 1),
('Dr. Neha Desai', 1),
('Dr. Rahul Mehta', 2),
('Dr. Priya Nair', 2),
('Dr. Vikram Joshi', 3),
('Dr. Anjali Rao', 3),
('Dr. Sameer Patel', 4),
('Dr. Kavita Iyer', 4),
('Dr. Rohan Kapoor', 5),
('Dr. Sneha Menon', 5),
('Dr. Arjun Singh', 6),
('Dr. Meera Shah', 6);

INSERT INTO medicines (medicine_name, price, stock_quantity) VALUES
('Paracetamol', 45.00, 120),
('Amoxicillin', 180.00, 75),
('Azithromycin', 250.00, 42),
('Ibuprofen', 85.00, 15),
('Cetirizine', 60.00, 8),
('Omeprazole', 140.00, 55),
('Metformin', 125.00, 65),
('Atorvastatin', 320.00, 12),
('Amlodipine', 210.00, 30),
('Pantoprazole', 175.00, 18),
('Losartan', 290.00, 24),
('Insulin Glargine', 850.00, 6),
('Montelukast', 275.00, 38),
('Diclofenac', 95.00, 0),
('Calcium Carbonate', 70.00, 90),
('Vitamin D3', 150.00, 20),
('Cefixime', 340.00, 9),
('Levothyroxine', 110.00, 50);

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2026-01-05', 'Completed'),
(2, 1, '2026-01-07', 'Completed'),
(3, 2, '2026-01-10', 'Scheduled'),
(4, 3, '2026-01-12', 'Completed'),
(5, 3, '2026-01-15', 'Cancelled'),
(6, 4, '2026-01-18', 'Completed'),
(7, 5, '2026-01-20', 'Scheduled'),
(8, 5, '2026-01-22', 'Completed'),
(9, 6, '2026-01-25', 'Completed'),
(10, 7, '2026-01-28', 'Scheduled'),
(11, 7, '2026-02-02', 'Completed'),
(12, 8, '2026-02-04', 'Cancelled'),
(13, 9, '2026-02-07', 'Completed'),
(14, 9, '2026-02-10', 'Completed'),
(15, 10, '2026-02-12', 'Scheduled'),
(1, 11, '2026-02-15', 'Completed'),
(2, 11, '2026-02-18', 'Completed'),
(3, 12, '2026-02-20', 'Scheduled'),
(4, 1, '2026-02-23', 'Completed'),
(5, 1, '2026-02-25', 'Scheduled'),
(6, 2, '2026-03-01', 'Completed'),
(7, 3, '2026-03-03', 'Cancelled'),
(8, 3, '2026-03-05', 'Completed'),
(9, 4, '2026-03-08', 'Scheduled'),
(10, 5, '2026-03-10', 'Completed'),
(11, 5, '2026-03-12', 'Completed'),
(12, 6, '2026-03-15', 'Scheduled'),
(13, 7, '2026-03-18', 'Completed'),
(14, 8, '2026-03-20', 'Cancelled'),
(15, 9, '2026-03-22', 'Completed'),
(1, 1, '2026-03-25', 'Completed'),
(2, 1, '2026-03-27', 'Scheduled'),
(3, 2, '2026-03-29', 'Completed'),
(4, 3, '2026-04-02', 'Scheduled'),
(5, 3, '2026-04-04', 'Completed'),
(6, 4, '2026-04-06', 'Cancelled'),
(7, 5, '2026-04-08', 'Completed'),
(8, 5, '2026-04-10', 'Scheduled'),
(9, 6, '2026-04-12', 'Completed'),
(10, 7, '2026-04-15', 'Scheduled'),
(11, 7, '2026-04-17', 'Completed'),
(12, 8, '2026-04-20', 'Completed'),
(13, 9, '2026-04-22', 'Scheduled'),
(14, 9, '2026-04-24', 'Completed'),
(15, 10, '2026-04-26', 'Cancelled'),
(16, 11, '2026-04-28', 'Scheduled'),
(1, 12, '2026-05-01', 'Completed'),
(2, 11, '2026-05-03', 'Completed'),
(3, 10, '2026-05-05', 'Scheduled'),
(4, 9, '2026-05-07', 'Completed'),
(5, 8, '2026-05-10', 'Scheduled'),
(6, 7, '2026-05-12', 'Completed'),
(7, 6, '2026-05-14', 'Cancelled'),
(8, 5, '2026-05-16', 'Completed'),
(9, 4, '2026-05-18', 'Scheduled'),
(10, 3, '2026-05-20', 'Completed'),
(11, 2, '2026-05-22', 'Completed'),
(12, 1, '2026-05-24', 'Scheduled'),
(13, 1, '2026-05-26', 'Completed'),
(14, 2, '2026-05-28', 'Completed'),
(15, 3, '2026-05-30', 'Cancelled');

-- The dataset intentionally includes:
-- * patients with multiple appointments
-- * a patient with no appointment (Tara Fernandes)
-- * doctors with different appointment volumes
-- * completed, scheduled, and cancelled appointments
-- * medicines with zero, low, normal, and high stock
-- * a wide range of medicine prices for ranking and aggregation practice
