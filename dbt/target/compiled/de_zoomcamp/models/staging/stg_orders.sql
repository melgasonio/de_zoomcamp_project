WITH import_orders AS (
  SELECT *
  FROM `de-zoomcamp-488912`.`de_zoomcamp`.`raw_orders`
),

cleaned_orders AS (
    SELECT
        TRIM(InvoiceNo)                                                     AS invoice_no,
        TRIM(StockCode)                                                     AS stock_code,
        NULLIF(TRIM(Description), '')                                       AS description,
        CAST(NULLIF(TRIM(CAST(Quantity AS STRING)), '') AS INT64)           AS quantity,
        PARSE_TIMESTAMP('%m/%d/%Y %H:%M', NULLIF(TRIM(InvoiceDate), ''))    AS invoice_date,
        CAST(NULLIF(TRIM(CAST(UnitPrice AS STRING)), '') AS NUMERIC)        AS unit_price,
        CAST(NULLIF(TRIM(CAST(CustomerID AS STRING)), '') AS INT64)         AS customer_id,
        TRIM(Country)                                                       AS country
    FROM import_orders
    WHERE InvoiceNo IS NOT NULL
      AND TRIM(InvoiceNo) <> ''
      AND TRIM(InvoiceNo) NOT LIKE 'C%'
)

SELECT *
FROM cleaned_orders