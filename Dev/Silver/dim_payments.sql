Create or replace view dev.silver.dim_payments as
select
  surrogate_key as payment_sk,
  payment_id,
  method,
  status,
  provider as payment_platform
from
  dev.bronze.dim_payments