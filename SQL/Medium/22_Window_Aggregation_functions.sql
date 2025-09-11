-- Aggregate Window Functions

-- 1. ✨ COUNT
-- count(*) will ignore the nulls
-- COUNT(1)==count(*)
-- COUNT(COLUMN_NAME) WILL remove the nulls

-- FIND the total number of orders

select count(OrderID) as total_order from Sales.Orders

-- additionally provide details such order if & orderdate

select 
	COUNT(OrderID) OVER() as total_orders,
	OrderID,
	OrderDate
from Sales.Orders
GROUP BY OrderID,OrderDate

-- Find the total number of orders for each customer

select 
c.CustomerID,
c.FirstName,
count(o.sales) as orders_by_customer
from Sales.Customers as c
inner join Sales.Orders as o
on c.CustomerID=o.CustomerID
group by c.FirstName, c.CustomerID

-- Find the total number of customers additionally provide all customers details

select 
	FirstName,
	LastName,
	Country,
	Score,
	COUNT(CustomerID) OVER() as total_cutomers
from Sales.Customers


-- Find the total number of scores for the customers

select 
--COUNT(COALESCE(Score,1)) as count_score
COUNT(Score)
from Sales.Customers

-- Check whether the table 'Orders' contains any duplicate rows

select 
	CASE
		WHEN count(DISTINCT(OrderID))=COUNT(OrderID) THEN 'No Duplicate'
		ELSE 'Some duplicates'
	END as check_duplicates,
	count(DISTINCT(OrderID)) as totalCOut 
from Sales.Orders

-- PK have to refer while searching duplicate, if any specific column not mentioned

select * from (
	select 
	OrderID,
		count(*) OVER(PARTITION BY OrderID) as count_order
	from Sales.OrdersArchive
) as subi
where count_order>1
group by count_order,OrderID

-- 2. ✨ SUM
-- null will be ignored yaar...

select * from Sales.Customers
select SUM(Score) from Sales.Customers

-- Find the total sales accross all orders
-- and the total sales for each product
-- additionally provide details such as order id, and order date

select 
	SUM(Sales) OVER() as total_sales ,
	SUM(Sales) OVER(PARTITION BY ProductID) as product_Sales,
	ProductID,
	OrderID,
	OrderDate
from Sales.Orders

-- Find the percantage contribution of each products sales to the total sales

select 
ROUND((product_Sales/CAST(total_sales as decimal(10,2)))*100,1) as percenti , total_sales,product_Sales
	from
		(
			select 
				SUM(Sales) OVER() as total_sales ,
				SUM(Sales) OVER(PARTITION BY ProductID) as product_Sales,
				ProductID,
				OrderID,
				OrderDate
			from Sales.Orders
		) as subi

Select CAST(380 AS DECIMAL(10,1))


-- 2. ✨ AVERAGE
--Find the avergae sales across all orders
-- and find the average sales for each product

SELECT 
	AVG(Sales) OVER() as avg_sales ,
	Sales,
	ProductID,
	AVG(Sales) OVER(PARTITION BY ProductID) as product_avergae,
	OrderID,
	OrderDate
from Sales.Orders

-- Find the average scores of customers
-- Additionally, provide details such as Customer ID and LastName

SELECT 
	AVG(COALESCE(Score,0)) Over() as avg_score,
	Score,
	CustomerID,
	LastName
from Sales.Customers

--Find all orders where sales are higher than the average sales across all orders
select * from (
	select 
		Sales, 
		AVG(Sales) Over() as avg_sales
	from Sales.Orders
) as sumi
where Sales>avg_sales

-- 4. ✨ MIN || MAX

-- Find the highest and lowest sales across all orders

select
	MAX(Sales) Over() as maxi,
	MIN(Sales) Over() as mini,
	MAX(Sales) Over(PARTITION BY ProductID) as pr_maxi,
	MIN(Sales) Over(PARTITION BY ProductID) as pr_mini,
	ProductID,
	Sales,
	OrderID,
	OrderDate
from Sales.Orders

-- Show the employees with highest salaries

Select FirstName,Salary  from Sales.Employees
where Salary= (
	SELECT MAX(Salary) from Sales.Employees
)

-- Running Total and Rolling Total
-- RUN
-- aggregate from begin to current point without dropping anything
-- ROLL: (Shiting Window)
-- aggregate within fixed range, when new thing comes ,it emit || throws the oldest one


-- Calculate the Running_total || Moving avergaes of sales for each product over time

select 
	SUM(Sales) Over(PARTITION BY ProductID) as p_s,
	SUM(Sales) Over(PARTITION BY ProductID Order by OrderDate) as running_out,

	ProductID,
	Sales,
	OrderDate
from Sales.Orders

-- Calucalte the MA of sales for each product over time,inclusing only the next order

-- Rolling TOTAL
select 
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate  ROWS between current row and 1 following ) as ma_sales,
	Sales,
	ProductID
from Sales.Orders


