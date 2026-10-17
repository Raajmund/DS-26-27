WITH unique_invoices AS (
    SELECT DISTINCT 
        customer_id,
        invoice_no,
        invoice_date
    FROM 
        retail_sales
    WHERE 
        customer_id IS NOT NULL
),
invoice_leads AS (
    SELECT 
        customer_id,
        invoice_no,
        invoice_date,
        LEAD(invoice_date) OVER (
            PARTITION BY customer_id 
            ORDER BY invoice_date, invoice_no
        ) AS next_invoice_date
    FROM 
        unique_invoices
)
SELECT 
    customer_id,
    invoice_no,
        invoice_date,
    next_invoice_date,
    EXTRACT(DAY FROM (next_invoice_date - invoice_date))::INTEGER AS days_to_next_invoice
FROM 
    invoice_leads
WHERE 
    next_invoice_date IS NOT NULL
ORDER BY 
    days_to_next_invoice DESC;