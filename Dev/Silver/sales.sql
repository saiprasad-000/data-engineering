CREATE OR REPLACE VIEW dev.silver.sales_transactions AS
WITH cust AS (
  SELECT
    customer_id
  FROM
    dev.silver.dim_customer
),
prod AS (
  SELECT
    product_id,
    CAST(price AS DECIMAL(18, 2)) AS list_price
  FROM
    dev.silver.dim_product
),
store AS (
  SELECT
    store_id
  FROM
    dev.silver.dim_store
),
pay AS (
  SELECT
    payment_id
  FROM
    dev.silver.dim_payments
),
dt AS (
  SELECT
    date
  FROM
    dev.silver.dim_date
  WHERE
    date BETWEEN DATE('2026-01-01') AND DATE('2026-12-31')
)
SELECT
  (
    concat_ws('|', c.customer_id, p.product_id, s.store_id, cast(d.date as string), pa.payment_id)
  ) AS order_line_id,
  (concat_ws('|', c.customer_id, cast(d.date as string))) AS order_id,
  c.customer_id,
  p.product_id,
  s.store_id,
  pa.payment_id,
  d.date AS order_date,
  CAST(1 + FLOOR(rand() * 4) AS INT) AS quantity,
  p.list_price AS unit_price,
  CAST((p.list_price * (1 + (rand() - 0.5) * 0.10)) AS DECIMAL(18, 2)) AS unit_price_effective, -- simulate slight variance
  CAST(quantity * unit_price_effective AS DECIMAL(18, 2)) AS gross_amount,
  CAST(gross_amount * 0.05 AS DECIMAL(18, 2)) AS discount_amount,
  CAST((gross_amount - discount_amount) AS DECIMAL(18, 2)) AS net_amount,
  CAST(net_amount * 0.18 AS DECIMAL(18, 2)) AS tax_amount,
  CAST((net_amount + tax_amount) AS DECIMAL(18, 2)) AS total_amount
FROM
  cust c CROSS JOIN prod p CROSS JOIN store s CROSS JOIN pay pa CROSS JOIN dt d
LIMIT 500;