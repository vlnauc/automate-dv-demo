{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}
    select
        o_orderkey
        , o_custkey
        , o_orderstatus
        , o_totalprice
        , o_orderdate
        , o_orderpriority
        , o_clerk
        , o_shippriority
        , o_comment
    from {{ source('tpch_data_teradata', 'raw_acq_orders') }}

{% elif target.type == 'snowflake' %}

    select
        o_orderkey
        , o_custkey
        , o_orderstatus
        , o_totalprice
        , o_orderdate
        , o_orderpriority
        , o_clerk
        , o_shippriority
        , o_comment
    from {{ source('tpch_data_snowflake', 'orders') }}


{% endif %}