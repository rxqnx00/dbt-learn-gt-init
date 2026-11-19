-- stg: in the file name indicates that this is a staging model. 
-- Staging models are used to clean and prepare raw data for further transformations. 
-- They typically perform tasks such as renaming columns, 
-- changing data types, and filtering out unnecessary data.

select
    id as customer_id,
    first_name,
    last_name

from {{ source('jaffle_shop', 'customers') }}