------- UPDATE ------



/*SELECT * 
FROM customers
*/

/*
UPDATE customers 
SET score = 0,
  country = 'Korea'
WHERE id = 6
*/

/*
INSERT INTO customers(id,first_name,country)
VALUES(8, 'USA', 'Max') ,(9,'Andreas','GERMANY'), (10,'Sahra','UK')

SELECT * 
FROM customers
*/

/*
UPDATE customers
SET score = 0
WHERE score IS NULL


SELECT * 
FROM customers
*/

---------- DELETE(DML)-----------

-- Delete all customers with an id > 5
/*

DELETE FROM customers
WHERE id > 5


SELECT * 
FROM customers
*/

-- delete all  data from table persons

 -- TRUNCATE TABLE persons

 /*
SELECT *
FROM persons
*/



---------- WHERE ----------

/*

= <> != > < <= >= AND OR NOT BETWEEN IN NOT IN LIKE 
*/
-- RETRIEVE ALL customers from germany

SELECT * FROM customers
WHERE country ='Germany'


-- RETRIEVE ALL customers from germany


SELECT * FROM customers
WHERE country <>'Germany'

-- RETRIEVE ALL customers with a score > 500


SELECT * FROM customers
WHERE score > 500

-- RETRIEVE ALL customers with a score of 500 or more


SELECT * FROM customers
WHERE score >= 500

-- RETRIEVE ALL customers with a score < 500


SELECT * FROM customers
WHERE score < 500

-- RETRIEVE ALL customers with a score of 500 or less


SELECT * FROM customers
WHERE score <= 500

-- RETRIEVE ALL customers who are from the USA AND have a score > 500

SELECT * FROM  customers
WHERE country ='USA' AND score > 500

-- RETRIEVE ALL customers who are from the USA or having a score > 500


SELECT * FROM  customers
WHERE country ='USA' OR score > 500

-- RETRIEVE ALL customers with a score not less than 500

SELECT * FROM customers 
WHERE  NOT score  < 500    --   ( >= 500 )


-- RETRIEVE ALL customers whose score fall in the range between 100 and 500


SELECT * FROM  customers
WHERE score BETWEEN 100 AND 500

-- is same as


SELECT * FROM  customers
WHERE score >= 100 AND score <= 500

 ---  IN OPERATOR ---


SELECT * FROM customers 
WHERE country IN ('Germany','USA')


--  IS SAME AS

SELECT * FROM customers
WHERE country = 'Germany' OR country ='USA'


-- NOT IN OPERATOR


SELECT * FROM customers 
WHERE country NOT IN ('Germany','USA')


-- LIKE OPERATOR

-- find all customers whose first name starts with 'M'

SELECT *
FROM customers
WHERE first_name LIKE 'M%'


-- find all customers whose first name ends with n

SELECT *
FROM customers
WHERE first_name LIKE '%n'

--find all customers whose first name contains 'r'



SELECT *
FROM customers
WHERE first_name LIKE '%r%'


--find all customers whose first name has 'r' in the third position 

SELECT *
FROM customers
WHERE first_name LIKE '__r%'

