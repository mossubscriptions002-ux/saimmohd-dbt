{{
    config
    (materialized='incremental',incremental_strategy='merge',unique_key='purchase_id',merger_exclude_columns = ['INSERT_DTS'])
}}



with 

source as (

    select * from {{ source('purchase', 'PURCHASE_SRC') }}

),

renamed as (

    select
        purchase_id,
        purchase_date,
        purchase_status,
        created_at,
        CURRENT_TIMESTAMP as INSERT_DTS,
        CURRENT_TIMESTAMP as UPDATE_DTS

    from source

    {% if is_incremental()%}
    WHERE created_at > (select max(INSERT_DTS) from {{this}})
    {% endif %}

)

select * from renamed