Create or replace view dev.silver.dim_date as
select
  date_sk,
  day,
  week,
  month,
  year,
  quarter,
  is_weekend
from
  dev.bronze.dim_date
where
  date >= '2026-01-01'