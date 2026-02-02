----  Find the total number of orders


SELECT
Count(*)  TotalCustomers
FROM Customers

-- find the total sales of all orders

SELECT
COUNT(*) AS nr_of_Sales,
SUM(sales) AS total_sales
FROM Orders

SELECT
customer_id,
COUNT(*) AS nr_of_Sales,
SUM(sales) AS total_sales,
AVG(sales) AS avg_sales,
MAX(sales) AS  highest_sales,
MIN(sales) AS lowest_sales
FROM Orders
GROUP BY Customer_id



-- SCORES in the customer table

SELECT

COUNT(*) as Total_customers,
SUM(score) AS total_score,
AVG(score) AS avg_score,
MAX(score) AS highest_score,
MIN(score) AS lowesr_score
FROM customers


