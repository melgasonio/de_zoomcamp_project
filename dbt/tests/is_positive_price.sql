select *
from {{ ref('int_orders_enriched') }}
where unit_price <= 0