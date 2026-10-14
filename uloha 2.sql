CREATE VIEW regional_monthly_sales AS
SELECT 
    c.region,
    DATE_TRUNC('month', o.order_date)::date AS month,
    SUM(o.sales) AS monthly_sales
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.region,
    DATE_TRUNC('month', o.order_date)::date;