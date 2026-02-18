with cleaned_orders as (
  select *
  from {{ ref('int_orders_enriched') }}
)

select distinct stock_code, description
from cleaned_orders