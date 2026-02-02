--- COMMON TABLE EXPRESSION ----

/*
temporary, named result set (virtual table), that can be
used multiple times within your query to simplify and organize complex query
*/

-- CTE TYPES :- 
-- 1) NON-RECURSIVE => Standalone CTE , Nested CTE
-- 2) RECURSIVE CTE


----- STANDALONE CTE
-- Defined and used independently.
-- Runs independently as it's self-contained and doesn't 
-- rely on other CTEs or queries.

-- step-1: 
-- Find the total sales per customer (Standalone CTE)

WITH CTE_Total_Sales AS
(
    SELECT 
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
)

--- Multiple standalone CTE
-- step-2:- Find the last order date for each customer (Standalone CTE)
, CTE_Last_Order AS
(
    SELECT 
        CustomerID,
        MAX(OrderDate) AS Last_Order
    FROM Sales.Orders
    GROUP BY CustomerID
)

---- NESTED CTE
-- one is dependent on other
-- first one is standalone cte and second one is nested cte

-- step-3:- Rank customers based on total sales per customer
, CTE_Customer_Rank AS
(
    SELECT 
        CustomerID,
        TotalSales,
        RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
    FROM CTE_Total_Sales
)

-- step--4:- segment customers based on their total sales
, CTE_Customer_Segments AS
(
    SELECT 
        CustomerID,
        TotalSales,
        CASE 
            WHEN TotalSales > 100 THEN 'High'
            WHEN TotalSales > 50 THEN 'Medium'
            ELSE 'Low'
        END AS CustomerSegments
    FROM CTE_Total_Sales
)

-- FINAL MAIN QUERY (ONLY ONE QUERY CAN FOLLOW CTEs)
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_Order,
    ccr.SalesRank,
    ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
    ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
    ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
    ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
    ON ccs.CustomerID = c.CustomerID;


    ---- Recursive CTE

  --  self-referencing query that repeatedly processes data until a specific condition is met
  

  -- Generate a sequence of numbers from 1 to 20


  WITH Series AS(
  --Anchor Query
   SELECT
  1 AS MyNumber
  UNION ALL
  -- Recursive Query
  SELECT 
  MyNumber+1
  FROM Series
  WHERE MyNumber < 20
  )

  -- Main Query
 SELECT 
 * FROM Series



  WITH Series AS(
  --Anchor Query
   SELECT
  1 AS MyNumber
  UNION ALL
  -- Recursive Query
  SELECT 
  MyNumber+1
  FROM Series
  WHERE MyNumber < 1000
  )

  -- Main Query
 SELECT 
 * FROM Series
 OPTION(MAXRECURSION 5000)


 -- show the employee hieracrhy by displaying each employee's level within the organization

 -- Anchor Query
 WITH CTE_Emp_Heirarchy AS (
 SELECT
 EmployeeID,
 FirstName,
 ManagerID,
1 AS LEVEL
FROM Sales.Employees
WHERE ManagerID IS NULL

UNION ALL

-- Recursive Query
SELECT
 e.EmployeeID,
 e.FirstName,
 e.ManagerID,
 Level + 1
 FROM Sales.Employees AS e
 INNER JOIN CTE_Emp_Heirarchy ceh
 ON e.ManagerID = ceh.EmployeeID
 )
 -- main query
 SELECT * FROM CTE_Emp_Heirarchy;