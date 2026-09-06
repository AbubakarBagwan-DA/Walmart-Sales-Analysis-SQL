-- =============================================
-- WALMART SALES ANALYSIS PROJECT
-- Database & Table Creation + Data Insertion
-- =============================================
CREATE DATABASE Walmart;
GO

USE Walmart;
GO
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_type VARCHAR(40) NOT NULL,
    gender VARCHAR(20) NOT NULL
);
GO

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_line VARCHAR(120) NOT NULL UNIQUE
);
GO

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    invoice_id VARCHAR(40) NOT NULL UNIQUE,
    store_id INT NOT NULL,
    customer_id INT NOT NULL,
    [date] DATE NOT NULL,
    [time] TIME NOT NULL,
    payment VARCHAR(40) NOT NULL,
    cogs DECIMAL(12, 2) NOT NULL,
    tax_5 DECIMAL(12, 2) NOT NULL,
    total DECIMAL(12, 2) NOT NULL,
    gross_margin_percentage DECIMAL(8, 4) NOT NULL,
    rating DECIMAL(4, 2),

    CONSTRAINT fk_transactions_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT chk_transaction_amounts
        CHECK (
            total >= 0
            AND cogs >= 0
            AND tax_5 >= 0
        )
);
GO

CREATE TABLE transaction_items (
    transaction_item_id INT PRIMARY KEY,
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    gross_income DECIMAL(12, 2) NOT NULL,

    CONSTRAINT fk_items_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),

    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_item_amounts
        CHECK (
            unit_price >= 0
            AND quantity > 0
            AND gross_income >= 0
        )
);
GO

CREATE TABLE weekly_store_sales (
    weekly_sale_id INT IDENTITY(1,1) PRIMARY KEY,
    store INT NOT NULL,
    [date] DATE NOT NULL,
    weekly_sales DECIMAL(14, 2) NOT NULL,
    holiday_flag INT NOT NULL,
    temperature DECIMAL(8, 2),
    fuel_price DECIMAL(8, 3),
    cpi DECIMAL(12, 4),
    unemployment DECIMAL(8, 3),

    CONSTRAINT uq_weekly_store_date
        UNIQUE (store, [date]),

    CONSTRAINT chk_weekly_sales_amount
        CHECK (weekly_sales >= 0),

    CONSTRAINT chk_holiday_flag
        CHECK (holiday_flag IN (0, 1))
);
GO

SELECT TABLE_NAME
from INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

INSERT INTO customers (customer_id, customer_type, gender)
VALUES
(1,  'Member', 'Female'),
(2,  'Member', 'Male'),
(3,  'Normal', 'Female'),
(4,  'Member', 'Female'),
(5,  'Normal', 'Male'),
(6,  'Member', 'Male'),
(7,  'Normal', 'Female'),
(8,  'Member', 'Female'),
(9,  'Normal', 'Male'),
(10, 'Member', 'Male'),
(11, 'Normal', 'Female'),
(12, 'Member', 'Female'),
(13, 'Normal', 'Male'),
(14, 'Member', 'Male'),
(15, 'Normal', 'Female'),
(16, 'Member', 'Female'),
(17, 'Normal', 'Male'),
(18, 'Member', 'Male'),
(19, 'Normal', 'Female'),
(20, 'Member', 'Female');
GO

SELECT *
from customers;

INSERT INTO products (product_id, product_line)
VALUES
(1, 'Health and Beauty'),
(2, 'Electronic Accessories'),
(3, 'Home and Lifestyle'),
(4, 'Sports and Travel'),
(5, 'Food and Beverages'),
(6, 'Fashion Accessories');
GO

SELECT *
from products;

INSERT INTO transactions
(transaction_id, invoice_id, store_id, customer_id, [date], [time],
 payment, cogs, tax_5, total, gross_margin_percentage, rating)
