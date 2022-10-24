with

order_items as (
  select * from {{ ref('stg_postgres__order_items') }}
),

checkout_events as (
  select * from {{ ref('stg_postgres__events') }}
  where event_type = 'checkout'
)

select
  checkout_events.event_id,
  checkout_events.session_id,
  checkout_events.user_id,
  checkout_events.page_url,
  checkout_events.created_at,
  checkout_events.order_id,
  order_items.product_id
from order_items
join checkout_events on order_items.order_id = checkout_events.order_id
