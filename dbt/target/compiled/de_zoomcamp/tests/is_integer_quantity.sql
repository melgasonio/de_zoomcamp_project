select *
from "ecom"."public"."int_orders_enriched"
where not quantity % 1 = 0