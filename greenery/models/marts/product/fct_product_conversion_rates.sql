with

products as (
  select * from {{ ref('stg_postgres__products') }}
),

interactions as (
  select * from {{ ref('int_product_interactions_by_session') }}
)

select 
  products.product_id,
  products.name,
  round(sum(was_page_viewed::int) / (select count(distinct session_id) from interactions), 4) as page_view_rate,
  round(sum(was_product_added_to_cart::int) / sum(was_page_viewed::int), 4) as cart_add_rate,
  round(sum(was_product_ordered::int) / sum(was_product_added_to_cart::int), 4) as order_rate,
  round(page_view_rate * cart_add_rate * order_rate, 4) as overall_conversion_rate
from products
join interactions on products.product_id = interactions.product_id
group by products.product_id, products.name
order by overall_conversion_rate desc
