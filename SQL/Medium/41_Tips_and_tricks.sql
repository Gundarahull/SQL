-- SQL Tips and Tricks


-- ITs based on the size of the table...
-- it should be focus on readability..


-- BEST PRACTICES

-- ✅ Fetching the Data
---		select only whay u need
--		Distinct and order by are expenisve (use in necessrry cases)
--		For exploration >> limit Rows 

-- ✅ Filtering the Data
--		Avoid functions max in where, if any columns have an index..
--		use IN instead of OR (expensive function...)


-- ✅ JOINing the Data
---		Inner Join fast then left and right...
--		Prepare the data (conditioned one ) then JOIN

-- we can do this in this type..but its a bad practice..
select 
	o.orderId,
	c.FirstName
from Sales.Customers c, Sales.Orders o
where c.CustomerID=o.CustomerID


-- Stop repeating the same thing in the query...

-- ✅ AGGREGATING the Data	

--			 COLUMN STORE INDEX will be the best for aggregations

-- ✅ SUBQUERIES

--		using joins will be the best for medium size tables
--		exists will be best for large size based tables

-- ✅ DDL TABLE
--		AVOID VARCHAR and TEXT, TEXT is worse than the VARCHAR
--		USE VARCHAR until its necessary
--		AVOID uncessary length of the column like VARCHAR(255)
--		USE NOT NULL 

-- ✅ INDEXING
--		AVOID unnecessary Indexs and DROP unused 
