SELECT *
FROM {{ ref('int_orders_enriched') }}
WHERE NOT quantity % 1 = 0ect *
from {{ ref('int_orders_enriched') }}
where not quantity % 1 = 0