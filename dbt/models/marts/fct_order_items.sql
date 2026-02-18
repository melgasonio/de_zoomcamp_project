with cleaned_orders as (
  select *
  from {{ ref('int_orders_enriched') }}
)

select *
from cleaned_orders