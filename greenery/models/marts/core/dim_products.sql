select
  product_id,
  name,
  price,
  inventory
from {{ ref('stg_postgres__products')}}
