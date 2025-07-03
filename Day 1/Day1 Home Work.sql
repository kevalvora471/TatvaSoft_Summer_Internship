CREATE TABLE customers (
   customer_id SERIAL PRIMARY KEY, 
   first_name VARCHAR(20) NOT NULL, 
   last_name VARCHAR(20) NOT NULL, 
   email VARCHAR(50) UNIQUE NOT NULL,
   created_date TIMESTAMPTZ NOT NULL DEFAULT NOW()
);



ALTER TABLE customers ADD COLUMN active BOOLEAN;
ALTER TABLE customers DROP COLUMN active;



INSERT INTO customers (first_name, last_name, email, active) VALUES
  ('John', 'Doe', 'johndoe@example.com', true),
  ('Alice', 'Smith', 'alicesmith@example.com', true),
  ('Bob', 'Johnson', 'bjohnson@example.com', true),
  ('Emma', 'Brown', 'emmabrown@example.com', true),
  ('Michael', 'Lee', 'michaellee@example.com', false),
  ('Sarah', 'Wilson', 'sarahwilson@example.com', true),
  ('David', 'Clark', 'davidclark@example.com', true);



CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
	order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	order_number VARCHAR(50) NOT NULL,
	order_amount DECIMAL(10,2) NOT NULL
);



INSERT INTO orders (customer_id, order_date, order_number, order_amount) VALUES
  (1, '2024-01-01', 'ORD001', 50.00),
  (2, '2024-01-01', 'ORD002', 35.75),
  (3, '2024-01-01', 'ORD003', 100.00),
  (4, '2024-01-01', 'ORD004', 30.25),
  (5, '2024-01-01', 'ORD005', 90.75),
  (6, '2024-01-01', 'ORD006', 25.50),
  (7, '2024-01-01', 'ORD007', 60.00);


select * from customers;

select * from orders;

SELECT first_name, last_name, email FROM customers;

SELECT first_name, last_name, email FROM customers WHERE first_name = 'Bob';

SELECT first_name, last_name, email FROM customers WHERE first_name IN ('Emma','Abhi','David');

SELECT first_name, last_name, email FROM customers WHERE first_name LIKE '%av%';

SELECT first_name, last_name, email FROM customers WHERE first_name ILIKE '%av%';



SELECT first_name, last_name, email FROM customers ORDER BY first_name ASC;
SELECT first_name, last_name FROM customers ORDER BY last_name DESC;



SELECT * FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id;
SELECT * FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;
SELECT * FROM customers AS c RIGHT JOIN orders AS o ON c.customer_id = o.customer_id;



SELECT c.customer_id, c.first_name, c.last_name, c.email,
COUNT(o.order_id) AS No_Orders,
SUM(o.order_amount) AS Total
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id; 




SELECT c.customer_id, c.first_name, c.last_name, c.email,
COUNT(o.order_id) AS No_Orders,
SUM(o.order_amount) AS Total
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 1;



SELECT * FROM orders WHERE customer_id IN (
  SELECT customer_id FROM customers WHERE active = true
);

SELECT customer_id, first_name, last_name, email
FROM customers
WHERE EXISTS (
  SELECT * FROM orders WHERE orders.customer_id = customers.customer_id
);


UPDATE customers
SET first_name = 'Anil', last_name = 'Oberoi', email = 'anil.oberoi@gmail.com'
WHERE customer_id = 1;


select * from customers;
select * from orders;


DELETE FROM customers WHERE customer_id = 10;





