
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "ecom"."public"."int_orders_enriched"
where unit_price <= 0
  
  
      
    ) dbt_internal_test