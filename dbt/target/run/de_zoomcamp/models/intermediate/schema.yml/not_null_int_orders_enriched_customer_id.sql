
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
where customer_id is null



  
  
      
    ) dbt_internal_test