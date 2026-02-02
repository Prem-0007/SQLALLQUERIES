SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime
FROM Sales.Orders


SELECT
OrderID,
CreationTime,
'2026-01-05' HardCoded,
GETDATE() Today
FROM Sales.Orders

-- FUNCTIONS ---


-- DAY, MONTH, YEAR, DATEPART, DATENAME, DATETRUNC, EOMONTH,
-- FORMAT, CONVERT, CAST
-- DATEADD, DATEDIFF
-- ISDATE




--- DAY, MONTH, YEAR ----

SELECT
OrderID,
CreationTime,
YEAR(CreationTime) Year,
MONTH(CreationTime) MONTH,
DAY(CreationTime) DAY
FROM Sales.Orders


--- DATEPART ---  SYNTAX:- DATEPART(PART,DATA) (DATATYPE- INT)





SELECT
OrderID,
CreationTime,
DATEPART(year, CreationTime) Year_dp,
DATEPART(month, CreationTime) Month_dp,
DATEPART(day, CreationTime) Day_dp,
DATEPART(hour, CreationTime) Hour_dp,
DATEPART(minute, CreationTime) Minute_dp,
DATEPART(second, CreationTime) Second_dp,
DATEPART(millisecond, CreationTime) Ms_dp,
DATEPART(quarter, CreationTime) Quarter_dp,
DATEPART(week, CreationTime) Week_dp,
YEAR(CreationTime) Year,
MONTH(CreationTime) MONTH,
DAY(CreationTime) DAY
FROM Sales.Orders


--- DATENAME ----   SYNTAX:- DATENAME(PART,DATA) -- gives output in string format (DATATYPE- STRING)



SELECT
OrderID,
CreationTime,
DATENAME(month, CreationTime) Month_dn,
DATENAME(weekday, CreationTime) WeekDay_dn,
DATENAME(day, CreationTime) Day_dn,
DATENAME(year, CreationTime) Year_dn,
DATENAME(hour, CreationTime) Hour_dn,
-- DATEPART Examples (DATATYPE- INT)
DATEPART(year, CreationTime) Year_dp,
DATEPART(month, CreationTime) Month_dp,
DATEPART(day, CreationTime) Day_dp,
DATEPART(hour, CreationTime) Hour_dp,
DATEPART(minute, CreationTime) Minute_dp,
DATEPART(second, CreationTime) Second_dp,
DATEPART(millisecond, CreationTime) Ms_dp,
DATEPART(quarter, CreationTime) Quarter_dp,
DATEPART(week, CreationTime) Week_dp,
YEAR(CreationTime) Year,
MONTH(CreationTime) MONTH,
DAY(CreationTime) DAY
FROM Sales.Orders



--- DATETRUNC --- SYNTAX:- DATETRUNC(PART,DATA)  (DATATYPE- DATETIME)




SELECT
OrderID,
CreationTime,
-- DATETRUNC Examples  (DATATYPE- DATETIME)
DATETRUNC(second,CreationTime) Second_dt,
DATETRUNC(minute,CreationTime) Minute_dt,
DATETRUNC(hour,CreationTime) Hour_dt,
DATETRUNC(day,CreationTime) Day_dt,
DATETRUNC(month,CreationTime) Month_dt,
DATETRUNC(year,CreationTime) Year_dt,
-- DATENAME Examples (DATATYPE- STRING)
DATENAME(month, CreationTime) Month_dn,
DATENAME(weekday, CreationTime) WeekDay_dn,
DATENAME(day, CreationTime) Day_dn,
DATENAME(year, CreationTime) Year_dn,
DATENAME(hour, CreationTime) Hour_dn,
-- DATEPART Examples (DATATYPE- INT)
DATEPART(year, CreationTime) Year_dp,
DATEPART(month, CreationTime) Month_dp,
DATEPART(day, CreationTime) Day_dp,
DATEPART(hour, CreationTime) Hour_dp,
DATEPART(minute, CreationTime) Minute_dp,
DATEPART(second, CreationTime) Second_dp,
DATEPART(millisecond, CreationTime) Ms_dp,
DATEPART(quarter, CreationTime) Quarter_dp,
DATEPART(week, CreationTime) Week_dp,
YEAR(CreationTime) Year,
MONTH(CreationTime) MONTH,
DAY(CreationTime) DAY
FROM Sales.Orders



SELECT 
CreationTime,
COUNT(*)
FROM Sales.Orders
GROUP BY CreationTime





SELECT 
DATETRUNC(month,CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(month,CreationTime)




SELECT 
DATETRUNC(year,CreationTime),
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(year,CreationTime)


--- EOMONTH ---   SYNTAX:-  EOMONTH(DATE) (DATATYPE- DATE)

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) AS EndOfMonth,
CAST(DATETRUNC(month, CreationTime) AS DATE) AS StartOfMonth
FROM Sales.Orders



