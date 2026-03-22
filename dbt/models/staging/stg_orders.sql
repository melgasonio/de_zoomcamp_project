WITH import_orders AS (
  SELECT *
  FROM {{ source('raw', 'orders') }}
),

cleaned_orders AS (
    SELECT
        TRIM(InvoiceNo)                                                     AS invoice_no,
        TRIM(StockCode)                                                     AS stock_code,
        NULLIF(TRIM(Description), '')                                       AS description,
        CAST(NULLIF(TRIM(CAST(Quantity AS {{ dbt.type_string() }})), '') AS {{ dbt.type_bigint() }}) AS quantity,
        
        {% if target.type == 'postgres' %}
            TO_TIMESTAMP(NULLIF(TRIM(InvoiceDate), ''), 'MM/DD/YYYY HH24:MI')
        {% elif target.type == 'bigquery' %}
            PARSE_TIMESTAMP('%m/%d/%Y %H:%M', NULLIF(TRIM(InvoiceDate), ''))
        {% else %}
            CAST(NULLIF(TRIM(InvoiceDate), '') AS {{ dbt.type_timestamp() }})
        {% endif %}                                                         AS invoice_date,
        

        CAST(NULLIF(TRIM(CAST(UnitPrice AS {{ dbt.type_string() }})), '') AS {{ dbt.type_numeric() }}) AS unit_price,
        CAST(NULLIF(TRIM(CAST(CustomerID AS {{ dbt.type_string() }})), '') AS {{ dbt.type_bigint() }}) AS customer_id,
        TRIM(Country)                                                       AS country
    FROM import_orders
    WHERE InvoiceNo IS NOT NULL
      AND TRIM(InvoiceNo) <> ''
      AND TRIM(InvoiceNo) NOT LIKE 'C%'
)

SELECT *
FROM cleaned_orders