select *
from {{ ref('int_orders_enriched') }}
where not quantity % 1 = 0