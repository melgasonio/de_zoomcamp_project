WITH cleaned_orders AS (
  SELECT *
  FROM {{ ref('int_orders_enriched') }}
),

countries AS (
  SELECT *
  FROM {{ ref('dim_countries') }}
)

SELECT 
  cleaned_orders.invoice_no,
  cleaned_orders.stock_code,
  cleaned_orders.description,
  cleaned_orders.quantity,
  cleaned_orders.unit_price,
  cleaned_orders.total_price,
  cleaned_orders.customer_id,
  cleaned_orders.country,
  cleaned_orders.invoice_date,
  countries.country_id,
FROM cleaned_orders
LEFT JOIN countries
ON cleaned_orders.country = countries.country