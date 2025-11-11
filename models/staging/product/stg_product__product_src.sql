{{
    config
    ( materialized = 'incremental',
       incremental_strategy = 'delete+insert',
       unique_key = 'product_id')
}}



with 

source as (

    select * from {{ source('product', 'product_src') }}

),

renamed as (

    select
        product_id,
        product_name,
        product_price,
        created_at,
        CURRENT_TIMESTAMP as INSERT_DTS

    from source

    {% if is_incremental() %}
    WHERE created_at > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

select * from renamed


