

  create or replace view `de-zoomcamp-488912`.`de_zoomcamp`.`audit_duplicate_products`
  OPTIONS()
  as with cleaned_orders as (
  select *
  from `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
),
product_counts as (
  select stock_code as id, count(distinct description) as desc_count
  from cleaned_orders
  group by stock_code
)

select distinct c.*
from cleaned_orders c
inner join product_counts p on c.stock_code = p.id
where p.desc_count > 1;

