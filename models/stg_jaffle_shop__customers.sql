-- stg: in the file name indicates that this is a staging model. 
-- Staging models are used to clean and prepare raw data for further transformations. 
-- They typically perform tasks such as renaming columns, 
-- changing data types, and filtering out unnecessary data.

select
        id as customer_id,
        first_name,
        last_name

    from {{ ref('raw_customers') }}
    -- The raw_customers table is a raw data source that contains information about customer orders.
    -- In this case, the raw_customers table is not presented in this repository, but it is assumed to exist in the data warehouse.