{% if target.type == 'snowflake' %}
    -- SnowFlake
    SELECT
        b.O_ORDERKEY AS ORDER_ID,
        b.O_CUSTKEY AS CUSTOMER_ID,
        b.O_ORDERDATE AS ORDER_DATE,
        DATEADD(DAY, 20, b.O_ORDERDATE) AS TRANSACTION_DATE,
        TO_NUMBER(RPAD(CONCAT(b.O_ORDERKEY, b.O_CUSTKEY, TO_CHAR(b.O_ORDERDATE, 'YYYYMMDD')),  24, '0')) AS TRANSACTION_NUMBER,
        b.O_TOTALPRICE AS AMOUNT,
        CAST(
        CASE ABS(MOD(RANDOM(1), 2)) + 1
            WHEN 1 THEN 'DR'
            WHEN 2 THEN 'CR'
        END AS VARCHAR(2)) AS TYPE
    FROM {{ source('raw_data', 'raw_orders') }}  AS b
    LEFT JOIN {{ source('raw_data', 'raw_customer') }} AS c
        ON b.O_CUSTKEY = c.C_CUSTKEY
    WHERE b.O_ORDERDATE = TO_DATE('{{ var('load_date') }}')

{% else %}

    -- Teradata
    SELECT
        b.O_ORDERKEY AS ORDER_ID,
        b.O_CUSTKEY AS CUSTOMER_ID,
        b.O_ORDERDATE AS ORDER_DATE,
        b.O_ORDERDATE + INTERVAL '20' DAY AS TRANSACTION_DATE,
        TO_NUMBER(RPAD(CONCAT(
            TO_CHAR(b.O_ORDERKEY)
            , TO_CHAR(b.O_CUSTKEY)
            , TO_CHAR(b.O_ORDERDATE, 'YYYYMMDD')), 24, '0')) AS TRANSACTION_NUMBER,
        b.O_TOTALPRICE AS AMOUNT,
        CAST(
            CASE RANDOM(1, 2)
                WHEN 1 THEN 'DR'
                WHEN 2 THEN 'CR'
        END AS VARCHAR(2)) AS "TYPE_"
    FROM {{ source('raw_data', 'raw_orders') }}  AS b
    LEFT JOIN {{ source('raw_data', 'raw_customer') }} AS c
        ON b.O_CUSTKEY = c.C_CUSTKEY
    WHERE b.O_ORDERDATE = cast (('{{ var('load_date') }}') as date format 'yyyy-mm-dd')

{% endif %}
