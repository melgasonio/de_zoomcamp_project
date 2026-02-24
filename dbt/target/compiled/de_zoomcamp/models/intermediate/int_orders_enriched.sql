WITH orders AS (
  SELECT *
  FROM "ecom"."public"."stg_orders"
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