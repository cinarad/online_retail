CREATE TABLE sales 
    (invoice_id TEXT,
	invoice_date TIMESTAMP,
	customer_id TEXT,
	customer_name TEXT,
	country TEXT,
	product_id TEXT,
	product_name TEXT,
	category TEXT,
	quantity INTEGER,
	unit_price TEXT,
	total NUMERIC,
	payment_method TEXT,
	return_status TEXT,
	review_score INTEGER,
	promo TEXT,
	delivery_days NUMERIC,
	shipping_cost NUMERIC
	);

SELECT *
FROM sales LIMIT 10;

