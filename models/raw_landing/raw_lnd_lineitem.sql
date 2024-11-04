{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}

    select
        l_orderkey
        , l_partkey
        , l_suppkey
        , l_linenumber
        , l_quantity
        , l_extendedprice
        , l_discount
        , l_tax
        , l_returnflag
        , l_linestatus
        , l_shipdate
        , l_commitdate
        , l_receiptdate
        , l_shipinstruct
        , l_shipmode
        , l_comment
    from {{ source('tpch_data_teradata', 'raw_acq_lineitem') }}

{% elif target.type == 'snowflake' %}

    select
        l_orderkey
        , l_partkey
        , l_suppkey
        , l_linenumber
        , l_quantity
        , l_extendedprice
        , l_discount
        , l_tax
        , l_returnflag
        , l_linestatus
        , l_shipdate
        , l_commitdate
        , l_receiptdate
        , l_shipinstruct
        , l_shipmode
        , l_comment
    from  {{ source('tpch_data_snowflake', 'lineitem') }}

{% endif %}
