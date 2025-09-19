-- CTE (Common Table Expression)

-- its almost like a Subquery
-- but Subquery we can place this only in One place whether select, from, join, wher

-- whereas in the CTE, we can use in many places, its creates a virtual table, we can use that virtual table within the main query as many times...



-- RE_USE
-- Modularity (Smaller Chunks)

--CTE TYPES
-- 🎯♦️ None-Recursive CTE

-- ✨ StandAlone CTE

-- Independent , doesnt depends on any thing

-- WITH CTE-NAME AS
--(
--	SELECT 
--	* 
--	from table-name
--	where something
--)

-- ⚠️ Cant use order by in CTE,SubQuery,Views 

-- FInd the total sales per cutsomer

WITH CTE_cus_ty AS 
(
	select 
		CustomerID,
		SUM(Sales) as tSales_cus
	from Sales.Orders
	GROUP BY CustomerID
)
select  
*
from Sales.Customers  c
inner join CTE_cus_ty  ct
on c.CustomerID=ct.CustomerID

---------------------------------------------------------------------------------------------------------------

-- ✨ Multiple StandAlone CTE
/*
WITH CTE_cName1 AS
(
	select
	* 
	from TableNAme
	where something
),
CTE_cName2 AS
(
	select 
	* 
	from TableName2
	where soemthing
)*/

-- Find the total Sales per customer
-- find the last order date per customer

SELECT 
	*
from (
	--Sub Query
	SELECT 
		CustomerID,
		DATETRUNC(DAY,CreationTime) as dty,
		SUM(Sales) OVER(PARTITION BY CustomerID) as tc,
		ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY DATETRUNC(DAY,CreationTime) DESC) AS row_num
	FROM Sales.Orders
) as sumi
where row_num=1

-- ANOTHER WAY USING "CTE"
WITH CTE_total_sales AS
(
	select
	CustomerID,
	SUM(Sales) as tc
	from Sales.Orders
	GROUP BY CustomerID

),CTE_latest_order_date as
(
select 
	MAX(CreationTime) as maxi_date,
	CustomerID
from 
Sales.Orders
GROUP BY CustomerID
)
select
	* 
from CTE_total_sales 
inner join CTE_latest_order_date
on CTE_total_sales.CustomerID=CTE_latest_order_date.CustomerID
inner join Sales.Customers c
on CTE_total_sales.CustomerID= c.CustomerID

---------------------------------------------------------------------------------------------------------------

-- ✨ NESTED CTE
/*
CTE_cName1-- Purely Independent
WITH CTE_cName1 AS
(
	select
	* 
	from TableNAme
	where something
),
CTE_cName2 -- is depened on the CTE_cName1 , so CTE_cName2 is a Nested CTE
CTE_cName2 AS
(
	select 
	* 
	from CTE_cName1
	where soemthing
)*/
-- Main Query can access CTE_cName1 and CTE_cName2


-- Find the total Sales per customer
-- find the last order date per customer
-- Rank Customers based on their Total sales per customer

select 
	RANK() OVER(ORDER BY tot_sal) as ruki ,
	CustomerID,
	tot_sal,
	dati
from (
	select 
		CustomerID,
		SUM(Sales) OVER(Partition BY CustomerID) as tot_sal,
		DATETRUNC(DAY,CreationTime) as dati,
		ROW_NUMBER() OVER(Partition BY CustomerID ORDER BY DATETRUNC(DAY,CreationTime) DESC) as Rowi
	from Sales.Orders 
) as sumi
where Rowi=1



-- USING CTE
 WITH CTE_total_sales AS
 (
	 select 
		CustomerID,
		SUM(Sales) as to_sa
	 from Sales.Orders
	 GROUP BY CustomerID
 ),
CTE_last_order AS 
(
	select 
		CustomerID,
		MAX(CreationTime) as last_Date
	 from Sales.Orders
	 GROUP BY CustomerID
),
CTE_rank_per_cust AS 
(
	select
		CustomerID,
		RANK() OVER(ORDER BY to_sa DESC) as Rabki
	from 
	CTE_total_sales
)
select 
	c.CustomerID,
	FirstName,
	ct.to_sa,
	clo.last_Date,
	cr.Rabki
from Sales.Customers c
inner join CTE_total_sales ct
on ct.CustomerID= c.CustomerID
inner join CTE_last_order clo
on clo.CustomerID=c.CustomerID
inner join  CTE_rank_per_cust cr
on cr.CustomerID=c.CustomerID


-- BEST PRACTICES
-- before wriring any CTE, try to merge CTE existed ones