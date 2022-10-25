# Week 3 Project
- Christian Normand

## Question 1
What is our overall conversion rate?

```sql
-- There's a better way to do this but oh well
select
  round(sum((products_ordered > 0)::int) / count(*), 4) as overall_conversion_rate
from (
  select
    session_id,
    sum(was_product_ordered::int) as products_ordered
  from int_product_interactions_by_session
  group by session_id
)
```

**Answer:** The overall conversion rate is 62%.

## Question 2
What is our conversion rate by product?

**Answer:** I have a model for this! Check out `fct_product_conversion_rates`.