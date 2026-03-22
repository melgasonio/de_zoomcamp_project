
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT *
FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
WHERE MOD(quantity, 1) != 0
  
  
      
    ) dbt_internal_test