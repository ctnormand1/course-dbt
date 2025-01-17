with

source as (
  select * from {{ source('postgres', 'orders') }}
),

orders as (
  select
    order_id,
    promo_id,
    user_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total as total_cost,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
  from source
)

select * from orders
