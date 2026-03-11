
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select stock_code
from `de-zoomcamp-488912`.`de_zoomcamp`.`fct_order_items`
where stock_code is null



  
  
      
    ) dbt_internal_test