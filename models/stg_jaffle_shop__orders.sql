select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from {{ ref('raw_orders') }} 
    -- The raw_orders table is a raw data source that contains information about customer orders.
    -- In this case, the raw_orders table is not presented in this repository, but it is assumed to exist in the data warehouse.