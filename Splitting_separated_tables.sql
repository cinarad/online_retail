CREATE TABLE customer AS
SELECT DISTINCT
	customer_id,
	customer_name,
	country
FROM sales;

SELECT *
FROM customer LIMIT 10;

SELECT DISTINCT customer_id
FROM customer
ORDER BY customer_id;
----

CREATE TABLE product AS
SELECT DISTINCT
	product_id,
	category,
	unit_price
FROM sales;

SELECT *
FROM product LIMIT 5;

----

CREATE TABLE invoice AS
SELECT
	invoice_id,
	invoice_date,
	customer_id,
	product_id,
	quantity,
	payment_method,
	return_status,
	review_score,
	promo,
	delivery_days,
	shipping_cost,
	total
FROM sales;

SELECT *
FROM invoice LIMIT 5;

--- Add Primary Keys
ALTER TABLE customer ADD PRIMARY KEY (customer_id);
ALTER TABLE product ADD PRIMARY KEY (product_id);
ALTER TABLE invoice ADD PRIMARY KEY (invoice_id);



	

