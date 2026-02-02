SELECT 
*
FROM V_Monthly_Summary;


SELECT 
OrderMonth,
TotalSales,
TotalOrders,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM V_Monthly_Summary;


--- DROP VIEW 


---- DROP VIEW V_Monthly_Summary

