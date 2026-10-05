SELECT 
    c.customer_name,
    COALESCE(o.order_id, 'Bez objednávky') AS order_id,
    COALESCE(o.sales, 0) AS sales
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;