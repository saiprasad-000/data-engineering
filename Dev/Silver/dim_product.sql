Create or replace view dev.silver.dim_product as
select
  product_sk,
  product_id,
  category,
  brand,
  name as sub_category,
  model as model_name,
  currency,
  Price,
  gst_rate,
  price_incl_gst
from
  dev.bronze.dim_product
where
  is_current = true
  and effective_from >= '2026-01-01';