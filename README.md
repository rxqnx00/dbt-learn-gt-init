# dbt_fundamentals

My project for following along with the [dbt Learn](https://learn.getdbt.com/) Fundamentals course, using the Jaffle Shop dataset and DuckDB.

## What's here

- `models/stg_jaffle_shop__customers.sql`: staging model for customers
- `models/stg_jaffle_shop__orders.sql`: staging model for orders
- `models/customers.sql`: customer-level model built from the staging models

## Running it

```bash
pip install dbt-core dbt-duckdb
dbt run
```

## Notes

This is a learning project, not production code.