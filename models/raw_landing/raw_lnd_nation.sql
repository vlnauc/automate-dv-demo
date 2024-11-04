{{
    config( materialized = "view" ) 
}}

{% if target.type == 'teradata' %}

    select
        n_nationkey
        , n_name
        , n_regionkey
        , n_comment
    from {{ source('tpch_data_teradata', 'raw_acq_nation') }}

{% elif target.type == 'snowflake' %}

    select
        n_nationkey
        , n_name
        , n_regionkey
        , n_comment
    from {{ source('tpch_data_snowflake', 'nation')}}

{% endif %}
