{{
    config
    (materialized = 'table')
}}

with 

source as (

    select * from {{ source('session', 'SESSION_SRC') }}

),

renamed as (

    select
        session_id,
        user_id,
        browser,
        device_type,
        b.country_name as country_name, 
        b.continent as continent,
        b.currency as currency,
        a.country_code,
        start_time,
        end_time,
        pages_visited,
        CURRENT_TIMESTAMP as INSERT_DTS

    from source a
    left join {{ ref('country_code') }} b
    on a.country_code = b.country_code

)

select * from renamed