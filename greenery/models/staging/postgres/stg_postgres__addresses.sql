select
  address_id,
  address,
  lpad(zipcode::varchar(5), 5, 0) zipcode,
  state,
  country
from {{ source('postgres', 'addresses') }}
  