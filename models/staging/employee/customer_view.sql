{{
    config
    (materialized = 'view')
}}


select * from {{ ref('customers') }} where
COUNTRY = 'USA'