VALUES
(1001, 'WMT-1001', 101, 1,  '2026-01-03', '10:15:00', 'Credit Card', 125.00, 6.25, 131.25, 4.7619, 8.5),
(1002, 'WMT-1002', 102, 2,  '2026-01-04', '14:30:00', 'Cash',         210.00, 10.50, 220.50, 4.7619, 7.2),
(1003, 'WMT-1003', 101, 3,  '2026-01-05', '18:45:00', 'Debit Card',   85.00, 4.25, 89.25, 4.7619, 9.1),
(1004, 'WMT-1004', 103, 4,  '2026-01-07', '12:20:00', 'Digital Wallet',175.00, 8.75, 183.75, 4.7619, 8.8),
(1005, 'WMT-1005', 102, 5,  '2026-01-10', '16:10:00', 'Cash',         320.00, 16.00, 336.00, 4.7619, 6.9),

(1006, 'WMT-1006', 101, 6,  '2026-01-12', '11:05:00', 'Credit Card',  145.00, 7.25, 152.25, 4.7619, 8.2),
(1007, 'WMT-1007', 103, 7,  '2026-01-15', '19:30:00', 'Debit Card',   260.00, 13.00, 273.00, 4.7619, 7.8),
(1008, 'WMT-1008', 102, 8,  '2026-01-18', '13:40:00', 'Digital Wallet',95.00, 4.75, 99.75, 4.7619, 9.3),
(1009, 'WMT-1009', 101, 9,  '2026-01-20', '17:15:00', 'Cash',         185.00, 9.25, 194.25, 4.7619, 6.7),
(1010, 'WMT-1010', 103, 10, '2026-01-23', '15:25:00', 'Credit Card',  410.00, 20.50, 430.50, 4.7619, 8.9),

(1011, 'WMT-1011', 102, 11, '2026-02-02', '10:45:00', 'Debit Card',   115.00, 5.75, 120.75, 4.7619, 8.1),
(1012, 'WMT-1012', 101, 12, '2026-02-05', '18:05:00', 'Credit Card',  280.00, 14.00, 294.00, 4.7619, 9.0),
(1013, 'WMT-1013', 103, 13, '2026-02-08', '12:35:00', 'Cash',         155.00, 7.75, 162.75, 4.7619, 7.4),
(1014, 'WMT-1014', 102, 14, '2026-02-11', '16:50:00', 'Digital Wallet',225.00, 11.25, 236.25, 4.7619, 8.6),
(1015, 'WMT-1015', 101, 15, '2026-02-14', '19:10:00', 'Debit Card',   360.00, 18.00, 378.00, 4.7619, 9.2),

(1016, 'WMT-1016', 103, 16, '2026-02-17', '11:30:00', 'Credit Card',  130.00, 6.50, 136.50, 4.7619, 8.7),
(1017, 'WMT-1017', 102, 17, '2026-02-20', '14:15:00', 'Cash',         195.00, 9.75, 204.75, 4.7619, 7.1),
(1018, 'WMT-1018', 101, 18, '2026-02-22', '17:40:00', 'Debit Card',   305.00, 15.25, 320.25, 4.7619, 8.4),
(1019, 'WMT-1019', 103, 19, '2026-02-25', '13:05:00', 'Digital Wallet',170.00, 8.50, 178.50, 4.7619, 8.0),
(1020, 'WMT-1020', 102, 20, '2026-02-28', '18:55:00', 'Credit Card',  450.00, 22.50, 472.50, 4.7619, 9.4),

(1021, 'WMT-1021', 101, 1,  '2026-03-03', '09:50:00', 'Debit Card',   220.00, 11.00, 231.00, 4.7619, 8.8),
(1022, 'WMT-1022', 103, 2,  '2026-03-06', '15:35:00', 'Credit Card',  390.00, 19.50, 409.50, 4.7619, 9.0),
(1023, 'WMT-1023', 102, 4,  '2026-03-09', '12:10:00', 'Cash',         140.00, 7.00, 147.00, 4.7619, 7.6),
(1024, 'WMT-1024', 101, 6,  '2026-03-12', '18:25:00', 'Digital Wallet',275.00, 13.75, 288.75, 4.7619, 8.9),
(1025, 'WMT-1025', 103, 8,  '2026-03-15', '16:45:00', 'Debit Card',   510.00, 25.50, 535.50, 4.7619, 9.5),

