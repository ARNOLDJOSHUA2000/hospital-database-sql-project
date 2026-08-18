-- Hospital Database SQL Project
-- 07: CASE and Conditional Aggregation

-- Categorize medicines by price
SELECT
    medicine_name,
    price,
    CASE
        WHEN price < 100 THEN 'Cheap'
        WHEN price < 300 THEN 'Moderate'
        ELSE 'Expensive'
    END AS price_category
FROM medicines;

-- Categorize medicine stock
SELECT
    medicine_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'No Stock'
        WHEN stock_quantity < 20 THEN 'Low Stock'
        ELSE 'Good Stock'
    END AS stock_status
FROM medicines;

-- Categorize appointment statuses
SELECT
    appointment_id,
    status,
    CASE
        WHEN status = 'Completed' THEN 'Finished'
        WHEN status = 'Scheduled' THEN 'Upcoming'
        WHEN status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Other'
    END AS status_category
FROM appointments;

-- Count medicines by stock category
SELECT
    COUNT(CASE WHEN stock_quantity < 20 THEN 1 END) AS low_stock_count,
    COUNT(CASE WHEN stock_quantity >= 20 THEN 1 END) AS good_stock_count
FROM medicines;

-- Completed vs non-completed appointments
SELECT
    COUNT(CASE WHEN status = 'Completed' THEN 1 END) AS completed_appointments,
    COUNT(CASE WHEN status <> 'Completed' THEN 1 END) AS non_completed_appointments
FROM appointments;

-- Average price by stock category
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
