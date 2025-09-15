-- RANKing Window Functions..

-- 1. Sort 
-- 2. Integer Rank (Top_Bottom analyasis, (top 10, last 20 like this))
-- 3. Percentage Based Rank(Distrubtion_Analysis (top 20% of  product))


-- RANK SYNTAX
-- RANK() OVER(PARITION BY ProductID ORDER BY Sales(order by required one))
-- rank should be always EMPTY

-- 🎯♦️ INTEGER BASED RANKING

-- ✨ 1.ROW_NUMBER()
-- It deosnt care about Ties and give unique Rank Numbers

-- Rank the orders based on their sales from highest to lowest

select 
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) as row_numberi
from Sales.Orders

-- ✨ 2.RANK
-- gives same rank to duplicates (TIES)
-- it will give gaps? skipping rank number if its duplicates then it will go to, next number,according to the Position
-- ranks based on value, not row position. Equal values share the same rank, and the next rank skips ahead.
select 
	Sales,
	RANK() OVER(ORDER BY Sales DESC) as row_numberi
from Sales.Orders

-- ✨ 3.DENSE_RANK
-- handle ties
-- No gaps

select 
	Sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) as row_numberi
from Sales.Orders
-- its the good one like normal ones...

-- FIND the top highest sales for each product
select * from (
	select 
		ProductID,
		Sales,
		RANK() OVER(PARTITION BY ProductID Order by Sales DESC) as rowi
	from Sales.Orders
) as sumi
where rowi=1

-- Find the lowest 2 Customers based on their total Sales

select  top 2 * from (
select 
	c.FirstName,
	c.CustomerID,
	SUM(Sales)  as total
from Sales.Orders as o
INNER JOIN Sales.Customers as c
on o.CustomerID=c.CustomerID
GROUP BY c.FirstName,c.CustomerID
) as sumi
order by total asc

-- GENERATE UNIQUE IDs
-- in case of no primary keys
-- with ROW_NUMBER

select
* 
from Sales.OrdersArchive

-- ✨ 4.NTILE
-- Packet based
-- Bucket Size= Number of Rows/ Number of Buckets
--5/2=2.5 it will ceil
-- larger groups comes first
-- with ceil number will be grouped first,if there are any still remained then 2 grouped 
-- ** it should be filled with the bucket number **

select
	NTILE(1) OVER(ORDER BY Sales) as oneBucket,
	NTILE(2) OVER(ORDER BY Sales) as twoBucket,
	NTILE(3) OVER(ORDER BY Sales) as threeBucket,
	NTILE(4) OVER(ORDER BY Sales) as fourBucket,
	Sales
from Sales.Orders

-- Segemnet all orders into 3 Categoried high,medium, low sales

select 
	*,
	CASE
		when threeBucket=1 then 'HIGH'
		when threeBucket=2 then 'MEDIUM'
		when threeBucket=3 then 'LOW'
	END as catei
from (
	select
		NTILE(3) OVER(ORDER BY Sales DESC) as threeBucket,
		Sales 
	from Sales.Orders
) as sumi

-- In order to export the data, didvide the orders into 2 groups

-- using Primary key will be best wll using ntile...
select 
	OrderID,
	NTILE(2) OVER(Order BY OrderID) as groupi
from Sales.Orders


-- 🎯♦️ PERCANTAGE BASED RANKING
--  ✨ 1. CUME_DIST()
-- Cummulative Distrubtion
--  if any Ties,The position of the last occurenace of the same Value
-- row_position/total no of rows


--  ✨ 2. PERCENT_RANK()
--  if any Ties,The position of the first occurenace of the same Value
-- row_position-1/total no of rows-1


-- Find the products that fall within the highest 40% of prices

select * from (
	select 
		PERCENT_RANK() OVER(Order by Price)*100 as per_rank,
		Price
	from Sales.Products
) as sumi
where per_rank<=40











