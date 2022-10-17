# Week 2 Project
- Christian Normand

## Question 1
What is our user repeat rate?<br>
*Repeat Rate = Users who purchased 2 or more times / users who purchased*

```sql
with count_orders_by_user as (
  select user_id, count(*) count_orders
  from stg_postgres__orders
  group by user_id
)
select 
  sum((count_orders = 1)::int) one_time_purchasers,
  sum((count_orders > 1)::int) repeat_purchasers,
  round(repeat_purchasers / (repeat_purchasers + one_time_purchasers), 2) repeat_rate
from count_orders_by_user
```

**Answer:**
| one_time_purchasers | repeat_purchasers | repeat_rate |
| ------------------- | ----------------- | ----------- |
| 25                  | 99                | 0.8         |

## Question 2
What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

**Answer:**
- What item(s) did the user previously purchase?
- How much time did the user spend on our site?
- What item(s) did the user add to their shopping cart?
- Did the user leave a review?
- What information can we get about the user's location from the shipping address?

## Question 3
What assumptions are you making about each model? (i.e. why are you adding each test?)

**Answer:**
I added `not_null` and/or `unique` tests on the `id` columns in my staging model. Although it's unlikely to happen, failures on these tests would indicate a problem with the data early in the pipeline. If I had more time, I would add more tests, but it's been a busy week.

## Question 4
Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

**Answer:**
I did not find any problems with the `id` columns in my staging model. However, there are plenty of additional tests I could add to other models, and those might uncover some weird data.

## Question 5
Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

**Answer:**
The entire test suite will run every time the model is updated (I'm sure this is configurable in dbt). If there's any data weirdness, we can program a test to catch it and alert the engineering team.

## Question 6:
Which orders changed from week 1 to week 2? 

**Answer:**
I dropped my entire schema to clean up unused models in Snowflake. This worked great, but I accidentally dropped my snapshots as well... whoops, lesson learned I guess.

