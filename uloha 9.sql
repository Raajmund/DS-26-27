CREATE OR REPLACE PROCEDURE apply_regional_discount(
    p_region_name VARCHAR(20), 
    p_discount_rate NUMERIC(4, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders
    SET sales = sales * (1 - p_discount_rate)
    WHERE region = p_region_name;

    RAISE NOTICE 'Zľava vo výške % bola úspešne aplikovaná pre región %.', p_discount_rate, p_region_name;
END;
$$;

CALL apply_regional_discount('West', 0.10);