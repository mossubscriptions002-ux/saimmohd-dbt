{{
    config
    (materialized='table')
}}

with cte1 as (

    select
        order_id,
        order_date,
        customer_id,
        customer_name,
        created_at,
        CURRENT_TIMESTAMP as INSERT_DTS

        from {{ ref('stg_orders__BASE_ORDERS') }}
)


select * from cte1