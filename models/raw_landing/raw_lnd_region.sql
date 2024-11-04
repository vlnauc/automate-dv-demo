{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}

    select
        r_regionkey
        , r_name
        , r_comment
    from {{ source('tpch_data_teradata', 'raw_acq_region') }}

{% elif target.type == 'snowflake' %}

    select
        r_regionkey
        , r_name
        , r_comment
    from {{ source('tpch_data_snowflake', 'region') }}

{% endif %}
