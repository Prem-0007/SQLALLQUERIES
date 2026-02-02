-- TRIGGERS
-- special stored procedure that automatically 
-- runs in response to a specific event on a table or a row

/*
TRIGGERS
DML , DDL , LOGGON
*/


-- LOGGING

-- TRIGGER SYNTAX
/*
CREATE TRIGGER TriggerName ON TableName
AFTER INSERT, UPDATE, DELETE
BEGIN
-- SQL STATEMENTS GOES HERE
END
*/

CREATE TABLE Sales.EmployeeLogs(
   LogID INT IDENTITY(1,1) PRIMARY KEY,
   EmployeeID INT,
   LogMessage VARCHAR(255),
   LogDate DATE

)


CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
  INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
  SELECT
  EmployeeID,
  'New Employee Added =' +CAST( EmployeeID AS VARCHAR),
  GETDATE()
  FROM INSERTED
END
-- INSERTED : - Virtual table that holds a copy of the rows that are 
-- inserted into the target table

SELECT * FROM Sales.EmployeeLogs

INSERT INTO Sales.Employees
VALUES
(7, 'Maria','Doe','HR', '1982-01-12', 'F', 80000, 3)
