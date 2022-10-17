with

orders as (
  select * from {{ ref('stg_postgres__orders') }}
),

promos as (
  select * from {{ ref('stg_postgres__promos') }}
)

select
  promos.promo_id,
  promos.status,
  promos.discount,
  count(*) as count_orders,
  round(sum(promos.discount * orders.order_cost / 100), 2) as total_savings
from orders
join promos on orders.promo_id = promos.promo_id
group by promos.promo_id, promos.status, promos.discount
