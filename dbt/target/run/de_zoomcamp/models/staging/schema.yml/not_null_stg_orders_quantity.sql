
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select quantity
from `de-zoomcamp-488912`.`de_zoomcamp`.`stg_orders`
where quantity is null



  
  
      
    ) dbt_internal_test