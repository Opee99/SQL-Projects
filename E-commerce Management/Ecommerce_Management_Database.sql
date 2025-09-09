-- Create Database
CREATE DATABASE Ecommerce_Management;
USE Ecommerce_Management;

-- Countries Table
CREATE TABLE countries (
    code INT PRIMARY KEY,               -- Country unique code (PK)
    name VARCHAR(50) NOT NULL,          -- Country name
    continent_name VARCHAR(50) NOT NULL -- Continent name
);

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- User ID (PK)
    full_name VARCHAR(50) NOT NULL,     -- Full name
    email VARCHAR(50) UNIQUE,           -- Email must be unique
    gender VARCHAR(10),                 -- Gender
    date_of_birth DATE,                 -- DOB
    country_code INT,                   -- FK to countries
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_users_country FOREIGN KEY (country_code)
        REFERENCES countries(code)
);

-- Merchants Table
CREATE TABLE merchants (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Merchant ID (PK)
    merchant_name VARCHAR(50) NOT NULL,  -- Merchant name
    admin_id INT,                        -- Linked user as admin
    country_code INT,                    -- FK to countries
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (admin_id) REFERENCES users(id),
    FOREIGN KEY (country_code) REFERENCES countries(code)
);

-- Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Product ID (PK)
    merchant_id INT,                     -- FK to merchants
    name VARCHAR(100) NOT NULL,          -- Product name
    price DECIMAL(10,2),                 -- Product price
    status VARCHAR(20),                  -- Product availability
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (merchant_id) REFERENCES merchants(id)
);

-- Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Order ID (PK)
    user_id INT,                         -- FK to users
    status VARCHAR(30),                  -- Order status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_id INT,                        -- FK to orders
    product_id INT,                      -- FK to products
    quantity INT,                        -- How many items
    
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Inserting 15 sample countries
INSERT INTO countries (code, name, continent_name) VALUES
(101, 'United States', 'North America'),
(205, 'Canada', 'North America'),
(317, 'Mexico', 'North America'),
(432, 'Brazil', 'South America'),
(609, 'United Kingdom', 'Europe'),
(712, 'Germany', 'Europe'),
(356, 'China', 'Asia'),
(498, 'India', 'Asia'),
(629, 'Japan', 'Asia'),
(745, 'South Korea', 'Asia'),
(810, 'Australia', 'Oceania'),
(880, 'Bangladesh', 'Asia'),
(1001, 'France', 'Europe'),
(1501, 'Italy', 'Europe'),
(1901, 'Russia', 'Europe');

-- Inserting 15 sample users
INSERT INTO users (full_name, email, gender, date_of_birth, country_code) VALUES
('John Doe', 'john.doe@example.com', 'Male', '1990-05-14', 101),
('Emma Watson', 'emma.watson@example.com', 'Female', '1992-04-15', 609),
('Carlos Rivera', 'carlos.rivera@example.com', 'Male', '1985-09-21', 317),
('Sophia Müller', 'sophia.muller@example.com', 'Female', '1995-12-10', 712),
('Akira Tanaka', 'akira.tanaka@example.com', 'Male', '1988-08-19', 629),
('Liam Brown', 'liam.brown@example.com', 'Male', '1993-03-25', 205),
('Priya Sharma', 'priya.sharma@example.com', 'Female', '1997-11-30', 498),
('Lucas Silva', 'lucas.silva@example.com', 'Male', '1991-07-22', 432),
('Hana Kim', 'hana.kim@example.com', 'Female', '1996-06-18', 745),
('Olivia Smith', 'olivia.smith@example.com', 'Female', '1999-01-11', 810),
('Mubtasim Fuad', 'mubtasim.fuad@example.com', 'Male', '2001-03-17', 880),
('Ishrat Suchita', 'ishrat.suchita@example.com', 'Female', '2002-02-20', 880),
('Mohammad Nadir', 'mohammad.nadir@example.com', 'Male', '1988-08-25', 880),
('Sabrina Akter', 'sabrina.akter@example.com', 'Female', '2000-06-15', 880),
('Shahriar Ahmed', 'shahriar.ahmed@example.com', 'Male', '1985-12-05', 880);

-- Inserting 15 sample merchants
INSERT INTO merchants (merchant_name, admin_id, country_code) VALUES
('Amazon', 1, 101),
('Walmart', 6, 101),
('Alibaba', 5, 356),
('Flipkart', 7, 498),
('MercadoLibre', 3, 432),
('Tesco', 2, 609),
('Rakuten', 5, 629),
('eBay', 1, 101),
('Daraz', 11, 880),
('Evaly', 12, 880),
('BDBazar', 13, 880),
('Pickaboo', 14, 880),
('ShadhinStore', 15, 880),
('BestBuy', 1, 101),
('Sainsbury’s', 2, 609);

-- Inserting 15 sample products
INSERT INTO products (merchant_id, name, price, status) VALUES
(1, 'Apple iPhone 14', 999, 'Available'),
(2, 'Samsung Galaxy S23', 850, 'Available'),
(3, 'Xiaomi Redmi Note 12', 300, 'Available'),
(4, 'Dell Inspiron Laptop', 1200, 'Available'),
(5, 'Nike Air Sneakers', 150, 'Out of Stock'),
(6, 'Sony Headphones', 200, 'Available'),
(7, 'Nintendo Switch', 350, 'Available'),
(8, 'Kindle Paperwhite', 120, 'Available'),
(9, 'Samsung Galaxy A53', 330, 'Available'),
(10, 'Realme Narzo 50A', 200, 'Available'),
(11, 'Xiaomi Mi Smart Band 6', 50, 'Out of Stock'),
(12, 'Huawei P40 Pro', 800, 'Available'),
(13, 'HP Pavilion Laptop', 950, 'Available'),
(14, 'MacBook Pro 13-inch', 1500, 'Available'),
(15, 'Google Pixel 6', 700, 'Available');

-- Inserting 15 sample orders
INSERT INTO orders (user_id, status) VALUES
(1, 'Completed'),
(2, 'Pending'),
(3, 'Completed'),
(4, 'Shipped'),
(5, 'Completed'),
(6, 'Pending'),
(7, 'Completed'),
(8, 'Shipped'),
(9, 'Completed'),
(10, 'Pending'),
(11, 'Shipped'),
(12, 'Completed'),
(13, 'Pending'),
(14, 'Shipped'),
(15, 'Completed');

-- Inserting 15 sample order items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), -- John bought iPhone
(1, 6, 2), -- John bought 2 Sony Headphones
(2, 2, 1), -- Emma ordered Samsung Galaxy
(3, 3, 2), -- Carlos bought 2 Xiaomi phones
(4, 4, 1), -- Sophia ordered Dell laptop
(5, 5, 1), -- Akira ordered Nike Sneakers
(6, 7, 1), -- Liam ordered Nintendo Switch
(7, 8, 1), -- Priya bought Kindle
(8, 1, 1), -- Lucas bought iPhone
(9, 9, 1),  -- Hana bought Samsung Galaxy A53
(10, 10, 1), -- Olivia ordered Realme Narzo 50A
(11, 11, 1), -- Mubtasim bought Xiaomi Mi Smart Band
(12, 12, 1), -- Ishrat bought Huawei P40 Pro
(13, 13, 1), -- Mohammad bought HP Pavilion Laptop
(14, 14, 1), -- Sabrina bought MacBook Pro
(15, 15, 1); -- Shahriar bought Google Pixel 6



