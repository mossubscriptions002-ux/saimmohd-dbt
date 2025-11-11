{{ config
    (
        materialized = 'table'
        
    )
}}

with t1 as  (

    select     CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE,
    COUNTRY,
    CREATED_AT,
    CURRENT_TIMESTAMP as INSERT_DTS
    FROM {{ source('customers', 'CUSTOMER_SRC') }}
)

select * from t1