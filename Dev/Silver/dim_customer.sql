Create or replace view dev.silver.dim_customer as
select
  customer_sk,
  customer_id,
  customer_segment,
  first_name,
  last_name,
  Name,
  email,
  city,
  state,
  country,
  is_current
from
  dev.bronze.dim_customer
where
  is_current = True
  and effective_from >= '2026-01-01';