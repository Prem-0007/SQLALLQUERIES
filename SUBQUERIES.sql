--- SUBQUERIES

-- JOIN TABLES => FILTERING => TRANSFORMATIONS => AGGREGATIONS
-- each of them are subqueries
-- main query => ouer query
-- sub query => inner query


/*
--- CATEGORIES 
-- Non-correlated subquery
-- correlated subquery
*/


/*
Result Types
Scalar subquery
Row subquery
Table subquery
*/

/*
location clauses :- SELECT , FROM , JOIN , WHERE => COMPARISION & LOGICAL
COMPARISION =>   <, <= , >, >= , = , <> , !=
LOGICAL => IN, ANY, ALL, EXISTS

*/



--- RESULT TYPES

-- SCALAR QUERY

SELECT
AVG(Sales)
FROM Sales.Orders

-- ROW QUERY

SELECT
CustomerID
FROM Sales.Orders

-- TABLE QUERY

SELECT
OrderID,
OrderDate
FROM Sales.Orders





--- LOCATIONS  ----
/*



-- FROM CLAUSE
=> Used as temporary table for main query

SELECT column1, column2,... 
FROM (SELECT column FROM table1 WHERE condition) AS alias
*/


-- Find the products that have a price higher than the
-- average price of all products

--main query
SELECT 
* 
FROM
-- sub query
	(
	SELECT 
	ProductID,Price,
	AVG(Price) OVER() avgPrice
	FROM 
	Sales.Products)t 
WHERE Price >  avgPrice 


-- Rank customers based on their total amount of sales
-- main query
SELECT 
*,
RANK() OVER(ORDER BY total_sales DESC) CustomerRank
FROM
-- sub query 
(
SELECT 
CustomerID,
SUM(Sales)  total_sales
FROM Sales.Orders
GROUP BY CustomerID)t


/*
-- SELECT CLAUSE


SELECT column1, ----> main query
(SELECT column FROM table1 WHERE condition ) AS alias  ---> sub query
FROM table1
*/

-- Show the productIDS, names, prices and total number of orders


-- main query
SELECT ProductID  ,Product, Price, 
-- sub query
(SELECT COUNT(*) 
FROM Sales.Orders
) TotalOrders
FROM Sales.Products


----- JOIN CLAUSE

-- Show all customer details and find the total orders for each customer

SELECT c.*,
o.TotalOrders
FROM Sales.Customers c 
LEFT JOIN(
SELECT 
CustomerID ,
COUNT(*) TotalOrders
FROM Sales.Orders 
GROUP BY CustomerID) O
ON c.CustomerID = o.CustomerID



-- WHERE CLAUSE

SELECT
* 
FROM Sales.Orders
WHERE Sales> 54


/*
-- WHERE Sales = (SELECT AVG(Sales) FROM ORDERS)
-- Similarly for all operators > , < , >= , .....


SELECT column1, column2,...
FROM table1 
WHERE column WHERE Sales = (SELECT column FROM table2 WHERE condition)

-- only scalar subqueries are allowed
*/


-- Find the products that have a price higher 
-- than the average of all products


-- Main query
	
	SELECT 
	ProductID,Price,
(SELECT AVG(Price) FROM Sales.Products) AvgPrice
	FROM 
	Sales.Products 
WHERE Price >  (SELECT AVG(Price) FROM Sales.Products) 


--- IN operator

/*
SELECT colimn1, column2,...
FROM table1
WHERE column IN(SELECT column FROM table2 WHERE condition)
*/

-- Show the details of orders made by customers in Germany

SELECT * FROM Sales.Orders
WHERE CustomerID IN (
SELECT 
CustomerID FROM Sales.Customers WHERE Country = 'Germany')



-- Show the details of orders made by customers who are not in Germany


SELECT * FROM Sales.Orders
WHERE CustomerID NOT IN (
SELECT 
CustomerID FROM Sales.Customers WHERE Country = 'Germany')


---- ANY | ALL

-- Find female employess whose salaries are greater
-- than the salaries of any male employees
-- Main Query
SELECT
EmployeeID,
FirstName,
Gender,
Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY(
SELECT Salary FROM Sales.Employees
WHERE Gender = 'M')



--- ALL Operator

-- Find female employess whose salaries are greater
-- than the salaries of all male employees

SELECT
EmployeeID,
FirstName,
Gender,
Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL(
SELECT Salary FROM Sales.Employees
WHERE Gender = 'M')



---- Depandancy ----
--- NON-Correlated | Correlated SubQueries
-- NON-Correlated
-- a subquery that can run independently from the main query
-- executed once and its result is used by the main query 
-- easier to read
-- executed only once leads to better performance 
-- static comparisions, filtering with constants


-- Correlated 
-- a subquery that relays on values from the main query
-- executed for each row processed by the main query  can't be executed on it's own
-- Harder to read and more complex
-- Executed multiple times leads to bad performance
-- ROW-by-Row Comparisions, Dynamic Filtering


-- show all customer details and find the 
-- total orders for each customer

SELECT 
*,
(SELECT  COUNT(*) FROM Sales.Orders o WHERE o.CustomerID= c.CustomerID)  TotalSales
FROM Sales.Customers c



---- EXISTS OPERATOR ----
/*
SELECT column1, column2,...
FROM Table2
WHERE EXISTS ( Select 1
               FROM Table1
			   WHERE Table1.ID = Table2.ID)
*/

-- run subquery for each row in main query


-- show the details of orders made by customers in Germany
-- Main QUERY

SELECT 
*
FROM Sales.Orders O
WHERE EXISTS( SELECT 
              1 FROM Sales.Customers C
              WHERE Country = 'Germany'
			  AND o.CustomerID = c.CustomerID) 

-- show the details of orders made by customers not in Germany

SELECT 
*
FROM Sales.Orders O
WHERE NOT EXISTS( SELECT 
              1 FROM Sales.Customers C
              WHERE Country = 'Germany'
			  AND o.CustomerID = c.CustomerID) 