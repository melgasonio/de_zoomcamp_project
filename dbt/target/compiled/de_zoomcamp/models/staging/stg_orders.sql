WITH import_orders AS (
  SELECT *
  FROM "ecom"."public"."orders"
),

cleaned_orders AS (
    SELECT
        TRIM("InvoiceNo")                                   AS invoice_no,
        TRIM("StockCode")                                   AS stock_code,
        NULLIF(TRIM("Description"), '')                     AS description,
        NULLIF(TRIM("Quantity"::TEXT), '')::INTEGER         AS quantity,
        NULLIF(TRIM("InvoiceDate"), '')::TIMESTAMP          AS invoice_date,
        NULLIF(TRIM("UnitPrice"::TEXT), '')::NUMERIC        AS unit_price,
        NULLIF(TRIM("CustomerID"::TEXT), '')::INTEGER       AS customer_id,
        TRIM("Country")                                     AS country
    FROM import_orders
    WHERE "InvoiceNo" IS NOT NULL
      AND TRIM("InvoiceNo") <> ''
      AND TRIM("InvoiceNo") NOT ILIKE 'C%'  -- exclude cancellations                       
)

SELECT *
FROM cleaned_orders