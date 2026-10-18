WITH monthly_summary AS (
    SELECT 
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
sales_comparison AS (
    SELECT 
        month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY month) AS prev_month_sales,
        monthly_sales - LAG(monthly_sales, 1) OVER (ORDER BY month) AS sales_change,
        ROUND(
            ((monthly_sales - LAG(monthly_sales, 1) OVER (ORDER BY month)) / LAG(monthly_sales, 1) OVER (ORDER BY month)) * 100, 
            2
        ) AS growth_percentage
    FROM monthly_summary
)
SELECT 
    month,
    monthly_sales,
    prev_month_sales,
    sales_change,
    growth_percentage
FROM sales_comparison
ORDER BY month ASC;