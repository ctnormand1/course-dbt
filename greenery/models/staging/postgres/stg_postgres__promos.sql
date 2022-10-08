with

source as (
  select * from {{ source('postgres', 'promos') }}
),

promos as (
  select
    promo_id,
    discount,
    status
  from source
)

select * from promos
