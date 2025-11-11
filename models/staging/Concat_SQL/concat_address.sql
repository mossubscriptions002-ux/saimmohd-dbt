{{
    config
    (materialized = 'table')
}}

select {{ concat_macro('124','street') }} as address