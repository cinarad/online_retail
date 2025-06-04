--- List primary Keys
--- Add primary key to customer table
ALTER TABLE customer
ADD CONSTRAINT pk_customer
PRIMARY KEY (customer_id);

--- found duplicate:
SELECT customer_id, COUNT(*)
FROM customer
GROUP BY customer_id
HAVING COUNT(*) > 1;

DELETE FROM customer a
USING customer b
WHERE a.ctid < b.ctid
  AND a.customer_id = b.customer_id;

--- Add primary key to product table
ALTER TABLE product
ADD CONSTRAINT pk_product
PRIMARY KEY (product_id);


--  FOREIGN KEYS in all tables in public schema
-- Ensure customer must exist
-- Add foreign key to customer_id
ALTER TABLE invoice
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);

-- Add foreign key to product_id
ALTER TABLE invoice
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES product(product_id);

