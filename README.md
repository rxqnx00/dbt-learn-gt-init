# dbt Fundamentals: Jaffle Shop

My work from the [dbt Learn](https://learn.getdbt.com/) Fundamentals course. It takes the raw Jaffle Shop data (customers, orders, payments), loads it into a local DuckDB database, and transforms it with dbt into a clean customer dimension table.

**Stack:** dbt Core · DuckDB · SQL · Jinja

## Project structure

```
models/
├── staging/
│   ├── _src_jaffle_shop.yml           # source definitions + freshness checks
│   ├── stg_jaffle_shop__customers.sql # renames and cleans raw customers
│   └── stg_jaffle_shop__orders.sql    # renames and cleans raw orders
└── marts/
    └── dim_customers.sql              # one row per customer with order history
load_raw.sql                           # loads the raw CSVs into DuckDB
```

### How the models fit together

```
source: jaffle_shop.customers ──► stg_jaffle_shop__customers ──┐
                                                               ├──► dim_customers
source: jaffle_shop.orders ─────► stg_jaffle_shop__orders ─────┘
```

- **Staging (views):** one model per source table. These handle light cleanup like renaming `id` to `customer_id` and `user_id` to `customer_id`, so every downstream model uses consistent keys.
- **Marts (tables):** `dim_customers` joins customers to their aggregated orders and adds `first_order_date`, `most_recent_order_date`, and `number_of_orders`. Customers with no orders get 0 instead of null.

Materializations are set per folder in `dbt_project.yml`, so staging stays lightweight and marts are built as tables for querying.

## What I practiced

- Declaring **sources** and referencing them with `source()` instead of hardcoding table names
- Building a DAG with `ref()` so dbt handles dependency order
- Organizing a project into **staging and marts** layers
- Configuring **source freshness** on `orders` (warn after 24 hours, error after 48) using an `_etl_loaded_at` timestamp
- Installing packages (`dbt-labs/codegen`) to generate boilerplate YAML and models

## Running it locally

**1. Install dbt with the DuckDB adapter**

```bash
pip install dbt-core dbt-duckdb
```

**2. Add a profile** to `~/.dbt/profiles.yml`

```yaml
jaffle_shop:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: dev.duckdb
```

**3. Load the raw data** (pulls the course CSVs into `dev.duckdb`)

```bash
duckdb dev.duckdb < load_raw.sql
```

**4. Install packages, check freshness, and build**

```bash
dbt deps
dbt source freshness
dbt run
```

## Up next

- Add generic tests (`unique`, `not_null`, `relationships`) and model documentation
- Stage the Stripe payments data and add a `fct_orders` model
- Generate and publish the dbt docs site

---

*This is a learning project built while working through the course, not production code.*
