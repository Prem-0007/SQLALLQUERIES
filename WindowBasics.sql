-- rather than GROUP BY, window functions return every row after grouping
-- not like GROUP BY

-- GROUP BY => Simple Aggregations, simple data analysis 
-- WINDOW => Aggregations + keep details, advanced data analysis


/*
GROUP BY => (Aggregate Functions) => COUNT(), SUM(), AVG(), MAX(), MIN()

WINDOW => (Aggregate Functions) => COUNT(), SUM(), AVG(), MAX(), MIN()
          (Rank Functions) => ROW_NUMBER(), RANK(), DENSE_RANK(), CUME_DIST(), PERCENT_RANK(), NTILE()
          (Value Functions) => LEAD(), LAG(), FIRST_VALUE()

*/


-- find the total sales across all orders

SELECT 
SUM(Sales) TotalSales 
FROM Sales.orders



-- find the total sales across for each product


SELECT 
ProductID,
SUM(Sales) TotalSales 
FROM Sales.orders
GROUP BY ProductID


-- find the total sales across for each product
-- additionally provide details such order id & order date

SELECT 
OrderID,
OrderDate,
ProductID,
SUM(Sales) TotalSales
FROM Sales.orders
GROUP BY 
OrderID,
OrderDate,
ProductID


-- using  window functions

SELECT
OrderId,
OrderDate,
ProductID,
  SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders



/*
-- window syntax 

window function          OVER clause
       f(x)           partiton      order      frame
                       clause       clause     clause

                       */

   -- AVG(Sales) OVER (PARTITION BY Category ORDER BY OrderDate ROWS UNBOUNDED PRECEDING )

   -- window functions perform calculations within a window
/*

Empty  => RANK() OVER ( ORDER BY OrderDate) 

column => AVG(Sales) OVER (ORDER BY OrderDate)

Number => NTEIL(2) OVER (ORDER BY OrderDate)

Multiple Arguments => LEAD(Sales,2,100) OVER (ORDER BY OrderDate)

Conditional Logic => SUM(CASE WHEN Sales > 100 THEN 1 ELSE 0 END) OVER (ORDER BY OrderDate)

*/
   -- PARTITION BY : - Divides the result set into partition (windows)
    --- it divides the rows into groups based on the columns




--Find the total sales across all orders

SELECT
OrderID,
OrderDate,
SUM(Sales) OVER() total_sales
FROM Sales.Orders



--Find the total sales for each product
-- additionally provide details such as order id & order date


SELECT
OrderID,
OrderDate,
ProductID,
OrderStatus
Sales,
SUM(Sales) OVER() total_sales,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders


--- ORDER BY : - IT is must  for rank functions and value functions

-- ex:- RANK() OVER (PARTITION BY Month  ORDER BY Sales DESC)





-- Rank each order based on their sales from highest to lowest
-- additionally provide details such as order id & order date

SELECT
OrderID,
OrderDate,
Sales,
RANK() OVER( ORDER BY SALES DESC) RankSales
FROM Sales.Orders



-- frame clause :- defines a subset of rows within each window that is relevant for the calculation
/*
-- AVG(Sales) OVER (PARTITION BY Category ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
                                                               ||             ||                 ||
                                                              ROWS        CURRENT ROW         CURRENT ROW
                                                              RANGE       N PRECEDING         N FOLLOWING
                                                                      UNBOUNDED PRECEDING    UNBOUNDED FOLLOWING 

   Frame clause can be used only with order by clause

   lower value must be before the higher value
*/

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

SELECT * FROM Sales.Orders



SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) TotalSales
FROM Sales.Orders

---- IS SAME AS

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS 2 PRECEDING ) TotalSales
FROM Sales.Orders
SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS UNBOUNDED  PRECEDING ) TotalSales
FROM Sales.Orders


-- SHORTCUT IS ONLY FROM PRECEDING NOT FOR FOLLOWING

-- SQL USES default frame if order by is used without frame

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED  PRECEDING AND CURRENT ROW ) TotalSales
FROM Sales.Orders

--- IS SAME AS

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS UNBOUNDED  PRECEDING ) TotalSales
FROM Sales.Orders

--- IS SAME AS

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) TotalSales
FROM Sales.Orders





--- ORDER BY REQUIRED FOR A FRAME

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders


/*

-- WINDOW FUNCTIONS 4x RULES
*/
-- #1  window funtions can be used only in SELECT and ORDER BY Clauses


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus) DESC



-- NOTE:- WINDOW functions can't be used to filter data


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE SUM(Sales) OVER(PARTITION BY OrderStatus) > 100 -- ERROR

-- #2 RULE :- NESTING Window Functions is not allowed !!



SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(SUM(Sales) OVER(PARTITION BY OrderStatus)) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders

-- #3 RULE : - SQL execute Window funtions after WHERE clause


-- Find the total sales for each order status, only for two products 101 and 102

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)


-- #4 RULE :- Window functions can be used together with GROUP BY in the same query,
-- ONLY if the same columns are used

-- RANK customers based on their sales


SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID


/* ERROR

SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY Sales DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID

*/


SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY CustomerID DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID



