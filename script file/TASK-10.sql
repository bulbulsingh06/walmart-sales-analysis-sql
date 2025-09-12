USE walmart;
SELECT
    DAYNAME(date) AS day_of_week,
    ROUND(SUM(total), 2) AS total_sales,
    COUNT(*) AS num_transactions
FROM sales
GROUP BY day_of_week
ORDER BY FIELD(day_of_week,
'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');