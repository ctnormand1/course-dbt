with

orders as (
  select * from {{ ref('stg_postgres__orders') }}
),

users as (
  select * from {{ ref('stg_postgres__users') }}
),

addresses as (
  select * from {{ ref('stg_postgres__addresses') }}
),

quantities as (
  select * from {{ ref('int_items_summed_by_order') }}
)

select
  orders.order_id,
  date_trunc('day', orders.created_at) as created_date,
  orders.status,
  date_trunc('day', orders.delivered_at) as delivered_date,
  datediff('day', created_date, delivered_date) as days_to_deliver,
  date_trunc('day', orders.estimated_delivery_at) as estimated_delivery_date,
  datediff('day', created_date, estimated_delivery_date) as estimated_days_to_deliver,
  days_to_deliver > estimated_days_to_deliver as was_delivery_estimate_exceeded,
  orders.order_cost,
  orders.shipping_cost,
  orders.total_cost,
  quantities.total_quantity,
  users.first_name,
  users.last_name,
  users.email,
  users.phone_number,
  addresses.street_address,
  addresses.zipcode,
  addresses.state,
  addresses.country
from orders
left join users on orders.user_id = users.user_id
left join addresses on orders.address_id = addresses.address_id
left join quantities on quantities.order_id = orders.order_id
