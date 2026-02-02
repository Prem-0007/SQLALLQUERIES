-- TABLE types

-- PERMANENT TABLE => CREATE / SELECT , CTAS
-- TEMPORARY TABLE => 

-- CREATE/ INSERT
-- create / insert data into a table

-- CTAS
-- CREATE TABLE AS SELECT
-- Create a new table based on the result of an sql query


-- CTAS VS TABLES

/*
CTAS (MYSQL, Postgress, oracle)

CREATE TABLE NAME AS (
SELECT ...
FROM ....
WHERE...
)


SQL SERVER ----

SELECT ..
INTO NEW-TABLE
FROM ...
WHERE ...
*/


IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
  DROP TABLE Sales.MonthlyOrders;
GO
SELECT
DATENAME(month, OrderDate) OrderMonth,
COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

SELECT * FROM Sales.MonthlyOrders

-- DROP TABLE Sales.MonthlyOrders;





-- TEMPORARY TABLES

-- temporary storage and database gets drop automatically


-- the time b/w connecting and disconnecting the database is called session


SELECT 
* 
INTO #Orders
FROM Sales.Orders


SELECT 
* 
FROM #Orders

DELETE FROM #Orders
WHERE OrderStatus ='Delivered'

SELECT 
* 
FROM #Orders

SELECT 
* 
INTO Sales.OrdersTest
FROM #Orders


-- TEMP TABLES USE CASES
-- INTERMEDIATE RESULTS

-- VIEW OR CTES ARE BEST




--               SUBQUERY          CTE         TMP           CTAS      VIEW

-- STORAGE        MEMORY          MEMORY       DISK           DISK      NO STORAGE

-- LIFETIME      TEMPORARY       TEMPORARY    TEMPORARY      PERMANENT  PERMANENT

-- WHEN DELETED    END OF QUERY   SAME AS SQ   END OF SESSION    -----DDL-DROP----

-- SCOPE        ---- SINGLE-QUERY ------      ----------- MULTI  QUERIES -------------

-- REUSABILITY    -- LIMITED 1 QUERY -----   --MEDIUM        ------ HIGH ------------
 
-- UP2DATE       --- THESE 2 ARE UP2DATE  --- THESE 2 ARE NOT UP2DATE    -- VIEWS UP2DATE --

