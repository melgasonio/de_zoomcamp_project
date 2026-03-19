SELECT *
FROM {{ ref('int_orders_enriched') }}
WHERE unit_price <= 0ect *
from {{ ref('int_orders_enriched') }}
where unit_price <= 0