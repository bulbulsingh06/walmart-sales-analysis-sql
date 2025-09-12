USE walmart;
WITH t AS (
  SELECT 
    city,
    payment,
    COUNT(*) AS cnt,
    ROW_NUMBER() OVER (PARTITION BY city 
    ORDER BY COUNT(*) DESC) AS rn
  FROM sales
  GROUP BY city, payment
)
SELECT 
  city, 
  payment AS top_payment_method, 
  cnt AS transaction_count
FROM t
WHERE rn = 1
ORDER BY city;
