-- STEP-1: write a query
-- For US Customers find the total number of customers and the average score

/*
SELECT
    COUNT(*) AS TotalCustomers,
    AVG(Score) AS AvgScore
FROM Sales.Customers
WHERE Country = 'USA';
*/

------------------------------------------------------------

-- STEP-2: Turning query into a stored procedure

/*
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = 'USA';
END;
*/

------------------------------------------------------------

-- STEP-3: Execute the stored procedure

-- EXEC GetCustomerSummary;

------------------------------------------------------------
-- PARAMETERS
------------------------------------------------------------

-- For German Customers find the total number of customers and the average score

/*
CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
    SELECT
        COUNT(*) AS TotalCustomers,
        AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = 'Germany';
END;

EXEC GetCustomerSummaryGermany;
*/

------------------------------------------------------------

-- Define stored procedure (Parameterized Version)
-- STEP-2: Turning query into a stored procedure

-- total customers from germany : 2
-- average score from germany : 425

ALTER PROCEDURE GetCustomerSummary
    @Country NVARCHAR(50) = 'USA'
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------
    -- Variables
    -- Variables store values used inside the procedure
    -- Parameters pass values into a stored procedure
    --------------------------------------------------------
    DECLARE 
        @TotalCustomers INT,
        @AvgScore FLOAT;

    --------------------------------------------------------
    -- Prepare & cleanup data
    --------------------------------------------------------
    IF EXISTS (
        SELECT 1
        FROM Sales.Customers
        WHERE Score IS NULL
          AND Country = @Country
    )
    BEGIN
        PRINT 'Updating NULL Scores to 0 for ' + @Country;

        UPDATE Sales.Customers
        SET Score = 0
        WHERE Score IS NULL
          AND Country = @Country;
    END
    ELSE
    BEGIN
        PRINT 'No NULL Scores found for ' + @Country;
    END;

    --------------------------------------------------------
    -- Customer Summary
    --------------------------------------------------------
    SELECT
        @TotalCustomers = COUNT(*),
        @AvgScore = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @Country;

    PRINT 'Total Customers from ' + @Country + ' : ' 
          + CAST(@TotalCustomers AS NVARCHAR(10));

    PRINT 'Average Score from ' + @Country + ' : ' 
          + CAST(@AvgScore AS NVARCHAR(20));

    --------------------------------------------------------
    -- Find the total number of orders and total sales
    --------------------------------------------------------
    SELECT
        @Country AS Country,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(o.Sales) AS TotalSales
    FROM Sales.Orders o
    JOIN Sales.Customers c
        ON c.CustomerID = o.CustomerID
    WHERE c.Country = @Country;

END;
GO

------------------------------------------------------------
-- Execute the stored Procedure
------------------------------------------------------------

EXEC GetCustomerSummary;                     -- Default (USA)
EXEC GetCustomerSummary @Country = 'Germany';

------------------------------------------------------------
-- Check Data
------------------------------------------------------------

SELECT * FROM Sales.Customers;

-- ERROR HANDLING -- 
/*
BEGIN TRY
-- SQL ERROR MIGHT OCCUR
END TRY
*/
/*
-- SIMILARLY 
BEGIN CATCH
-- SQL CATCHING
END CATCH
*/
-- TRY...CATCH Error Handling Example

BEGIN TRY
    SELECT 
        6 / 3 AS Result1;

     SELECT 1 / 0 AS Result2;   -- This will cause a divide-by-zero error
END TRY

BEGIN CATCH
    PRINT 'An error occurred.';

    PRINT 'Error Message   : ' + ERROR_MESSAGE();
    PRINT 'Error Number    : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    PRINT 'Error Line      : ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    PRINT 'Error Procedure : ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
END CATCH;


-- STYLING
 -- GIVE SPACES TABS COMMENTS WELL