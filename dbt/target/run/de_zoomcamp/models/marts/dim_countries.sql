-- back compat for old kwarg name
  
  
        
    

    

    merge into `de-zoomcamp-488912`.`de_zoomcamp`.`dim_countries` as DBT_INTERNAL_DEST
        using (WITH unique_countries AS (
    SELECT DISTINCT country
    FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
    WHERE country IS NOT NULL
)

SELECT 
    to_hex(md5(cast(coalesce(cast(country as string), '_dbt_utils_surrogate_key_null_') as string))) AS country_id,
    country
FROM unique_countries
        ) as DBT_INTERNAL_SOURCE
        on (FALSE)

    

    when not matched then insert
        (`country_id`, `country`)
    values
        (`country_id`, `country`)


    