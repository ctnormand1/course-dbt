# Week 1 Project
- Christian Normand
- Sunday, October 9, 2022

## Question 1
How many users do we have?
```sql
select 
  count(*)
from stg_postgress__users
```
**Answer:** We have 130 users.

## Question 2
On average, how many orders do we receive per hour?
```sql
select 
  round(
    count(*) / datediff('hour', min(created_at), max(created_at))
  ) avg_orders_per_hour
from stg_postgres__orders
```
**Answer:** On average, we receive about 8 orders per hour.

## Question 3
On average, how long does an order take from being placed to being delivered?
```sql
select 
  round(
    avg(datediff('hour', created_at, delivered_at)) / 24, 1
  ) avg_delivery_days
from stg_postgres__orders
where status = 'delivered'
```
**Answer:** On average, orders are delivered 3.9 days after they are placed.

## Question 4
How many users have only made one purchase? Two purchases? Three+ purchases?<br>
*Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.*
```sql
select 
  order_group,
  count(*) count_users
from (
  select
    case
      when count(*) > 2 then '3+'
      else count(*)::varchar(2)
    end order_group
  from stg_postgres__orders
  group by user_id
)
group by order_group
order by order_group
```
**Answer:**

| order_group | count_users |
| ----------- | ----------- |
| 1           | 25          |
| 2           | 28          |
| 3+          | 71          |

## Question 5
On average, how many unique sessions do we have per hour?
```sql
select
  round(avg(unique_sessions)) avg_sessions_per_hour
from (
  select
    date_trunc('hour', created_at) created_at_hour,
    count(distinct session_id) unique_sessions
  from stg_postgres__events
  group by created_at_hour
)
```
**Answer:** On average, we have 16 unique sessions per hour.