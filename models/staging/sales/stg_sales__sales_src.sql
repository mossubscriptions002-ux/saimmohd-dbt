{{ config (materialized = 'incremental' , incremental_strategy = 'append')


}}


with 

source as (

    select * from {{ source('sales', 'sales_src') }}

),

renamed as (

    select
        sale_id,
        sale_date,
        customer_id,
        product_id,
        quantity,
        total_amount,
        created_at,
        CURRENT_TIMESTAMP as INSERT_DTS

    from source

 {% if is_incremental() %}
 where CREATED_AT > (select max(INSERT_DTS) FROM {{this}})
 {% endif %}

)

select * from renamed