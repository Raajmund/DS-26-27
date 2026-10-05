SELECT 
    f1.sales_id,
    f1.product_category,
    f1.product_name,
    f1.total_amount,
    f1.region,
    f1.sale_date
FROM flourmills_sales f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales f2
    WHERE f2.region = f1.region
      AND EXTRACT(YEAR FROM f2.sale_date) = 2024
);