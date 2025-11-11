{{
    config
    (materialized='ephemeral')
}}

with 

source as (

    select * from {{ source('orders', 'BASE_ORDERS') }}

),

renamed as (

    select
        order_id,
        order_date,
        customer_id,
        case when customer_name is null then 'NA' else UPPER(customer_name) end as customer_name,
        created_at

    from source where order_date is not null

)

select * from renamed