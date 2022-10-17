with

products as (
  select * from {{ ref('stg_postgres__products') }}
),

order_items as (
  select * from {{ ref('stg_postgres__order_items') }}
)

select
  products.product_id,
  products.name,
  sum(order_items.quantity) as quantity_sold,
  sum(products.price) as total_revenue
from order_items
join products on order_items.product_id = products.product_id
group by products.product_id, products.name
