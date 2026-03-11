
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from `de-zoomcamp-488912`.`de_zoomcamp`.`dim_products`
where id is null



  
  
      
    ) dbt_internal_test