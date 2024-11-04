{{
    config( materialized = "view" ) 
}}


{% if target.type == 'teradata' %}

    select
        ps_partkey
        , ps_suppkey
        , ps_availqty
        , ps_supplycost
        , ps_comment
    from {{ source('tpch_data_teradata', 'raw_acq_partsupp') }}

{% elif target.type == 'snowflake' %}

    select
        ps_partkey
        , ps_suppkey
        , ps_availqty
        , ps_supplycost
        , ps_comment
    from {{ source('tpch_data_snowflake', 'partsupp') }}

{% endif %}
