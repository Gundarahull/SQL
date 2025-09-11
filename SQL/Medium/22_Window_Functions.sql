-- Window or Analaytical Functions

-- window is also grouping the things, but it will have the row level,
-- wheras in the group by, it compress the row levels with unique ones
-- row - level functions
-- returns a result for each row
-- if we want to keep aggregaration + keep details, we will go with WINDOW


-- where GROUP BY is not enough for us? then WINDOW will come into the picture...

-- find the total sales across all orders

select 
	SUM(Sales) 
from Sales.Orders

-- find the total sales for each product

select
ProductID,SUM(Sales) as total_sales_per_product 
from Sales.Orders
GROUP by ProductID

-- find the total sales for each product, additionally provide details such order id and order date
select 
	ProductID,
	SUM(Sales) as t_p,
	OrderID,
	OrderDate
from 
Sales.Orders
group by ProductID,OrderID,OrderDate
-- here while running this for productid, we are not getting sum of sales according to the product, its spreading like 
-- 101 -10
-- 102 -15
-- 101 -20 (Again seeing 101), its not appropriate right, 
/*
		101	10	1	2025-01-01
		102	15	2	2025-01-05
		101	20	3	2025-01-10
		105	60	4	2025-01-20
		104	25	5	2025-02-01
		104	50	6	2025-02-05
		102	30	7	2025-02-15
		101	90	8	2025-02-18
		101	20	9	2025-03-10
		102	60	10	2025-03-15
*/
-- here windows comes into the picture...

-- 🎯♦️ Window functions returns a rsult for EACH ROW
-- OVER() >> it give result to all rows
-- it need to put beside the aggregate functions 
-- PARTITION BY 'column_name' is like a group_by

select 
	OrderID,
	OrderDate,
	ProductId,
	SUM(Sales) OVER(PARTITION BY ProductId)
from Sales.Orders

select 
	department,
	Gender,
	FirstName,
 SUM(Salary) OVER(PARTITION BY FirstName)
from Sales.Employees


-- 🏐🏐🏐 WINDOW Syntax


-- WindowFunction(Aggr,Analytical and lead functions)- order caluse[OVER(PARTIATION BY "" ORDER BY "" )// insode over its an optional]

-- ⚠️ OVER CLAUSE
-- 1. PARTITION BY
-- its like a group by (it will separetes by each unique one)
-- we can use multiple columns for the partitions
-- PARTITION BY (productID, productStatus)

select 
ProductID,
OrderStatus,
orderDate,
sum(Sales) OVER(partition by productID,OrderStatus)
from Sales.Orders

-- Find the total Sales accross all orders, additionally provide deatsils such order id and order data

select
	SUM(sales) over() as acc_ord,
	OrderID,
	OrderDate
from Sales.Orders


-- find the total sales for each prodcut
-- additionally provide details such as order id and order date

select
	SUM(Sales) OVER(PARTITION BY ProductID)as tp,
	SUM(Sales) over() as acc_ts,
	ProductID ,
	OrderDate,
	OrderID,
	OrderStatus,
	SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) as part_by_PID_OS
from Sales.Orders

-- within the one query we can use amny window to see the data separation according to the USE

-- 2. ORDER BY (ordering within the window function)
-- Rank each order based on their sales from highest to lowest,
-- addiionally provide details such order if and order data

select 
	 RANK() OVER(ORDER by Sales desc) as rankk,
	 Sales,
	 OrderDate,
	 OrderID
from Sales.Orders

-- 3. FRAME Clasue 

-- subset of the window
-- ⚠️⚠️ RULES
-- FRAME Clause should be used in ORDER BY CLAUSE
-- LOWER to HIGHER boundary value

-- 2 FOLLOWING >> next 2 rows
-- **--unBOUNDED Following is the LAST ROW--**
-- **-- UNBOUNDED PRECEDING is the FIRST ROW --**
-- Preceding : before the current row


-- IF we use ORDER BY, default FRAME is
-- ROWS BETWEEN UNBOUNDED PRECEDING  AND CURRENT ROW



-- ⚠️⚠️⚠️ WINDOW FUNCTIONS RULES
-- 1. ONly use in SELECT and ORDER BY
-- 2. No Nested window functions
-- 3. it will only execute after WHERE clause
-- 4. we can use group by but same aggregation functions should be select and as well as in window function

-- RANK CUSTOMERS BASED ON THEIR TOTAL SALES

select * from Sales.Customers
select * from Sales.Orders

select 
c.CustomerID,
o.Sales,
c.FirstName,
SUM(sales) OVER(PARTITION BY c.CustomerID) as sales_per_person
from Sales.Orders as o
inner join Sales.Customers as c
on o.CustomerID=c.CustomerID



select
*, RANK() OVER(ORDER BY per_person) 
as RNKI from(
	select 
	c.CustomerID,
	c.FirstName,
	SUM(Sales) as per_person
	from Sales.Orders as o
	inner join Sales.Customers as c
	on o.CustomerID=c.CustomerID
	group by c.CustomerID, c.FirstName
) as subi





