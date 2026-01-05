create or replace view dev.silver.dim_store as
select
  store_sk,
  store_id,
  name as store_name,
  upper(region) as region,
  channel_type as channel
from
  dev.bronze.dim_store