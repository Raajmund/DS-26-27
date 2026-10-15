WITH category_sales AS (
    SELECT 
        product_category,
        SUM(total_amount) AS total_amount
    FROM flourmills_sales
    GROUP BY product_category
)
SELECT 
    product_category,
    total_amount
FROM category_sales
ORDER BY total_amount DESC;