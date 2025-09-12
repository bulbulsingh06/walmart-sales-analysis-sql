-- Walmart Project – Table Setup & Task Queries

CREATE INDEX idx_sales_date ON sales (date);
CREATE INDEX idx_sales_product_line ON sales (product_line);
CREATE INDEX idx_sales_city ON sales (city);
CREATE INDEX idx_sales_customer ON sales (customer_id);
USE walmart;
SHOW TABLES;  
-- replace sales with actual table name
DESCRIBE walmartsales_clean;
SELECT * FROM walmartsales_clean LIMIT 10;
RENAME TABLE walmartsales_clean TO sales;
SELECT * FROM sales  LIMIT 10;
