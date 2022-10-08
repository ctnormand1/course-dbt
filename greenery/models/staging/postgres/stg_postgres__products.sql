with

source as (
  select * from {{ source('postgres', 'products') }}
),

products as (
  select
    product_id,
    name,
    price,
    inventory
  from source
)

select * from products
