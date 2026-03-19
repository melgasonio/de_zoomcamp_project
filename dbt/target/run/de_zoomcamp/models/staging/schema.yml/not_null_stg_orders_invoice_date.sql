
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select invoice_date
from `de-zoomcamp-488912`.`de_zoomcamp`.`stg_orders`
where invoice_date is null



  
  
      
    ) dbt_internal_test