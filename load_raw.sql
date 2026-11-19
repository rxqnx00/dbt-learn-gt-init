create schema if not exists jaffle_shop;
create schema if not exists stripe;

create or replace table jaffle_shop.customers as
  select * from read_csv('https://dbt-tutorial-public.s3.amazonaws.com/jaffle_shop_customers.csv');

create or replace table jaffle_shop.orders as
  select *, current_timestamp as _etl_loaded_at
  from read_csv('https://dbt-tutorial-public.s3.amazonaws.com/jaffle_shop_orders.csv');

create or replace table stripe.payment as
  select * from read_csv('https://dbt-tutorial-public.s3.amazonaws.com/stripe_payments.csv');