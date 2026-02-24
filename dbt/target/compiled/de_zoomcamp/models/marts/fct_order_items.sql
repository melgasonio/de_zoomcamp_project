WITH cleaned_orders AS (
  SELECT *
  FROM "ecom"."public"."int_orders_enriched"
)

SELECT *
FROM cleaned_orders