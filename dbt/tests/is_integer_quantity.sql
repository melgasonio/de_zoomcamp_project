SELECT *
FROM {{ ref('int_orders_enriched') }}
WHERE MOD(quantity, 1) != 0