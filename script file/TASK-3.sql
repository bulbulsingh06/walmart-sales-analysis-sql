USE walmart;
WITH cust_spend AS (
  SELECT 
    customer_id, 
    SUM(total) AS total_spend
  FROM sales
  GROUP BY customer_id
),
quart AS (
  SELECT
    customer_id,
    total_spend,
    NTILE(4) OVER (ORDER BY total_spend) AS q
  FROM cust_spend
)
SELECT
  customer_id,
  total_spend,
  CASE
    WHEN q = 4 THEN 'High'
    WHEN q IN (2,3) THEN 'Medium'
    ELSE 'Low'
  END AS spend_tier
FROM quart
ORDER BY total_spend DESC;

