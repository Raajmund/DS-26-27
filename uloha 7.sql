WITH monthly_country_sales AS (
    SELECT 
        country,
        DATE_TRUNC('month', invoice_date) AS month, -- alebo TO_CHAR(invoice_date, 'YYYY-MM') podľa preferencie formátu
        SUM(quantity * unit_price) AS total_amount
    FROM 
        retail_sales
    GROUP BY 
        country, 
        DATE_TRUNC('month', invoice_date)
),
country_quartiles AS (
    SELECT 
        country,
        month,
        total_amount,
        NTILE(4) OVER (
            PARTITION BY country 
            ORDER BY total_amount DESC
        ) AS sales_quartile
    FROM 
        monthly_country_sales
)
SELECT 
    country,
    month AS month,
    total_amount,
    sales_quartile
FROM 
    country_quartiles
ORDER BY 
    country ASC, 
    month ASC;