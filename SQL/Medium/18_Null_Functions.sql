-- NULL FUNCTIONS
-- nothing, no value, unknown yem ledhu ra ayya akkada


-- REPLACE FUnctions for NULL
-- 🎯♦️ ISNULL 
-- its fast
-- differnt for dbs
-- ISNULL(column_name,'no-data') >> static one
-- ISNULL (column_name_1,column_name_2) >> if in the column_name_1 has a null, then it will replace with the same row value of column_name_2

-- 🎯♦️ COALESCE 
-- its slow (avaialable to all dbs)
-- COALESCE(c1, c2, c3, c4, 'N/A')
-- It returns the first non-NULL value from left to right.
-- If all are NULL, it returns 'N/A'.

-- Find the average score of the customers

select AVG(COALESCE(Score,0)) from Sales.Customers

--	USE CASES
-- BEFORE DOING ANY AGGREGATIONS (Mathemactical Operation) , its best to use COALESCE, if any nulls are there
-- handling before JOINS, in the conditions otherwise we will loose the data...
-- before sorting the data...
-- Display the Full name of the Customers and add 10 bonus points

select
CONCAT(FirstName,' ',LastName) as Full_Name,
(COALESCE(Score,0)+10) as bonus_points,
LEN(CONCAT(FirstName,' ',LastName)) as length
from Sales.Customers

-- while sorting the data,
-- null will be the least value

-- Sort the customers from lowest to highest scores

select Score from  (
	SELECT Score,
       (SELECT MAX(Score) FROM Sales.Customers) AS maxi
FROM Sales.Customers
) as subi
order by COALESCE(Score,maxi + 1) asc

-- COMPARE FUNCTIONS
-- 🎯♦️  NULLIF (value1||column_1 , value2||column_2)
-- if value1=value2 then returns NULL

select NULLIF(score,350) from Sales.Customers -- >> if any score =350 it will returns NULL


-- Find the sales price for each order by divinfing the sales by quantity

select (Sales/NULLIF(Quantity,0)) as price from Sales.Orders

-- IS NULL , if its null its return true
-- IS NOT NULL , if its null , its return false

select * from Sales.Customers
where Score IS NOT NULL






