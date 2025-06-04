SELECT *
FROM sales LIMIT 20;

-- removeing "$"
-- Display numeric values with 2 decimal places using ROUND()
SELECT 
  ROUND(REGEXP_REPLACE(unit_price, '[^0-9\.]', '', 'g')::NUMERIC, 2) AS unit_price_clean,
  ROUND(review_score::NUMERIC, 2) AS review_score,
  ROUND(delivery_days::NUMERIC, 2) AS delivery_days,
  ROUND(shipping_cost::NUMERIC, 2) AS shipping_cost,
  ROUND(total::NUMERIC, 2) AS total
FROM sales;

-- Summary Stats for numeric columns:
SELECT 
	MIN(review_score), MAX(review_score), AVG(review_score), STDDEV(review_score),
	MIN(delivery_days), MAX(delivery_days), AVG(delivery_days),
	MIN(shipping_cost), MAX(shipping_cost), AVG(shipping_cost),
	MIN(total), MAX(total), AVG(total), AVG(total)
FROM sales;


--- DATE EXPLORATION
-- Invoice range
SELECT MIN(invoice_date), MAX(invoice_date) 
FROM sales;

-- Monthly sales
SELECT DATE_TRUNC('month', invoice_date) AS month, COUNT(*) AS invoice_count
FROM sales
GROUP BY month
ORDER BY invoice_count DESC;

-- 	TOTAL REVENUE
SELECT TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS total_revenue
FROM sales

-- TOTAL 10 PRODUCT BY REVENUE
SELECT product_name, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

-- TOTAL CATEGORY BY REVENUE
SELECT category, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS category_revenue
FROM sales
GROUP BY category
ORDER BY category_revenue DESC;


--- TIME SERIES ANALYSIS (HOW SALES CHANGE OVER TIME)
-- Monthly revenue trend
SELECT DATE_TRUNC('month', invoice_date) AS month, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS revenue
FROM sales
GROUP BY month
ORDER BY month;


--- CUSTOMER SEGMENTATION
--Revenue by country
SELECT country, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS revenue
FROM sales
GROUP BY country
ORDER BY revenue DESC;

-- Top customers by lifetime value
SELECT customer_id, customer_name, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS total_spent
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;


--- CREATE VIEWS OR MATERIALIZED VIEWS
CREATE VIEW customer_lifetime_value AS
SELECT customer_id, customer_name, TO_CHAR(SUM(total), 'FM999,999,999,999.00') AS total_spent
FROM sales
GROUP BY customer_id, customer_name;

-- Check for NULLs in critical fields
SELECT COUNT(*) FROM sales WHERE invoice_id IS NULL OR total IS NULL;

-- Check for negative or suspicious values
SELECT * FROM sales WHERE quantity < 0 OR total < 0;


--- INDEXING & OPTIMIZATION
-- Add index to speed up lookups:
CREATE INDEX idx_sales_customer_id
ON sales(customer_id);

-- List indexes on the "sales" table
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'sales';

EXPLAIN ANALYZE
SELECT * FROM sales
WHERE customer_id = 'CUST1001';

