{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}

    select
        c_custkey
        ,c_name
        ,c_address
        ,c_nationkey
        ,c_phone
        ,c_acctbal
        ,c_mktsegment
        ,c_comment
    from {{ source('tpch_data_teradata', 'raw_acq_customer') }}

{% elif target.type == 'snowflake' %}

    select
        c_custkey
        ,c_name
        ,c_address
        ,c_nationkey
        ,c_phone
        ,c_acctbal
        ,c_mktsegment
        ,c_comment
    from {{ source('tpch_data_snowflake', 'customer') }}

{% endif %}
