SELECT 
FirstName,
LastName
FROM Sales.Customers

UNION 

SELECT 
FirstName,
LastName
FROM Sales.Employees



-- UNION ---


-- combine the data from employees and customers into one table


SELECT 
FirstName,
LastName
FROM Sales.Customers
UNION 
SELECT 
FirstName,
LastName
FROM Sales.Employees


-- UNION ALL ---


-- combine the data from employees and customers into one table including duplicates



SELECT 
FirstName,
LastName
FROM Sales.Customers
UNION ALL
SELECT 
FirstName,
LastName
FROM Sales.Employees


-- EXCEPT --- 

-- find the employees who ae not customers at the same time


SELECT 
FirstName,
LastName
FROM Sales.Customers
EXCEPT
SELECT 
FirstName,
LastName
FROM Sales.Employees


-- INTERSECT

-- Find the Employees, who are also customers


SELECT 
FirstName,
LastName
FROM Sales.Customers
INTERSECT
SELECT 
FirstName,
LastName
FROM Sales.Employees


-- orders are stored in seperate tables (Orders and OrdersArchive)
-- combine all orders into one report without duplicates

SELECT 
'Orders' AS SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION

SELECT 
'OrdersArchive' AS SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID