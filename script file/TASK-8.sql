USE walmart;
WITH t AS (
  SELECT
    customer_id,
    customer_type,
    ï»¿invoice_id,
    date AS purchase_date,
    LEAD(date) OVER (PARTITION BY customer_id ORDER BY date) 
    AS next_purchase_date
  FROM sales
)
SELECT DISTINCT customer_id, customer_type
FROM t
WHERE next_purchase_date IS NOT NULL
  AND DATEDIFF(next_purchase_date, purchase_date) <= 30
ORDER BY customer_id;