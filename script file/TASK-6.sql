USE walmart;
WITH m AS (
  SELECT 
    DATE_FORMAT(date, '%Y-%m') AS ym, 
    gender, 
    SUM(total) AS sales
  FROM sales
  GROUP BY ym, gender
),

mt AS (
  SELECT 
    ym, 
    SUM(sales) AS month_total
  FROM m
  GROUP BY ym
)
SELECT
  m.ym,
  m.gender,
  m.sales AS gender_sales,
  ROUND((m.sales / mt.month_total) * 100, 2) AS pct_of_month
FROM m
JOIN mt USING (ym)
ORDER BY m.ym, m.gender;