-- How many orders were placed each year ? 

SELECT 
YEAR(OrderDate),
COUNT(*) NoOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)



-- How many orders were placed each month ? 


SELECT 
MONTH(OrderDate),
COUNT(*) NoOfOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate)


-- DATENAME (SAME TASK)


SELECT 
DATENAME(month,OrderDate) AS OrderDate,
COUNT(*) NoOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)


-- Show all orders that were placed during the month of february

SELECT 
DATENAME(month,OrderDate) AS OrderDate,
COUNT(*) NoOfOrders
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2
GROUP BY DATENAME(month,OrderDate)


-- ALL ORDERS 

SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2




--- DATE FROMATS ----



---   YYYY-MM-dd => dates HH-mm-ss => time

--- YYYY-MM-dd => ISO 8601 

--- MM-dd-YYYY => USA standard

--- dd-MM-YYYY => European standard



--- FORMAT ----  SYNTAX:- FROMAT(value, format[,culture])



SELECT 
OrderID,
FORMAT(CreationTime, 'MM-dd-yyyy')  USA_Format,
FORMAT(CreationTime, 'dd-MM-yyyy')  EURO_Format,
FORMAT(CreationTime, 'dd') dd,
FORMAT(CreationTime, 'ddd') ddd,
FORMAT(CreationTime, 'dddd') dddd,
FORMAT(CreationTime, 'MM') MM,
FORMAT(CreationTime, 'MMM') MMM,
FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders


-- Show CreationTime using the following format:
-- Day wed Jan Q1 2025 12:34:56 PM


SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime, 'ddd MMM')+ 
' Q' + DATENAME(quarter,CreationTime)  + ' '+ 
FORMAT(CreationTime, 'yyyy hh:mm:ss tt')AS CustomeFormat 
FROM Sales.Orders


SELECT
FORMAT(OrderDate,'MMM yy') OrderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')


------ CONVERT --------

SELECT 
CONVERT(INT, '123') AS [String to Int CONVERT],
CONVERT(DATE, '2026-01-07') AS [String to Date CONVERT],
CreationTime,
CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT]
FROM Sales.Orders;



SELECT 
CreationTime,
CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
CONVERT(VARCHAR, CreationTime, 32) AS[USA Std. Style:32],
CONVERT(VARCHAR, CreationTime, 34) AS[EURO Std. Style:34]
FROM Sales.Orders;


----- CAST ------

SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [Int to String],
CAST('2026-07-01' AS DATE) AS [String to Date],
CAST('2026-07-01' AS DATETIME) AS [String to DateTime],
Creationtime,
CAST(Creationtime AS DATE) AS [DateTime to Date]
FROM Sales.Orders


---- DATEADD ------- SYNTAX:- [DATEADD(part, interval, date)] EX:- DATEADD(year, 2, OrderDate)

SELECT 
OrderID,
OrderDate,
DATEADD(day, -7, OrderDate) AS SevenDaysBefore,
DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
DATEADD(year, 2, OrderDate) AS TwoYearsLater
FROM Sales.Orders



---- DATEDIFF ------- SYNTAX:- [DATEDIFF(part, start_date, end_date)]

-- Calculate the age of employees

SELECT 
EmployeeID,
BirthDate,
DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees


-- Find the average shipping duration in days for each month



SELECT 
MONTH(OrderDate) AS OrderDate,
AVG(DATEDIFF(day, OrderDate, ShipDate)) AS AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- time gap analysis

-- Find the number of days between each order and previous order

SELECT 
OrderID,
OrderDate CurrentOrderDate,
LAG(OrderDate ) OVER (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(day, LAG(OrderDate ) OVER (ORDER BY OrderDate),OrderDate) AS NrOfDays
FROM Sales.Orders

 
-----  ISDATE ------- SYNTAX:- ISDATE(value)


SELECT ISDATE('123') DateCheck1,
ISDATE('2026-01-08') DateCheck2,
ISDATE('13-01-2026') DateCheck3,
ISDATE('2026') DateCheck4,
ISDATE('07') DateCheck5

SELECT 
-- CAST(OrderDate AS DATE) OrderDate
OrderDate,
ISDATE(OrderDate),
CASE WHEN ISDATE(OrderDate) =1 THEN CAST(OrderDate AS DATE)
ELSE  '9999-01-01'
END NewOrderDate
FROM(
SELECT '2026-01-07' AS orderDate UNION
SELECT '2026-01-08' UNION
SELECT '2026-01-09' UNION
SELECT '2026-01'
)t
-- WHERE ISDATE(OrderDate) =0




