with cleaned_orders as (
  select *
  from "ecom"."public"."int_orders_enriched"
)

select *
from cleaned_orders