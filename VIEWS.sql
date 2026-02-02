-- FIND the runnning total sales for each month

WITH CTE_Monthly_Summary AS (
SELECT 
DATETRUNC(month,OrderDate) OrderMonth,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)

SELECT 
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary ;





---- BY VIEWSSS
IF OBJECT_ID( 'Sales.V_Monthly_Summary', 'V') IS NOT NULL
 DROP VIEW Sales.V_Monthly_Summary;
GO

DROP VIEW Sales.V_Monthly_Summary;


CREATE  VIEW Sales.V_Monthly_Summary AS (
SELECT 
DATETRUNC(month,OrderDate) OrderMonth,
SUM(Sales) TotalSales,
COUNT(OrderID) TotalOrders,
SUM(Quantity) TotalQuantities
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)


-- TASK:- Provide View that combines details from orders, products, customers and employees

CREATE VIEW Sales.V_Order_Details AS (
SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
    c.Country AS CustomerCountry,
    COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
    e.Department,
    o.Sales,
    o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
    ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
    ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
    ON e.EmployeeID = o.SalesPersonID
)

SELECT * FROM Sales.V_Order_Details;


-- provide a view for the EU sales Team 
-- that combines details from all the tables
-- and excludes data related to the USA 
CREATE VIEW Sales.V_Order_Details_EU AS (
SELECT
    o.OrderID,
    o.OrderDate,
    p.Product,
    p.Category,
    COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
    c.Country AS CustomerCountry,
    COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
    e.Department,
    o.Sales,
    o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
    ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
    ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
    ON e.EmployeeID = o.SalesPersonID
WHERE c.Country <> 'USA'
)


SELECT * FROM Sales.V_Order_Details_EU;

-- VIRTUAL table without storing the data => views
-- views are better than CTE and Tables cuz reusable and flexible
-- reusability, complexity, data security, flexibility

