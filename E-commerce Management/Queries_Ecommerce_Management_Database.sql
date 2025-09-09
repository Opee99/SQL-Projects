USE Ecommerce_Management;

-- =================================
-- 1. Basic Queries
-- =================================

-- 1.1 Select All Data from a Table
SELECT * FROM users;

-- 1.2 Select Specific Columns
SELECT full_name, email FROM users;

-- 1.3 Filtering Data with WHERE
SELECT * FROM users WHERE country_code = 880;

-- 1.4 Sorting Data with ORDER BY
SELECT * FROM products ORDER BY price DESC;

-- 1.5 Limiting the Number of Results
SELECT * FROM orders LIMIT 5;

-- =================================
-- 2. Intermediate Queries
-- =================================

-- 2.1 Using JOIN to Combine Data from Multiple Tables
SELECT users.full_name, orders.status
FROM users
JOIN orders ON users.id = orders.user_id;

-- 2.2 INNER JOIN with Multiple Tables
SELECT users.full_name, products.name, order_items.quantity
FROM order_items
JOIN orders ON order_items.order_id = orders.id
JOIN users ON orders.user_id = users.id
JOIN products ON order_items.product_id = products.id;

-- 2.3 Using GROUP BY with Aggregate Functions
SELECT country_code, COUNT(*) AS total_users
FROM users
GROUP BY country_code;

-- 2.4 Using HAVING to Filter Grouped Data
SELECT country_code, COUNT(*) AS total_users
FROM users
GROUP BY country_code
HAVING COUNT(*) > 1;

-- =================================
-- 3. Advanced Queries
-- =================================

-- 3.1 LEFT JOIN to Include Unmatched Rows
SELECT users.full_name, products.name
FROM users
LEFT JOIN orders ON users.id = orders.user_id
LEFT JOIN order_items ON orders.id = order_items.order_id
LEFT JOIN products ON order_items.product_id = products.id;

-- 3.2 Using SUBQUERY to Retrieve Data
SELECT full_name, email
FROM users
WHERE id IN (SELECT user_id FROM orders WHERE status = 'Completed');

-- 3.3 EXISTS to Check if Subquery Returns Data
SELECT full_name
FROM users
WHERE EXISTS (SELECT 1 FROM orders WHERE orders.user_id = users.id);

-- 3.4 UNION to Combine Results from Multiple Queries
SELECT full_name, email FROM users WHERE country_code = 880
UNION
SELECT full_name, email FROM users WHERE country_code = 101;

-- 3.5 CASE to Add Conditional Logic
SELECT full_name, 
       CASE 
           WHEN country_code = 880 THEN 'Bangladesh'
           WHEN country_code = 101 THEN 'USA'
           ELSE 'Other'
       END AS country_name
FROM users;

-- =================================
-- 4. Complex Queries
-- =================================

-- 4.1 CROSS JOIN to Get Every Combination of Two Tables
SELECT users.full_name, products.name
FROM users
CROSS JOIN products;

-- 4.2 UPDATE to Modify Data in a Table
UPDATE products
SET status = 'Out of Stock'
WHERE price > 1000;

-- 4.3 DELETE to Remove Data from a Table
DELETE FROM products
WHERE status = 'Out of Stock';

-- 4.4 Using DISTINCT to Get Unique Values
SELECT DISTINCT country_code
FROM users;

-- 4.5 Using LIMIT with OFFSET for Pagination
SELECT * FROM orders
ORDER BY created_at
LIMIT 5 OFFSET 5;

-- =====================================
-- 5. Optimization and Advanced Features
-- =====================================

-- 5.1 INDEX for Improving Query Performance
CREATE INDEX idx_users_email ON users(email);

-- 5.2 TRANSACTION for Ensuring Data Consistency
START TRANSACTION;

UPDATE products SET status = 'Out of Stock' WHERE id = 5;
UPDATE products SET status = 'Available' WHERE id = 6;

COMMIT;

-- =================================
-- 6. Data Integrity and Constraints
-- =================================

-- 6.1 NOT NULL Constraint
CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at TIMESTAMP
);

-- 6.2 FOREIGN KEY Constraint
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);




