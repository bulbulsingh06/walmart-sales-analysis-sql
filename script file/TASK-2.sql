USE walmart;
WITH pl AS (
  SELECT 
    branch,
    product_line,
    SUM(gross_income - cogs) AS profit_amount,
    SUM(gross_income) / NULLIF(SUM(cogs), 0) AS profit_margin_ratio
  FROM sales
  GROUP BY branch, product_line
),
ranked AS (
  SELECT 
    pl.*,
    ROW_NUMBER() OVER (PARTITION BY branch ORDER BY profit_amount DESC) AS rn
  FROM pl
)
SELECT 
  branch, 
  product_line, 
  profit_amount, 
  profit_margin_ratio
FROM ranked
WHERE rn = 1;