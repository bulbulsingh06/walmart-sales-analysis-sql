USE walmart;
WITH t AS (
  SELECT 
    customer_type,
    product_line,
    SUM(total) AS sales_total,
    ROW_NUMBER() OVER (PARTITION BY customer_type 
    ORDER BY SUM(total) DESC) AS rn
  FROM sales
  GROUP BY customer_type, product_line
)
SELECT 
  customer_type, 
  product_line, 
  sales_total
FROM t
WHERE rn = 1;