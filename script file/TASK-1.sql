USE walmart;
WITH monthly AS (
  SELECT branch, DATE_FORMAT(date, '%Y-%m') AS ym, SUM(total) AS sales
  FROM sales
  GROUP BY branch, ym
),
growth AS (
  SELECT branch, ym, sales,
         LAG(sales) OVER (PARTITION BY branch ORDER BY ym) AS prev_sales,
         (sales - LAG(sales) OVER (PARTITION BY branch ORDER BY ym))
           / NULLIF(LAG(sales) OVER (PARTITION BY branch ORDER BY ym), 0) AS mom_growth 
  FROM monthly
)
SELECT branch, ROUND(AVG(mom_growth)*100,2) AS avg_mom_growth_pct
FROM growth
WHERE prev_sales IS NOT NULL
GROUP BY branch
ORDER BY avg_mom_growth_pct DESC;
