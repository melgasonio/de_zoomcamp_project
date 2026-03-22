-- back compat for old kwarg name
  
  
        
    

    

    merge into `de-zoomcamp-488912`.`de_zoomcamp`.`fct_order_items` as DBT_INTERNAL_DEST
        using (WITH cleaned_orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`int_orders_enriched`
),

countries AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`dim_countries`
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
  countries.country_id
FROM cleaned_orders
LEFT JOIN countries
ON cleaned_orders.country = countries.country
        ) as DBT_INTERNAL_SOURCE
        on (FALSE)

    

    when not matched then insert
        (`invoice_no`, `stock_code`, `description`, `quantity`, `unit_price`, `total_price`, `customer_id`, `country`, `invoice_date`, `country_id`)
    values
        (`invoice_no`, `stock_code`, `description`, `quantity`, `unit_price`, `total_price`, `customer_id`, `country`, `invoice_date`, `country_id`)


    