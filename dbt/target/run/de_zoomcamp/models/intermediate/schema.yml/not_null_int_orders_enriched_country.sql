
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select country
from "ecom"."public"."int_orders_enriched"
where country is null



  
  
      
    ) dbt_internal_test