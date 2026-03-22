-- back compat for old kwarg name
  
  
        
    

    

    merge into `de-zoomcamp-488912`.`de_zoomcamp`.`fct_revenue_country_month` as DBT_INTERNAL_DEST
        using (WITH cleaned_orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
),

countries AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`dim_countries`
)

SELECT 
    cleaned_orders.country,
    countries.country_id,
    timestamp_trunc(
        cast(cleaned_orders.invoice_date as timestamp),
        month
    ) AS month,
    SUM(cleaned_orders.total_price) AS revenue
FROM cleaned_orders
LEFT JOIN countries
ON cleaned_orders.country = countries.country
GROUP BY 1, 2, 3
        ) as DBT_INTERNAL_SOURCE
        on (FALSE)

    

    when not matched then insert
        (`country`, `country_id`, `month`, `revenue`)
    values
        (`country`, `country_id`, `month`, `revenue`)


    