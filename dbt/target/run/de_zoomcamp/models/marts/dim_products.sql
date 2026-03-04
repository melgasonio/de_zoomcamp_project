
  
    

    create or replace table `de-zoomcamp-488912`.`de_zoomcamp`.`dim_products`
      
    
    

    
    OPTIONS()
    as (
      WITH cleaned_orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
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
  