(1026, 'WMT-1026', 102, 10, '2026-03-18', '11:55:00', 'Credit Card',  185.00, 9.25, 194.25, 4.7619, 8.3),
(1027, 'WMT-1027', 101, 12, '2026-03-21', '14:40:00', 'Cash',         335.00, 16.75, 351.75, 4.7619, 7.9),
(1028, 'WMT-1028', 103, 14, '2026-03-24', '19:05:00', 'Digital Wallet',245.00, 12.25, 257.25, 4.7619, 8.6),
(1029, 'WMT-1029', 102, 16, '2026-03-27', '10:25:00', 'Debit Card',   160.00, 8.00, 168.00, 4.7619, 8.1),
(1030, 'WMT-1030', 101, 18, '2026-03-30', '17:20:00', 'Credit Card',  425.00, 21.25, 446.25, 4.7619, 9.3);
GO

/*SELECT COUNT(*) AS transaction_count
from transactions;*/

/*SELECT TOP 10 * from transactions
ORDER  BY transaction_id;*/

INSERT INTO transaction_items
(transaction_item_id, transaction_id, product_id, unit_price, quantity, gross_income)
VALUES
(1,  1001, 5,  50.00, 2, 5.00),
(2,  1001, 3,  25.00, 1, 2.50),
(3,  1002, 2,  70.00, 3, 10.50),
(4,  1003, 1,  45.00, 1, 4.50),
(5,  1004, 3,  60.00, 2, 6.00),
(6,  1005, 4,  80.00, 4, 16.00),

(7,  1006, 6,  55.00, 2, 5.50),
(8,  1007, 2,  65.00, 4, 13.00),
(9,  1008, 5,  30.00, 2, 3.00),
(10, 1009, 3,  75.00, 2, 7.50),
(11, 1010, 2,  82.00, 5, 20.50),

(12, 1011, 1,  55.00, 2, 5.50),
(13, 1012, 4,  70.00, 4, 14.00),
(14, 1013, 5,  31.00, 5, 7.75),
(15, 1014, 3,  75.00, 3, 11.25),
(16, 1015, 2,  90.00, 4, 18.00),

(17, 1016, 6,  65.00, 2, 6.50),
(18, 1017, 3,  65.00, 3, 9.75),
(19, 1018, 4,  85.00, 4, 17.00),
(20, 1019, 1,  85.00, 2, 8.50),
(21, 1020, 2,  90.00, 5, 22.50),

(22, 1021, 5,  55.00, 4, 11.00),
(23, 1022, 2,  78.00, 5, 19.50),
(24, 1023, 3,  70.00, 2, 7.00),
(25, 1024, 4,  75.00, 4, 15.00),
(26, 1025, 2,  85.00, 6, 25.50),

(27, 1026, 6,  55.00, 3, 9.25),
(28, 1027, 5,  67.00, 5, 16.75),
(29, 1028, 3,  85.00, 3, 12.25),
(30, 1029, 1,  80.00, 2, 8.00),
(31, 1030, 2,  85.00, 5, 21.25);
GO

/*SELECT COUNT(*) AS item_count
from transaction_items;

SELECT 
    COUNT(*) AS transaction_count,
    SUM(total) AS total_sales,
    SUM(cogs) AS total_cogs,
    SUM(tax_5) AS total_tax
from transactions;*/

INSERT INTO weekly_store_sales
(store, [date], weekly_sales, holiday_flag, temperature, fuel_price, cpi, unemployment)
VALUES
(101, '2026-01-02', 24500.00, 0, 52.30, 2.489, 258.120, 5.10),
(102, '2026-01-02', 28100.00, 0, 48.70, 2.512, 258.120, 5.10),
(103, '2026-01-02', 21900.00, 0, 55.10, 2.475, 258.120, 5.10),

