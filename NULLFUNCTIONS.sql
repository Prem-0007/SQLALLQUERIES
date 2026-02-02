---- ISNULL()  SYNTAX:- ISNULL(VALUE, REPLACEMENT_VALUE)

-- fast, limited to two values
/*
SQL - ISNULL
Oracle - NVL
MySQL - IFULL
*/

-------- COALESCE() SYNTAX:- retruns the first non-null value from a list

-- ulimited, slow, available in all databases




-- find the average score of customers

SELECT CustomerID , 
Score, 
COALESCE(Score,0) Score2,
AVG(score) OVER() AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScores2
FROM Sales.Customers ;


-- display the full name of customers in a single field by merging their
-- first and last names, and add 10 bonus points to each customer's score.

SELECT
CustomerID,
FirstName,
LastName,
COALESCE(LastName, '') LastName2,
FirstName + ' ' + COALESCE(LastName, 'n/a') AS FullName,
(CONCAT(FirstName,' ',COALESCE(LastName, ''))) AS FullName,
Score,
Score + 10  AS ScoreWithBonus,
COALESCE(Score, '0') + 10 AS ScoreWithBonus
FROM Sales.Customers;



-- sort the customers from lowest to highest scores
-- with nulls appearing last

SELECT
CustomerID,
Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL  THEN 1 ELSE 0 END,Score;



-- NULL IF 

-- Find the sales price for each order by dividing the sales by the quantity

SELECT
OrderID,
Sales,
Quantity,
Sales / NULLIF(Quantity, 0) AS Price -- prevnts divide by zero error
FROM Sales.Orders


----- IS NULL & IS NOT NULL


-- Identify the customers who have no scores

SELECT 
*
FROM
Sales.Customers
WHERE Score IS NULL


-- List all customers who have scores
 
SELECT 
*
FROM
Sales.Customers
WHERE Score IS NOT NULL

-- LIST all details for customers who have not placed any orders

SELECT
c.*
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL


--- NULL VS EMPTY STRING VS BLANK SPACE ---


WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
) 
SELECT 
* ,
DATALENGTH(Category) CategoryLen
FROM Orders

/*
-- NULL            EMPTY STRING          BLANK SPACE

NULL                 ''                     '  '

UNKNOWN            KNOWN, EMPTY           KNOWN, SPACE

SPECIAL             STRING(0)             STRING(1 OR MORE)

VERY MIN STORAGE    OCCUPIES MEMORY       OCCUPIES EACH SPACE

BEST PERFORMANCE       FAST                       SLOW

 IS NULL              =''                         =' '


 */




 -- DATA POLICY


WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  ' 
) 
SELECT 
* ,
-- DATALENGTH(Category) CategoryLen,
-- DATALENGTH(TRIM(Category)) Policy1,
TRIM(Category) Policy1, -- trim blank spaces (avoid)
NULLIF(TRIM(Category), '') Policy2, -- policy2
COALESCE(NULLIF(TRIM(Category), ''), 'unknown') Policy3
FROM Orders