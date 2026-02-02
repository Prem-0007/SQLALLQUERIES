-- LEAD(expr, offset, default) returns the value from a previous row    LEAD(Sales,2,0)  OVER(ORDER BY OrderDate)
-- LAG(expr, offset, default) returns the value from a subsequent row    LAG(Sales,2,0)  OVER(ORDER BY OrderDate)
-- FIRST_VALUE(expr) returns the first value in a window FIRST_VALUE(Sales) OVER(ORDER BY OrderDate)
-- LAST_VALUE(expr) returns the last value in a window LAST_VALUE(Sales) OVER(ORDER BY OrderDate)

-- VALUE WINDOW FUNCTIONS 


-- Analyze the month-over-month(MoM) performance by finding the percentage change
-- in sales between the current and previous month
SELECT * ,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100, 1) AS MoM_Perc
 FROM(
SELECT
MONTH(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
)t



-- In order to analyze customer loyalty,
-- rank customers based on the average days between thier orders

SELECT 
AVG(DAY(OrderDate)) OVER(ORDER BY orderID) ,
LAG(AVG(DAY(OrderDate))) OVER(ORDER BY orderID)
FROM Sales.Orders



SELECT 
CUstomerID,
AVG( DaysUntilNextOrder) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG( DaysUntilNextOrder),999999)) RankAVGDays
FROM(
SELECT 
OrderID,
CustomerID,
OrderDate CurrentOrder,
LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) Nextorder,
DATEDIFF(day,OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) ) DaysUntilNextOrder
FROM Sales.Orders
)t
GROUP BY CustomerID


---  FIRST_VALUE()  & LAST_VALUE()

-- DEFAULT:- RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 


-- Find the lowest and highest sales for each product

SELECT
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) lowest_sales,
--- IS SAME AS
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) lowest_sales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) highest_sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) highest_sales2,
MIN(Sales) OVER(PARTITION BY ProductID ) lowest_sales2,
MAX(Sales) OVER(PARTITION BY ProductID ) highest_sales3
FROM Sales.Orders;


-- Find the difference in sales between the current and the lowest sales




SELECT
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) lowest_sales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) highest_sales,
Sales -FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders;

