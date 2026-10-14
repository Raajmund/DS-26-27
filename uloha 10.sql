CREATE OR REPLACE PROCEDURE get_sales_between(
    p_start_date DATE, 
    p_end_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_sales NUMERIC(10, 2);
BEGIN
    SELECT COALESCE(SUM(sales), 0)
    INTO v_total_sales
    FROM orders
    WHERE order_date BETWEEN p_start_date AND p_end_date;

    RAISE NOTICE 'Obdobie od % do % | Celkový predaj: %', p_start_date, p_end_date, v_total_sales;
END;
$$;

CALL get_sales_between('2024-01-01', '2024-03-31');