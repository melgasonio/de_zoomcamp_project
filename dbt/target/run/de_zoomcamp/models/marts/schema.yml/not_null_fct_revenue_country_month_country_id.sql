
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select country_id
from `de-zoomcamp-488912`.`de_zoomcamp`.`fct_revenue_country_month`
where country_id is null



  
  
      
    ) dbt_internal_test