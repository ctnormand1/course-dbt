with

source as (
  select * from {{ source('postgres', 'order_items') }}
),

order_items as (
  select
    order_id,
    product_id,
    quantity
  from source
)

select * from order_items
