CREATE INDEX idx_orders_order_date
ON orders (order_date);

SELECT 
    DATE_TRUNC('month', order_date)::date AS order_month,
    SUM(sales) AS total_sales
FROM 
    orders
GROUP BY 
    DATE_TRUNC('month', order_date)::date
ORDER BY 
    order_month ASC;