-- INDEX
-- it is a data structure which provides quick access
-- to data, optimizing the speed of your queries

/*

--  3 types =>

Structure => clustered, non-clustered 
Storage => rowstore,  columnstore
Functions => unique, filtered

*/

-- Heap structure

-- page :- the smallest unit of data storage in a database(8kb)

-- it stores data ,metadata , indexes 
-- data page, index page


SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers


SELECT * 
FROM Sales.DBCustomers
WHERE CustomerID = 1


CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

 
 

CREATE CLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers


SELECT * 
FROM Sales.DBCustomers
WHERE LastName = 'Brown'

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastNAME
ON Sales.DBCustomers(LastName)


/*
CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers(FirstName)
*/


SELECT 
* FROM Sales.DBCustomers
WHERE Country= 'USA' AND Score > 500

CREATE INDEX idx_DBCustomers_CuntryScore
ON Sales.DBCustomers (Country, Score)


A,B,C,D

-- Index will be used
A
A, B


-- Index won't be used
B
A,C
A,B,D



--- columnstore index 


CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DB

DROP INDEX [idx_DBCustomers_CustomerID]
