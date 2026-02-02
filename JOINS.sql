/ *********** JOINS *********/

------  NO JOIN -----

-- RETRIEVE  all data from customers and orders as seperate results


SELECT * FROM customers;

SELECT * FROM  orders;

---- INNER JOIN ------


-- GET all customers along with their orders but only for customers who have placed an order




SELECT *
FROM customers
INNER JOIN orders
on customers.id = orders.customer_id;




SELECT 
    customers.id,
    customers.first_name,
    orders.order_id,
    orders.sales
FROM customers
INNER JOIN orders
on customers.id = orders.customer_id;





-- aliases (AS)

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
on c.id = o.customer_id;

 -- IS SAME AS (ORDER DOESNT NEED TO BE)

 SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM  orders AS o
INNER JOIN customers AS c 
on c.id = o.customer_id;


-----  LEFT JOIN ------


-- GET all customers along with their orders including those without orders



SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM  customers AS c 
LEFT JOIN orders AS o
on c.id = o.customer_id;


-- RIGHT JOIN -------

-- GET all customers with their orders including those without matching customers



SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM  customers AS c 
RIGHT JOIN orders AS o
on c.id = o.customer_id;


-- is same as  (LEFT JOIN change the order of tables)

SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM  orders AS o
LEFT JOIN  customers AS c 
on c.id = o.customer_id;


--- FULL JOIN -----

-- GET  all customers and all orders even if theres no match


SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM  orders AS o
FULL JOIN  customers AS c 
on c.id = o.customer_id;


-- is same as 


SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
FULL JOIN orders AS o
on c.id = o.customer_id;


----- LEFT ANTI JOIN ------

-- GET  all customers who haven't placed any order


SELECT 
    *
FROM customers AS c
LEFT JOIN orders AS o
on c.id = o.customer_id
WHERE o.customer_id IS NULL;


----- RIGHT ANTI JOIN ------

-- GET  all orders without matching customers


SELECT 
    *
FROM customers AS c
RIGHT JOIN  orders AS o 
on c.id = o.customer_id
WHERE c.id IS NULL;


-- is same as  (USING LEFT JOIN)
 

 
SELECT 
    *
FROM  orders AS o 
LEFT JOIN customers AS c
on c.id = o.customer_id
WHERE c.id IS NULL;


-- FULL ANTI JOIN ---

-- find customers without orders and orders without customers

SELECT 
    *
FROM  orders AS o 
FULL JOIN customers AS c
on c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

-- GET all customers along with their orders, but only 
-- for customers  who have placed an order without using INNER JOIN

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id= o.customer_id
WHERE o.customer_id IS NOT NULL;

-- CROSS JOIN 

-- generate all possible combinations of customers and orders 


SELECT *
FROM customers
CROSS JOIN orders;




