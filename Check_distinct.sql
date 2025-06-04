SELECT *
FROM sales;

--- standardise names and countries by removing extra spaces, converting to consistent case
UPDATE sales
SET
	customer_name = INITCAP(TRIM(customer_name)),  -- e.g., "john smith" → "John Smith"
	country = INITCAP(TRIM(country));               -- e.g., " new zealand  " → "New Zealand"

--- Check distinct name-country:
SELECT DISTINCT country
FROM sales
ORDER BY country;

--- Found inconsistent country names,fixing it:
UPDATE sales
SET country = REPLACE(
				REPLACE(
					REPLACE(country, 'Usa', 'United States'),
					'U.S.', 'United States'
					),
					'Uk', 'United Kingdom'
					);

--- Check distinct customer_id\:
SELECT DISTINCT customer_id
FROM customer
ORDER BY customer_id;

--- Check distinct customer_name:
SELECT DISTINCT customer_name
FROM customer
ORDER BY customer_name;

--- check distinct invoice_id
SELECT DISTINCT invoice_id
FROM sales
ORDER BY invoice_id;

--- check distinct customer_name
SELECT customer_id, customer_name
FROM sales
GROUP BY customer_id, customer_name
ORDER BY customer_id;



-- Summary Stats for numeric columns:
SELECT 
	MIN(review_score), MAX(review_score), AVG(review_score), STDDEV(review_score),
	MIN(delivery_days), MAX(delivery_days), AVG(delivery_days),
	MIN(shipping_cost), MAX(shipping_cost), AVG(shipping_cost),
	MIN(total), MAX(total), AVG(total), AVG(total)
FROM sales;


