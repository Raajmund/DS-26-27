WITH first_purchases AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', MIN(order_date))::date AS first_purchase_month
    FROM orders
    GROUP BY customer_id
)
SELECT 
    COUNT(*) AS returning_customers_count
FROM first_purchases fp
WHERE fp.first_purchase_month = '2024-06-01'
  AND EXISTS (
      SELECT 1 
      FROM orders o 
      WHERE o.customer_id = fp.customer_id 
        AND DATE_TRUNC('month', o.order_date)::date > fp.first_purchase_month
  );