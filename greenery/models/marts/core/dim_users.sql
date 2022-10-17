select
  user_id,
  first_name,
  last_name,
  email,
  phone_number,
  street_address,
  zipcode,
  state,
  country,
  created_at
from {{ ref('stg_postgres__users') }} u
  left join {{ ref('stg_postgres__addresses') }} a
    on u.address_id = a.address_id
  