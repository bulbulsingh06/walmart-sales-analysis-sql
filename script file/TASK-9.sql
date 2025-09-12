USE walmart;
SELECT 
    customer_id,
    customer_type,
    SUM(total) AS total_sales
FROM sales
GROUP BY customer_id, customer_type
ORDER BY total_sales DESC
LIMIT 5;
