WITH first_cte AS (
    SELECT 
        customer_type,
        SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY customer_type
),
second_cte AS (
    SELECT 
        customer_type,
        revenue,
        SUM(revenue) OVER () AS total_revenue,
        ROUND((revenue * 100.0) / SUM(revenue) OVER (), 2) AS revenue_percentage
    FROM first_cte
)
SELECT 
    customer_type,
    revenue,
    total_revenue,
    revenue_percentage
FROM second_cte
ORDER BY revenue DESC;