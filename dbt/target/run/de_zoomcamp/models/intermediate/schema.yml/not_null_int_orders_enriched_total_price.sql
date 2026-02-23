
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_price
from "ecom"."public"."int_orders_enriched"
where total_price is null



  
  
      
    ) dbt_internal_test