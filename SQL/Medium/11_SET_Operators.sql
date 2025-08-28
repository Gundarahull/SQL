-- SETS
-- main is to combine the ROWS

-- Syntax and RULES
-- ⚠️RULE NO : 1 
-- SELECT statement (we can complex as possible by where, joins, group by) but doesnt use ORDER BY
-- SET operator
-- SELECT statement

-- ORDER BY column_name ⚠️

-- ⚠️RULE NO : 2
-- NO OF columns should be same in both tables (QUERIES)
-- If u set differnt differnct colum name the data will be merged 
-- FIrst query is the CONTROLLING one...

select FirstName,LastName
from Sales.Customers
UNION -- DISTINCT and remove duplicates
select FirstName,LastName --, salary 
from Sales.Employees


-- ⚠️RULE NO : 3
-- DATA TYPE SHOULD BE SAME IN columns should be same in both tables (QUERIES)


-- ⚠️RULE NO : 4
-- First Query Column Names will be visible in the Result

-- ⚠️ RULE NO : 5
-- columns should be macth (i mean yedhi yekkada undalo akkade)

-- UNION 
-- RETURNS only Unique ones and remove all duplicates

-- first see the macthing Column Names in both table then combine

select CustomerID,FirstName,LastName from Sales.Customers
-- UNION
select EmployeeID,FirstName,LastName from Sales.Employees;


-- UNION ALL (INCLUDE DUPLICATES)
select FirstName,LastName from Sales.Customers
UNION ALL
select FirstName,LastName from Sales.Employees


-- UNION ALL IS HAVE BETTTER PERFORMANCE

-- EXCEPT
-- RETURNS DISTINCT ROWS FROM THE FIRST QUERY 
-- THAT ARE NOT MATCHED || NOT FOUND
-- "" ONLY BELONGS TO THE FIRST QUERY SIMPLE ""

-- INTERESECT

-- RETURNS only common rows that too unique rows
-- Its almost like INNER JOIN
select FirstName,LastName from Sales.Employees
INTERSECT 
select FirstName,LastName from Sales.Customers


-- ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
-- COMBINE INFORMATION 
-- Similar info
-- think like this, suppose in a Company there are lot of depertments like BE,FE,INFRA all they have first_name and last_name
-- we want all employyes who are working in the Company then..
-- ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️


/*
select first_name,last_name,jod from BACKEND
union
select first_name,last_name, jod from FRONTEND
union
select first_name,last_name, jod from INFRA
order by jod desc
*/

select * from 
	(
		select FirstName,LastName from Sales.Customers
		UNION 
		select FirstName,LastName from Sales.Employees
	) as combined
where LastName='Goldberg' 

select * from Sales.Orders
-- select * from Sales.OrdersArchive
select * from Sales.Products

select
'Orders' as SourceTable,
p.Product, 
p.Price,
o.OrderID, 
o.OrderStatus,
o.ShipDate

from Sales.Products as p
inner join Sales.Orders as o
on p.ProductID=o.ProductID
UNION
select'OrdersArcheive' as SourceTable, p.Product, p.Price,o.OrderID, o.OrderStatus, o.ShipDate  from Sales.Products as p
inner join Sales.OrdersArchive as o
on p.ProductID=o.ProductID
order by OrderID asc

-- Implentation for DELTA check , (which are new ones)
-- better to do except (minus) with the direct WAREHOUSE one

-- CHECKING THE ALL THE DATA IS perfectly MIGRATED or not
-- using except


