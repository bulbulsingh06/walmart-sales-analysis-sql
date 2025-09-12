USE walmart; 
WITH stats AS (
  SELECT 
    product_line, 
    AVG(total) AS avg_total, 
    STDDEV_SAMP(total) AS sd_total
  FROM sales
  GROUP BY product_line
),
scored AS (
  SELECT 
    s.*,
    (s.total - st.avg_total) / NULLIF(st.sd_total, 0) AS z_score
  FROM sales s
  JOIN stats st 
    ON s.product_line = st.product_line
)

SELECT *
FROM scored
WHERE ABS(z_score) > 2;   

WITH stats AS (
    SELECT 
        product_line,
        AVG(total) AS avg_total,
        STDDEV_SAMP(total) AS sd_total
    FROM sales
    GROUP BY product_line
),
scored AS (
    SELECT 
        s.product_line,
        s.ï»¿invoice_id,
        s.total,
        (s.total - st.avg_total) / NULLIF(st.sd_total, 0) AS z_score
    FROM sales s
    JOIN stats st
        ON s.product_line = st.product_line
),
anomalies AS (
    SELECT *
    FROM scored
    WHERE ABS(z_score) > 2   -- threshold: 2 standard deviations
)
SELECT 
    product_line,
    COUNT(*) AS anomalies_detected,
    (SELECT COUNT(*) FROM scored s2 WHERE s2.product_line = s1.product_line) AS total_transactions,
    ROUND((COUNT(*) * 100.0) / 
          (SELECT COUNT(*) FROM scored s2 WHERE s2.product_line = s1.product_line), 2) AS pct_anomalies
FROM anomalies s1
GROUP BY product_line
ORDER BY pct_anomalies DESC; 