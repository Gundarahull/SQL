-- SubQUERY



-- 🎯⚠️ RESULT TYPE SUBQUERIES

-- ✨ Scalar SubQuery
-- It will return only one Value...
Select SUM(Sales) from Sales.Orders

-- ✨ ROW SubQuery
-- Multiple rows with single column
select Sales from Sales.Orders

-- ✨ TABLE SubQuery
-- Multiple rows and columns
select * from Sales.Orders


-- 🎯⚠️ LOCATION || CLAUSES where we can insert the SubQuery

-- ✨ FROM
-- as temp table

-- FInd the products that have a price higher than the avegage price of all products

select * from (
		select 
			Price,
			AVG(Price) OVER() as avg_pri,
			ProductID
		from Sales.Products
) as sumi
where Price>avg_pri

select 
* from Sales.Products
where Price>(select 
				AVG(Price) as avg_pri 
			  from Sales.Products)

-- Rank the Customers based on their amount of sales

select 
RANK() OVER(Order by total_Sales_cust DESC) as RANKI_per_sales,
total_sales_cust,
CustomerID
 from (Select 
			c.CustomerID,
			c.FirstName,
			SUM(o.Sales) as total_sales_cust
		from Sales.Customers as c
		inner join Sales.Orders as o
		on o.CustomerID=c.CustomerID
		Group by c.CustomerID,c.FirstName
) as sumi


-- Sub Query resukt is stored in the CACHE
-- Main Query will interact with CACHE


-- ✨ SELECT
-- side by side ???

-- ♦️♦️ RULE

-- Only Scalar SubQuery (Only one value should be)

-- show the productIDs, names, prices, total number of orders

select 
* 
from Sales.Products

select 
	COUNT(o.OrderID) as total_no_ord,
	p.ProductID,
	p.Product,
	p.Price
from Sales.Orders  o
INNER JOIN Sales.Products p
on o.ProductID=p.ProductID
GROUP BY p.ProductID,p.Product,p.Price

-- Another Way

select 
	Product,
	Price,
	ProductID,
	--SubQuery
	(Select COUNT(OrderID) from Sales.Orders) as t_o
from Sales.Products



-- ✨ JOIN
-- used to prepare the data before joining it with other tables

-- Show all customer details
-- and find the total orders for each customer

select 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country,
    c.Score,
    COALESCE(sumi.t_orders, 0) as t_orders
from Sales.Customers c
left join (
    select CustomerID, count(OrderID) as t_orders
    from Sales.Orders
    group by CustomerID
) sumi
on c.CustomerID = sumi.CustomerID;


select * from Sales.Orders

-- ✨ WHERE
-- 1.Comparsion OPerators

-- ♦️♦️ RULE

-- Only Scalar SubQuery (Only one value should be)


-- 2. Logical Operators

-- 2.1 🏐 IN OPerator
-- For multiple Values..
-- Show the details of orders made by Csutomers in Germany

-- One way
select
	Country,
	o.* 
from Sales.Customers c
inner join Sales.Orders o
on c.CustomerID=o.CustomerID
where Country = 'Germany'

-- Another Way

select 
* 
from Sales.Orders
where CustomerID IN (
				-- SubQuery
				select 
					CustomerID 
				from Sales.Customers
				where Country='Germany'
				)

-- 🏐 ANY || ALL

-- Find Female Employees whose Salaries are
-- greaterthan the salries of any male employee

-- ANY yedhi ayina okati ayina satisfy aye la chuudu thammudu

select
* 
from Sales.Employees
where Gender='M'

select
Salary,
FirstName
from Sales.Employees
where Gender='F' AND Salary >ANY(select
Salary
from Sales.Employees
where Gender='M')


-- Find Female Employees whose Salaries are
-- greaterthan the salries of ALL male employee



-- 🎯⚠️ DEPENDENCY SUBQUERIES
-- ✨ NON Correlated SubQuery
-- a sub query that run independently from the main query
-- First Sub Query -> then result -> Main Query

-- ✨ Correlated SubQuery
-- a sub query that run dependently on the main query
-- First MAIN Query -> then result -> SUB Query 🔁 repeats


-- 🏐 EXISTS

-- its a co releated SubQuery, which is related to the MAIN QUERY

-- Show the details of orders made by Csutomers in Germany

select 
* 
from Sales.Orders o
where EXISTS 
		(select 
			1 
		  from Sales.Customers c
		  where Country='Germany' 
				and o.CustomerID=c.CustomerID)
