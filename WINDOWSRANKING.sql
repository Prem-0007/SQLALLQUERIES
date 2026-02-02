-- Rank the orders based on their sales from highest to lowest


--- ROW_NUMBER() -> Assigns a number irrespective of ties.
SELECT
 OrderID,
 ProductID,
 Sales,
 ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
 FROM Sales.Orders;



-- RANK() handles ties , leaves gaps in ranking 
 
SELECT
 OrderID,
 ProductID,
 Sales,
 ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
  RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank
 FROM Sales.Orders;


 
 -- DENSE_RANK() handles ties ,doesn't leaves gaps in ranking 

SELECT
 OrderID,
 ProductID,
 Sales,
 ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
  RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank,
  DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_DenseRank
 FROM Sales.Orders;



 --- ROW_NUMBER()  => unique rank , doesn't handle ties, no gaps in ranks

 --- RANK() =>  shared rank, handles ties, gaps in ranks

 --- DENSE_RANK() => shared rank, handles ties, no gaps in ranks


 --- USE CASES


 -- Find the top highest sales for each prodcut

 SELECT
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
 FROM Sales.Orders;
 


SELECT * FROM(
 SELECT
  OrderID,
  ProductID,
  Sales,
  ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
 FROM Sales.Orders
)t WHERE RankByProduct = 1;


-- Find the lowest 2 customers based on their total sales

SELECT * FROM(
 SELECT
 CustomerID,
 SUM(Sales) TotalSales,
 ROW_NUMBER() OVER(ORDER BY  SUM(Sales)) RankCustomers
 FROM Sales.Orders
 GROUP BY customerID
 )t WHERE RankCustomers <=2



 -- Assign unique ids to the rows of the "orders archive" table

 SELECT 
 OrderID,
 ProductID,
 ROW_NUMBER() OVER(ORDER BY  OrderID, OrderDate) uniqueID,
 *
 FROM Sales.OrdersArchive



 -- identify duplicate rows in the table orders archive
 -- and return a clean result without any duplicates

 SELECT * FROM(
 SELECT 
 ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn, 
 * 
 FROM Sales.OrdersArchive
 )t WHERE rn>1



--- ROW_NUMBER()  USE CASES : - TOP-N Analysis, Bottom-N Analysis, Assign unique IDs, Quality chevks: Identify Duplicates




--- NTILE() => Divides the rows into a specified number of approximately equal groups(Buckets)
--- Bucket size = number of rows / number of buckets
-- Larger group comes first 

SELECT 
OrderID,
 NTILE(1) OVER( ORDER BY Sales DESC) OneBucket,
  NTILE(2) OVER( ORDER BY Sales DESC) TwoBuckets,
   NTILE(3) OVER( ORDER BY Sales DESC) ThreeBuckets,
    NTILE(4) OVER( ORDER BY Sales DESC) FourBuckets
 FROM Sales.OrdersArchive



 --- NTILE() USE CASES => Data segmentation, equalizing load processing

 -- Segement all orders into three categories: high medium and low sales


 -- #1 use case:- Data segmentation

SELECT * ,
CASE 
WHEN Buckets = 1 THEN 'High'
WHEN Buckets = 2 THEN 'Medium'
ELSE 'Low'
END  SalesSegmentations FROM (SELECT
 orderID,
 Sales,
 NTILE(3) OVER(ORDER BY Sales DESC) Buckets
 FROM Sales.Orders
 )t





 -- #2 use case :-  equalizing load processing

 -- In order to export the data, divide the order intp 2 groups

 SELECT
 orderID,
 Sales,
 NTILE(2) OVER(ORDER BY orderID ) 
 FROM Sales.Orders



 --- Percentage based ranking

--- CUME_DIST => position Nr/ Number of rows , -- the position of last occurence of the same value
--- cumulative distribution calculates the distribution of data points within a window
-- inclusive( the current row is inclusive) 


SELECT 
OrderID,
Sales,
CUME_DIST() OVER(ORDER BY Sales DESC) cumeDist
FROM Sales.Orders






--- PERCENT_RANK => position Nr - 1 / Number of rows -1, the position of first occurence of the same value
-- exclusive( the current row is exclusive)

-- calculates relative position of each row



SELECT 
OrderID,
Sales,
PERCENT_RANK() OVER(ORDER BY Sales DESC) percentRank
FROM Sales.Orders



--- find the products that fall within the highest 40% of prices
SELECT 
*,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
SELECT
Product,
Price,
PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank
FROM Sales.Products
)t WHERE  DistRank <= 0.4