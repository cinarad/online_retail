-- Check Nulls
SELECT 
  COUNT(*) AS total_rows,
   COUNT(*) - COUNT(invoice_id)      AS invoice_id_nulls,
  COUNT(*) - COUNT(invoice_date)    AS invoice_date_nulls,
  COUNT(*) - COUNT(customer_id)     AS customer_id_nulls,
  COUNT(*) - COUNT(customer_name)   AS customer_name_nulls,
  COUNT(*) - COUNT(country)         AS country_nulls,
  COUNT(*) - COUNT(product_id)      AS product_id_nulls,
  COUNT(*) - COUNT(product_name)    AS product_name_nulls,
  COUNT(*) - COUNT(category)        AS category_nulls,
  COUNT(*) - COUNT(quantity)        AS quantity_nulls,
  COUNT(*) - COUNT(unit_price)      AS unit_price_nulls,
  COUNT(*) - COUNT(total)           AS total_nulls,
  COUNT(*) - COUNT(payment_method)  AS payment_method_nulls,
  COUNT(*) - COUNT(return_status)   AS return_status_nulls,
  COUNT(*) - COUNT(review_score)    AS review_score_nulls,
  COUNT(*) - COUNT(promo)           AS promo_nulls,
  COUNT(*) - COUNT(delivery_days)   AS delivery_days_nulls,
  COUNT(*) - COUNT(shipping_cost)   AS shipping_cost_nulls
FROM sales;

-- Recovering the customer names missing:
UPDATE sales s
SET customer_name = c.customer_name
FROM (
	SELECT customer_id, MAX(customer_name) AS customer_name
	FROM sales
	WHERE customer_name IS NOT NULL
	GROUP BY customer_id
) c
WHERE s.customer_name IS NULL AND s.customer_id = c.customer_id;

SELECT COUNT(*) AS missing_customer_names
FROM sales
WHERE customer_name IS NULL;

-- Handle review_score NULLS: Imput with average
UPDATE sales
SET review_score = sub.avg_score
FROM(
	SELECT AVG(review_score) AS avg_score
	FROM sales
	WHERE review_score IS NOT NULL
) sub
WHERE review_score IS NULL;

SELECT COUNT(*) AS missing_review_score
FROM sales
WHERE review_score IS NULL;

-- Handle delivery_days NULLS: Imput with average
UPDATE sales
SET delivery_days = sub.avg_delivery
FROM(
	SELECT AVG(delivery_days) AS avg_delivery
	FROM sales
	WHERE delivery_days IS NOT NULL
) sub
WHERE delivery_days IS NULL;

SELECT COUNT(*) AS missing_delivery_days
FROM sales
WHERE delivery_days IS NULL;

