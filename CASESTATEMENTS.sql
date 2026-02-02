-- CASE --

-- Generate a report showing the total sales for each category
-- high : if the sales higher than 50
-- meadium : if the sales between 20 and 50
-- low : if the sales equal or lower than 20
-- sort the result from least to highest


SELECT
Category,
SUM(Sales) AS TotalSales
FROM(
SELECT 
OrderID,
Sales,
CASE 
WHEN Sales > 50 THEN 'High'
WHEN Sales > 20 THEN 'Medium'
ELSE 'Low'
END AS Category
From Sales.Orders)t
GROUP BY Category
ORDER BY TotalSales DESC

-- Retrieve employee details with gender displayed as full text

SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE 
WHEN Gender = 'M' THEN 'Male'
WHEN Gender = 'F' THEN 'Female'
ELSE 'Not Available'
END FullGender
FROM Sales.Employees



-- Retrieve customer details with abbreviated country code


SELECT 
CustomerID,
FirstName,
LastName,
Country,
CASE 
	WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
 ELSE 'n/a'
END  CountryAbbr,
CASE  Country 
    WHEN 'Germany' THEN 'DE'
	WHEN 'USA' THEN 'US'
 ELSE 'n/a'
END  CountryAbbr2
FROM Sales.Customers


-- Find the average scores of customers and treat Nulls As 0
-- Additionally provide details such as CustomerID and LastName

SELECT
CustomerID,
LastName,
Score,
CASE 
WHEN Score IS NULL THEN 0
ELSE Score
END ScoreClean,
AVG(CASE 
WHEN Score IS NULL THEN 0
ELSE Score
END) OVER() AvgCustomerClean,
AVG(Score) OVER()  AvgCustomer
FROM Sales.Customers



-- Count how many times each customer has made an order with sales greater than 30

SELECT 
CustomerID,
SUM(
CASE WHEN Sales > 30 THEN 1
ELSE 0
END ) AS TotalOrdersHighSales,
 COUNT (*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

