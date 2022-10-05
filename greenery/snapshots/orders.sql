{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='dbt_ctnormand1',
      unique_key='order_id',
      strategy='check',
      check_cols=['status']
    )
  }}

  select * from {{ source('postgres', 'orders') }}

{% endsnapshot %}
