-- Task 1 - Creating tables for customers & orders 
drop table if exists customers;
drop table if exists orders;

create table customers (
 id int primary key auto_increment,
 first_name varchar(50),
 last_name varchar(50)
);

create table orders (
 id int primary key,
 customer_id int null,
 order_date date,
 total_amount decimal(10, 2),
 foreign key (customer_id) references customers(id)
);

-- Task 2 - Inserting data into customers table and orders table
insert into customers (id, first_name, last_name, email) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');


insert into orders (id, customer_id, order_date, total_amount) values
(1, '2023-01-01', 100.00),
(1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

-- Task 3 - Viewing both tables 
SELECT * FROM customers;
SELECT * FROM orders;

-- Task 3 - Filter orders with GROUP BY & Aggregate function (SUM())
SELECT customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- Task 4 - Filter orders with GROUP BY & WHERE & HAVING clauses
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount >= 200
GROUP BY customer_id;

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 200;

-- NOTE: Alternate code gives the same outcome
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200; 

-- Task 4 - Using INNER JOINs to combine two tables 
SELECT orders.id, customers.first_name, customers.last_name,
orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- Task 5 - Using LEFT JOINs to combine two tables 
SELECT orders.id, customers.first_name, customers.last_name,
orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- Task 6 - Using Scalar Subqueries to filter table
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >=(SELECT AVG(total_amount) FROM orders);

-- Task 7 - Using Column Subqueries to filter table
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

-- Task 8 - Using Table Subqueries to filter table
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS
order_summary;