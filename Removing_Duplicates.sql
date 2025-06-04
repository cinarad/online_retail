--- CHECKING FOR DUPLICATES
--- Find duplicate customer names with different IDs:
SELECT customer_name, COUNT(DISTINCT customer_id) AS id_count
FROM sales
GROUP BY customer_name
HAVING COUNT(DISTINCT customer_id) > 1;

--- INVOICE ID:
SELECT invoice_id, COUNT(*) AS occurrences
FROM sales
GROUP BY invoice_id
HAVING COUNT(*) > 1;

--- CUSTOMER ID:
SELECT customer_id, COUNT(*) AS occurrences
FROM customer
GROUP BY customer_id
HAVING COUNT(*) > 1;

--- Check What’s Causing the Duplicates:
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
ORDER BY customer_id;

-- Check What Will Change Before Running:
SELECT sales.customer_id, sales.customer_name, sales.country AS old_country, customer.country AS new_country
FROM sales
JOIN customer ON sales.customer_id = customer.customer_id
WHERE sales.country IS DISTINCT FROM customer.country;

---  update the sales.country field by matching on customer_id or customer_name, 
-- and correcting any mismatches with the clean value from the customer table. Match by customer_id:
UPDATE sales
SET country = customer.country
FROM customer
WHERE sales.customer_id = customer.customer_id
	AND sales.country IS DISTINCT FROM customer.country;


--- Check product table for duplicates:
SELECT product_id, COUNT(*)
FROM product
GROUP BY product_id
HAVING COUNT(*) >1;


--- Check for Duplicate invoice_id in the invoice Table:
SELECT invoice_id, COUNT(*)
FROM invoice
GROUP BY invoice_id
HAVING COUNT(*) > 1;




