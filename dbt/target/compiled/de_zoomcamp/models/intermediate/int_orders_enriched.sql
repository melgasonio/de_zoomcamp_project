WITH orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`stg_orders`
)

SELECT
  invoice_no,
  stock_code,
  description,
  quantity,
  unit_price,
  customer_id,
  country,
  invoice_date,
  (quantity * unit_price) AS total_price
FROM orders