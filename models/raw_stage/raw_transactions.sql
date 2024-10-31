SELECT
    b.O_ORDERKEY AS ORDER_ID,
    b.O_CUSTKEY AS CUSTOMER_ID,
    b.O_ORDERDATE AS ORDER_DATE,
    b.O_ORDERDATE + INTERVAL '20' day AS TRANSACTION_DATE,
    TO_NUMBER(RPAD(CONCAT(TO_CHAR(b.O_ORDERKEY), TO_CHAR(b.O_CUSTKEY), TO_CHAR(b.O_ORDERDATE, 'YYYYMMDD')),  24, '0')) AS TRANSACTION_NUMBER,
    b.O_TOTALPRICE AS AMOUNT,
    CAST(
    CASE RANDOM(1, 2)
        WHEN 1 THEN 'DR'
        WHEN 2 THEN 'CR'
    END AS VARCHAR(2)) AS "xxxxTYPE"
FROM {{ source('tpch_sample', 'ORDERS') }}  AS b
LEFT JOIN {{ source('tpch_sample', 'CUSTOMER') }} AS c
    ON b.O_CUSTKEY = c.C_CUSTKEY
WHERE b.O_ORDERDATE = TO_DATE('{{ var('load_date') }}')