-- VIEWS
-- DATA BASE Structure
-- SQL SERVER -> DATABASE -> SCHEMAS -> TABLES + VIEWS 


-- VIEWS also store the data, but we cant see them physically

--  ABSTRACTION LEVEL 
-- 3. VIEW LEVEL (to see the data)
-- 2. LOGICAL LEVEL (to design the models, tables, procedurs, functions etc)
-- 1. PHYSICAL LEVEL (Securing the Data, logs, caches etc)


-- VIEWS -> Virtual table which deosnt store data, its a rsult of query
-- its Abstrcation layer


-- Central Logic

-- We can use CTE as only one time in the main query , temporray 
-- but VIEWs can use multiple_times, logic will store as virtual table

---------------------------------------------------------------------------------------------------------


-- CREATE || UPDATE || DROP

-- Find the running total of sales per each Month

-- ** Running Total is like CUMMALTIVE One**

select 
		MONTH(OrderDate) as monthi,
		DATENAME(MONTH,OrderDate) as name,
		SUM(Sales) OVER(PARTITION BY  MONTH(OrderDate) ORDER BY MONTH(OrderDate) asc) as running_total,
		max(Sales) over()
from Sales.Orders;

-- Partition = “scope/group”
-- Order = “sequence inside that group”

-- here when we add, single aggregation function it has only value, so we cant display that right as single one, with all values
-- so we need to use OVER()
/*
SELECT 
    monthi,
    name,
    monthly_sales,
    SUM(monthly_sales) OVER(ORDER BY monthi ASC) AS running_total
FROM (
    SELECT 
        MONTH(OrderDate) AS monthi,
        DATENAME(MONTH, OrderDate) AS name,
        SUM(Sales) AS monthly_sales
    FROM Sales.Orders
    GROUP BY MONTH(OrderDate), DATENAME(MONTH, OrderDate)
) AS subi;
*/

/*
CREATE VIEW V_Monthly_Summary AS
(
	SELECT 
	MONTH(OrderDate) AS monthi,
	DATENAME(MONTH, OrderDate) AS name,
	SUM(Sales) AS monthly_sales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate), DATENAME(MONTH, OrderDate)
)
*/

select * from V_Monthly_Summary

-- REDUCE THE STEPS..

-- LIKE MODULAR

-- when we crete deafult schem is dbo.V_Monthly_Summary

