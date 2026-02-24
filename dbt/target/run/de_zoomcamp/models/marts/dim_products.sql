
      
  
    

  create  table "ecom"."public"."dim_products__dbt_tmp"
  
  
    as
  
  (
    WITH cleaned_orders AS (
  SELECT *
  FROM "ecom"."public"."int_orders_enriched"
)

SELECT stock_code AS id, description
FROM (
	SELECT *,
			ROW_NUMBER() OVER (
          PARTITION BY stock_code 
          ORDER BY 
            CASE WHEN description IS NULL THEN 1 ELSE 0 END ASC,
            invoice_no ASC
      ) AS row_number
	FROM cleaned_orders
) AS helper_table
WHERE row_number = 1
  );
  
  