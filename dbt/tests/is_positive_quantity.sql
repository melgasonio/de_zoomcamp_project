select *
from {{ ref('int_orders_enriched') }}
where quantity <= 0