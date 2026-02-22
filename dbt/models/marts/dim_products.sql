with cleaned_orders as (
  select *
  from {{ ref('int_orders_enriched') }}
)

select distinct stock_code as id, description
from cleaned_orders