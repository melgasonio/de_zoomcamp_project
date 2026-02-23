
  create view "ecom"."public"."stg_orders__dbt_tmp"
    
    
  as (
    with import_orders as (
  select *
  from "ecom"."public"."orders"
),

cleaned_orders as (
    select
        trim("InvoiceNo")                                   as invoice_no,
        trim("StockCode")                                   as stock_code,
        nullif(trim("Description"), '')                     as description,
        nullif(trim("Quantity"::text), '')::integer         as quantity,
        nullif(trim("InvoiceDate"), '')::timestamp          as invoice_date,
        nullif(trim("UnitPrice"::text), '')::numeric        as unit_price,
        nullif(trim("CustomerID"::text), '')::integer       as customer_id,
        trim("Country")                                     as country
    from import_orders
    where "InvoiceNo" is not null
      and trim("InvoiceNo") <> ''
      and trim("InvoiceNo") not ilike 'C%'  -- exclude cancellations                       
)

select *
from cleaned_orders
  );