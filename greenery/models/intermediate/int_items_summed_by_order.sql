select
  order_id,
  sum(quantity) as total_quantity
from {{ ref('stg_postgres__order_items') }}
group by order_id
