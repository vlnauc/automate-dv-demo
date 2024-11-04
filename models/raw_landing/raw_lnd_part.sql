{{
    config( materialized = "view" ) 
}}


{% if target.type == 'teradata' %}

    select
        p_partkey
        , p_name
        , p_mfgr
        , p_brand
        , p_type
        , p_size
        , p_container
        , p_retailprice
        , p_comment
    from {{ source('tpch_data_teradata', 'raw_acq_part') }}

{% elif target.type == 'snowflake' %}

    select
        p_partkey
        , p_name
        , p_mfgr
        , p_brand
        , p_type
        , p_size
        , p_container
        , p_retailprice
        , p_comment
    from {{ source('tpch_data_snowflake', 'part') }}

{% endif %}