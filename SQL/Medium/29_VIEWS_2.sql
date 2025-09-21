-- DDL VIEWS

-- ✨ CREATE
/*

*/

CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT 
	MONTH(OrderDate) AS monthi,
	DATENAME(MONTH, OrderDate) AS name,
	SUM(Sales) AS monthly_sales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate), DATENAME(MONTH, OrderDate)
)

-- DROP

DROP VIEW V_Monthly_Summary

-- ALTER

-- IN pGSQl we cn use Replace to alter the VIEWS
-- but in the Microsoft SQL server we dont have that option
-- 1. Drop
-- 2. then Recreate a new one

-- In the DISK storage, in the catalog, it will store META data and QUERY, it doesnt store any data 

-- VIEW only stores the QUERY, not DATA

-- 👍 USE CASE
-- Hides the complexity like separating the Complex queries


-- WHAT IS SCHEMA???????


-- Provide a VIEW that combines details from Orders, products, customers and employess


CREATE VIEW Sales.V_Combine AS (
	select
	o.CustomerID,
	o.ProductID,
	o.SalesPersonID
	from Sales.Orders o
	inner join Sales.Products p
	on o.ProductID=p.ProductID
	inner join Sales.Customers c
	on o.CustomerID=c.CustomerID
	inner join Sales.Employees e
	on o.SalesPersonID=e.EmployeeID
)



-- 👍USE CASE 

-- DATE Security, not tto show all columns to ALl persons
-- ony particluar columsn, by creating VIEW

-- Provide a View for the EU sales Team combines detaild from all tables
-- exeildes data releated to the USA

CREATE VIEW Sales.V_Combine_ExclUSA AS (
	select
	o.CustomerID,
	o.ProductID,
	o.SalesPersonID,
	c.Country
	from Sales.Orders o
	inner join Sales.Products p
	on o.ProductID=p.ProductID
	inner join Sales.Customers c
	on o.CustomerID=c.CustomerID
	inner join Sales.Employees e
	on o.SalesPersonID=e.EmployeeID
	where c.Country NOT IN  ('USA')
)