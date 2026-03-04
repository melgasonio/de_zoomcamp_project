
  
    

    create or replace table `de-zoomcamp-488912`.`de_zoomcamp`.`fct_order_items`
      
    
    

    
    OPTIONS()
    as (
      WITH cleaned_orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
)

SELECT *
FROM cleaned_orders
    );
  