WITH unique_countries AS (
    SELECT DISTINCT country
    FROM {{ ref('int_orders_enriched') }}
    WHERE country IS NOT NULL
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['country']) }} AS country_id,
    country
FROM unique_countries