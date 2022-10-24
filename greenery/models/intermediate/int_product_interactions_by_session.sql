with 

distinct_sessions_and_products as (
  select distinct
    {{ dbt_utils.surrogate_key(['session_id', 'product_id']) }} as surrogate_key,
    session_id,
    product_id
  from {{ ref('stg_postgres__events') }}
  where product_id is not null
),

page_views as (
  select
    {{ dbt_utils.surrogate_key(['session_id', 'product_id']) }} as surrogate_key
  from {{ ref('stg_postgres__events') }}
  where event_type = 'page_view'
),

cart_adds as (
  select
    {{ dbt_utils.surrogate_key(['session_id', 'product_id']) }} as surrogate_key
  from {{ ref('stg_postgres__events') }}
  where event_type = 'add_to_cart'
),

checkouts as (
  select
    {{ dbt_utils.surrogate_key(['session_id', 'product_id']) }} as surrogate_key
  from {{ ref('int_checkout_events_fanned_by_product') }}
)

select 
  session_id,
  product_id,
  surrogate_key in (select surrogate_key from page_views) as was_page_viewed,
  surrogate_key in (select surrogate_key from cart_adds) as was_product_added_to_cart,
  surrogate_key in (select surrogate_key from checkouts) as was_product_ordered
from distinct_sessions_and_products