(101, '2026-01-09', 25150.00, 0, 49.80, 2.501, 258.350, 5.08),
(102, '2026-01-09', 28750.00, 0, 46.20, 2.523, 258.350, 5.08),
(103, '2026-01-09', 22500.00, 0, 53.40, 2.490, 258.350, 5.08),

(101, '2026-01-16', 26300.00, 0, 45.60, 2.515, 258.610, 5.05),
(102, '2026-01-16', 29400.00, 0, 43.90, 2.537, 258.610, 5.05),
(103, '2026-01-16', 23100.00, 0, 50.20, 2.502, 258.610, 5.05),

(101, '2026-01-23', 27850.00, 0, 41.30, 2.529, 258.870, 5.02),
(102, '2026-01-23', 30900.00, 0, 39.80, 2.551, 258.870, 5.02),
(103, '2026-01-23', 24200.00, 0, 47.60, 2.518, 258.870, 5.02),

(101, '2026-02-13', 31500.00, 1, 38.50, 2.575, 259.210, 4.98),
(102, '2026-02-13', 35200.00, 1, 36.90, 2.598, 259.210, 4.98),
(103, '2026-02-13', 28900.00, 1, 44.70, 2.560, 259.210, 4.98),

(101, '2026-02-20', 26900.00, 0, 42.10, 2.590, 259.430, 4.95),
(102, '2026-02-20', 30100.00, 0, 39.70, 2.612, 259.430, 4.95),
(103, '2026-02-20', 24750.00, 0, 47.30, 2.578, 259.430, 4.95),

(101, '2026-03-06', 28600.00, 0, 55.80, 2.621, 259.720, 4.91),
(102, '2026-03-06', 32750.00, 0, 52.40, 2.645, 259.720, 4.91),
(103, '2026-03-06', 26400.00, 0, 60.10, 2.610, 259.720, 4.91),

(101, '2026-03-20', 30200.00, 0, 63.40, 2.648, 260.010, 4.88),
(102, '2026-03-20', 34100.00, 0, 60.80, 2.671, 260.010, 4.88),
(103, '2026-03-20', 27850.00, 0, 67.20, 2.635, 260.010, 4.88);
GO

SELECT COUNT(*) AS weekly_sales_records
from weekly_store_sales;

-- 1. Customers
SELECT COUNT(*) AS customer_count
from customers;

-- 2. Products
SELECT COUNT(*) AS product_count
from products;

-- 3. Transactions
SELECT COUNT(*) AS transaction_count
from transactions;

-- 4. Transaction Items
SELECT COUNT(*) AS transaction_item_count
from transaction_items;

-- 5. Weekly Store Sales
SELECT COUNT(*) AS weekly_sales_count
from weekly_store_sales;

SELECT 
    t.transaction_id,
    t.invoice_id
from transactions t
LEFT JOIN transaction_items ti
    ON t.transaction_id = ti.transaction_id
WHERE ti.transaction_id IS NULL;

-- =============================================
-- SALES ANALYSIS QUERIES - PART 1
-- =============================================

--overall Sales KPIs
SELECT
    count(Distinct transaction_id) As total_trans,
    count(Distinct customer_id) As unique_cust,
    sum(total) As total_sales,
    cast(round(avg(total),2) As decimal (10,2)) As avg_trans_value,
    sum(cogs) As total_cogs,
	sum(tax_5) As total_tax,
    cast(round(avg(rating),2) As decimal (10,2)) As avg_cust_rating
from transactions;

--Sales Performance by Store
SELECT
    store_id,
    count(transaction_id) As total_trans,
    sum(total) As total_sales,
    cast(round(avg(total),2) AS DECIMAL(10,2)) As avg_trans_value
from transactions
group by store_id
order by total_sales DESC;

