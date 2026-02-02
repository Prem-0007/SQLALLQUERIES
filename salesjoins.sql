-- task : usong salesDB, Retrieve a list of all orders, along 
-- with the related customer, product, and employee details. For
-- each order, display: order ID, Customer's name. Product name,
-- Sales, Price, Sales person's name 


USE SalesDB


SELECT 
o.OrderID, 
o.Sales,
c.FirstName,
c.LastName,
p.Product AS ProductName,
p.price,
e.FirstName AS EmployeeFirstName,
e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID= c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID



SELECT * FROM Sales.Customers;

SELECT * FROM Sales.Employees;

SELECT * FROM Sales.Orders;

SELECT * FROM Sales.OrdersArchive;

SELECT * FROM Sales.Products;





