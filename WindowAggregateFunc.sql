-- Aggregate window functions

-- COUNT() => returns number of rows within a window


-- find the total number of orders

SELECT
COUNT(*) TotalOrders
FROM Sales.Orders


-- find the total number of orders
-- additionally provide details such order id & order date

SELECT
OrderID,
OrderDate,
Sales,
COUNT(*) OVER() TotalOrders
FROM Sales.Orders


-- find the total number of orders
-- find the total number of orders for each customers
-- additionally provide details such order id & order date

SELECT
OrderID,
OrderDate,
CustomerID,
Sales,
COUNT(*) OVER() TotalOrders,
COUNT(*) OVER(PARTITION BY CustomerID) ordersByCustomers
FROM Sales.Orders



-- Find the total number of customers
-- Additionally provide all customer Details

SELECT 
*,
COUNT(*) OVER() TotalCustomers
FROM Sales.Customers


-- Find the total number of customers
-- Find the total number of scores for the customers
-- Additionally provide all customer Details


SELECT 
*,
COUNT(*) OVER() TotalCustomersStar,
COUNT(1) OVER() TotalCustomersOne, 
COUNT(Score) OVER() TotalScore,
COUNT(Country) OVER() TotalCountries
FROM Sales.Customers


-- COUNT(*) = COUNT(1)
-- we can detect number of nulls by comparing to total number of rows
-- total customers - total sales = 1 so there is one null score value
-- total customers - total countries = 0 so there is no null country value
-- COUNT() can be used to identify duplicates


-- check whether the table 'Orders' contains any duplicate rows

SELECT 
OrderID,
COUNT(*) OVER (PARTITION BY OrderID) CheckPK
FROM 
Sales.Orders


SELECT * FROM (
SELECT
OrderID,
COUNT(*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive
)t
WHERE checkPK > 1


/*
-- COUNT || USE CASES
overall analysis
category analysis
quality checks: identify nulls
quality checks: identify duplicates
*/






----  SUM() :- returns the sum of values within a window

SELECT
OrderID,
OrderDate,
CustomerID,
Sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY productID) SalesByCustomers
FROM
Sales.Orders


--Find the percentage contribution of each products's sales to the total sales

SELECT
OrderID,
OrderDate,
CustomerID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS Float)/SUM(Sales) OVER() * 100,2 ) PercentageOfTotal
FROM
Sales.Orders;



--- AVG():- returns average of values for each window

-- find the average sales across all orders
-- and find the average sales for each product
-- additionally provide details such orderid, orderdate


SELECT
OrderID,
OrderDate,
CustomerID,
Sales,
AVG(Sales) OVER() AverageSales,
AVG(Sales) OVER(PARTITION BY ProductID ) AverageSalesByProduct
FROM
Sales.Orders;




-- find the average scores of customers
-- additionally provide details such as customer id and last name

SELECT
CustomerID,
LastName,
Score,
COALESCE(Score,0) AS withoutnullScore,
AVG(Score) OVER() AverageScore,
AVG(Score) OVER(PARTITION BY CustomerID ) AverageScoreByProduct,
AVG(COALESCE(Score,0)) OVER() AverageScoreWithoutNull,
AVG(COALESCE(Score,0)) OVER(PARTITION BY CustomerID ) AverageScoreByProductwithoutNULL
FROM
Sales.Customers;


-- find all orders where sales are higher than the average sales across all orders


SELECT
* FROM (
SELECT
OrderID,
ProductID,
Sales,
AVG(Sales) OVER() averageSales
FROM
Sales.Orders
)t
WHERE Sales > averageSales

-- helps to evaluate whether a value is above or below the average




--- MIN() & MAX()
-- Returns the lowest value within a window
--  Returns the highest value within a window




-- Find the highest & lowest sales across all orders
-- and the highest & lowest sales for each product
-- Aditionally, provide details such as order ID and Order date

SELECT 
OrderID,
OrderDate,
Sales,
ProductID,
MIN(Sales) OVER() LowestSale,
MIN(Sales) OVER(PARTITION BY ProductID) LowestSaleByProduct,
MAX(Sales) OVER() HighestSale,
MAX(Sales) OVER(PARTITION BY ProductID) HighestSaleByProduct
FROM Sales.Orders

-- show the employees who have the highest salaries

SELECT * FROM(
SELECT 
*,
MAX(Salary) OVER() HighestSalary
FROM Sales.Employees)t
WHERE Salary = HighestSalary

-- calculate the deviation of each sale from both the min and max sales amounts



SELECT 
OrderID,
OrderDate,
Sales,
ProductID,
MIN(Sales) OVER() LowestSale,
MAX(Sales) OVER() HighestSale,
Sales - MIN(Sales) OVER() DeviationFromMin,
 MAX(Sales) OVER() - Sales  DeviationFromMax
FROM Sales.Orders


/*
-- running total

SUM(Sales) OVER (ORDER BY Month)
Default => ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


vs 


rolling total

SUM(Sales) OVER (ORDER BY Month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)


*/

-- Calculate moving average of sales for each product over time
-- Calculate moving average of sales for each product over time, including only the next order
SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AverageSalesByProductRunning,
AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) RollingAVgpreceding2,
AVG(sales) OVER(PARTITION BY ProductID ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) RollingAVgpreceding2
FROM Sales.Orders


/* USE CASES

-- overall total
-- SUM(Sales) OVER()


-- total per groups 
-- SUM(Sales) OVER(PARTITION BY Product)



-- Running total
-- SUM(Sales) OVER(ORDER BY Month)


-- Rolling total
-- SUM(Sales) OVER(ORDER BY Month ROWS 2 PRECEDING)

*/


--  WINDOW AGGREGATE FUNCTIONS DONE