--Sales by Payment Method
SELECT
    payment,
    count(*) As transaction_count,
    sum(total) As total_sales,
   cast(round(avg(total),2) AS DECIMAL(10,2)) As avg_trans_value
from transactions
group by payment
order by total_sales DESC;

--Sales by Customer Type and Gender
SELECT
    c.customer_type,
    c.gender,
    count(t.transaction_id) As transaction_count,
    sum(t.total) As total_sales,
    cast(round(avg(total),2) AS DECIMAL(10,2)) As avg_trans_value
from transactions t
INNER JOIN customers c
    ON t.customer_id = c.customer_id
group by
    c.customer_type,
    c.gender
order by total_sales DESC;

--Product Performance
SELECT
    p.product_line,
    sum(ti.quantity) As units_sold,
    sum(ti.gross_income) As gross_income,
    cast(round(avg(ti.unit_price),2) as decimal(10,2)) As avg_unit_price
from transaction_items ti
INNER JOIN products p
    ON ti.product_id = p.product_id
group by p.product_line
order by gross_income DESC;

--monthly Sales Trend
SELECT
    year([date]) As sales_year,
    month([date]) As sales_month,
    sum(total) As monthly_sales,
    count(transaction_id) As trans_count,
    cast(round(avg(total),2) AS DECIMAL(10,2)) As avg_trans_value
from transactions
group by
    year([date]),
    month([date])
order by
    sales_year,
    sales_month;

--Weekly Store Performance
SELECT
    store,
    count(*) As weeks_recorded,
    sum(weekly_sales) As total_weekly_sales,
    cast(round(avg(weekly_sales),2) as decimal(10,2)) As avg_weekly_sales,
    max(weekly_sales) As highest_weekly_sales,
    min(weekly_sales) As lowest_weekly_sales
from weekly_store_sales
group by store
order by total_weekly_sales DESC;

-- =============================================
-- SALES ANALYSIS QUERIES - PART 2
-- =============================================

--Ranking Customers from Highest to Lowest
SELECT
    c.customer_id,
    c.customer_type,
    c.gender,
    sum(t.total) As total_sales,
    count(t.transaction_id) As trans_count,
    rank() over (
        order by sum(t.total) DESC
    ) As sales_rank
from transactions t
INNER JOIN customers c
    ON t.customer_id = c.customer_id
group by
    c.customer_id,
    c.customer_type,
    c.gender
order by sales_rank;

--Top Product Lines
SELECT
    p.product_line,
    sum(ti.quantity) As units_sold,
    sum(ti.gross_income) As gross_income,
    rank() over (
        order by sum(ti.gross_income) DESC
    ) As product_rank
from transaction_items ti
INNER JOIN products p
    ON ti.product_id = p.product_id
group by
    p.product_line
order by product_rank;

--month-over-month Sales Growth
WITH monthly_sales As (
    SELECT
        year([date]) As sales_year,
        month([date]) As sales_month,
        sum(total) As monthly_sales
    from transactions
    group by
        year([date]),
        month([date])
)
SELECT
    sales_year,
    sales_month,
    monthly_sales,
    LAG(monthly_sales) over (
        order by sales_year, sales_month
    ) As previous_month_sales,
    monthly_sales
        - LAG(monthly_sales) over (
            order by sales_year, sales_month
        ) As sales_change
from monthly_sales
order by
    sales_year,
    sales_month;

--Customer Segmentation
WITH customer_sales As (
    SELECT
        c.customer_id,
        c.customer_type,
        c.gender,
        sum(t.total) As total_sales
    from transactions t
    INNER JOIN customers c
        ON t.customer_id = c.customer_id
    group by
        c.customer_id,
        c.customer_type,
        c.gender
)
SELECT
    customer_id,
    customer_type,
    gender,
    total_sales,
    CAsE
        when total_sales >= 700 then 'High Value'
        when total_sales >= 400 then 'Medium Value'
        else 'Low Value'
    end As customer_segment
from customer_sales
order by total_sales DESC;


