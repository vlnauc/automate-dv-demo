{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}

    select
        s_suppkey
        , s_name
        , s_address
        , s_nationkey
        , s_phone
        , s_acctbal
        , s_comment
    from {{ source('tpch_data_teradata', 'raw_acq_supplier') }}

{% elif target.type == 'snowflake' %}

    select
        s_suppkey
        , s_name
        , s_address
        , s_nationkey
        , s_phone
        , s_acctbal
        , s_comment
    from {{ source('tpch_data_snowflake', 'supplier') }}


{% endif %}