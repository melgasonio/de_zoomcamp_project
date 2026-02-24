WITH cleaned_orders AS (
  SELECT *
  FROM {{ ref('int_orders_enriched') }}
)

SELECT *
FROM cleaned_orders