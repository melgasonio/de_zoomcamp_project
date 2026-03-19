
  
    

    create or replace table `de-zoomcamp-488912`.`de_zoomcamp`.`dim_countries`
      
    
    

    
    OPTIONS()
    as (
      WITH unique_countries AS (
    SELECT DISTINCT country
    FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
    WHERE country IS NOT NULL
)

SELECT 
    to_hex(md5(cast(coalesce(cast(country as string), '_dbt_utils_surrogate_key_null_') as string))) AS country_id,
    country
FROM unique_countries
    );
  