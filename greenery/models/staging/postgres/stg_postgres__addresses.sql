with 

source as (
  select * from {{ source('postgres', 'addresses') }}
),

addresses as (
  select
    address_id,
    address as street_address,
    lpad(zipcode, 5, 0)::varchar(256) zipcode,
    state,
    country
  from source
)

select * from addresses
  