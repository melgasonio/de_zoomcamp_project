
  
    

  create  table "ecom"."public"."int_orders_enriched__dbt_tmp"
  
  
    as
  
  (
    with orders as (
  select *
  from "ecom"."public"."stg_orders"
)

select
  invoice_no,
  stock_code,
  description,
  quantity,
  unit_price,
  customer_id,
  country,
  invoice_date,
  (quantity * unit_price) as total_price
from orders
  );
  