
      
  
    

  create  table "ecom"."public"."fct_order_items"
  
  
    as
  
  (
    with cleaned_orders as (
  select *
  from "ecom"."public"."int_orders_enriched"
)

select *
from cleaned_orders
  );
  
  