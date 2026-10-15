WITH RECURSIVE date_bounds AS (
    SELECT 
        MIN(sale_date) AS sale_date,
        MAX(sale_date) AS max_date
    FROM flourmills_sales
    
    UNION ALL
    
    SELECT 
        CAST(sale_date + INTERVAL '1 day' AS DATE),
        max_date
    FROM date_bounds
    WHERE sale_date < max_date
)
SELECT sale_date
FROM date_bounds
ORDER BY sale_date ASC;