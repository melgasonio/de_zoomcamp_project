
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select description
from "ecom"."public"."int_orders_enriched"
where description is null



  
  
      
    ) dbt_internal_test