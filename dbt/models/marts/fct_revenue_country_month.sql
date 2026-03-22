WITH cleaned_orders AS (
  SELECT *
  FROM {{ ref('int_orders_enriched') }}
),

countries AS (
  SELECT *
  FROM {{ ref('dim_countries') }}
)

SELECT 
    cleaned_orders.country,
    countries.country_id,
    {{ dbt.date_trunc('month', 'cleaned_orders.invoice_date') }} AS month,
    SUM(cleaned_orders.total_price) AS revenue
FROM cleaned_orders
LEFT JOIN countries
ON cleaned_orders.country = countries.country
GROUP BY 1, 2, 3