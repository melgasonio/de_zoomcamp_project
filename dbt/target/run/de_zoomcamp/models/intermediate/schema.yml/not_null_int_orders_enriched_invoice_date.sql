
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select invoice_date
from "ecom"."public"."int_orders_enriched"
where invoice_date is null



  
  
      
    ) dbt_internal_test