
-- DATE and TIME Functions (timeStamp)
-- ALWYAS Rsult will be 'INT' 
-- Date FORMAT --->> year-month-date
-- Time Format --->> Hours:Minutes:Seconds

-- WAYS TO FETCH Date and Time
select
OrderID,
CreationTime,
'2025-09-78' as Hard_coded,
GETDATE() -- to get the current TimeStamp
from Sales.Orders

-- Current TimeStamp
-- GETDATE()

-- 1. ✨PART EXTRACTION

-- 1.1. 🎯♦️ DAY | MONTH | YEAR

select YEAR(CreationTime) as only_year from Sales.Orders
select MONTH(CreationTime) as only_month from Sales.Orders
select DAY(CreationTime) as Only_Date from Sales.Orders

-- 1.2. 🎯♦️ DATEPART to fetch the internal data like year, month, data, quarter, weekofday etc
select DATEPART(YEAR,CreationTime) from Sales.Orders
select DATEPART(MONTH,CreationTime) from Sales.Orders
select DATEPART(DAY,CreationTime) from Sales.Orders

select DATEPART(HOUR,CreationTime) from Sales.Orders
select DATEPART(MINUTE,CreationTime) from Sales.Orders
select DATEPART(SECOND,CreationTime) from Sales.Orders
select DATEPART(MILLISECOND,CreationTime) from Sales.Orders

select DATEPART(WEEK,CreationTime) from Sales.Orders
select DATEPART(WEEKDAY,CreationTime) from Sales.Orders -- Sunday-1 Monday-2 Tuwsaday-3 like this

select DATEPART(QUARTER,CreationTime) from Sales.Orders
select DATEPART(DAYOFYEAR,CreationTime) from Sales.Orders


-- 1.2. 🎯♦️ DATENAME() to know the name of the YEAR, MONTH,DAy
-- returns as a String in the DATENAME()
select DATENAME(MONTH,CreationTime) as name_of_the_month from Sales.Orders
select DATENAME(WEEKDAY,CreationTime) as name_of_the_week from Sales.Orders
select DATENAME(DAY,CreationTime) from Sales.Orders -- In the string Format....

-- 1.3. 🎯♦️ DATETRUNC() to i want upto this only (remaining will go to the intial point if time 00, day, date 01)
-- Reseting remaining
select DATETRUNC(YEAR,CreationTime) from Sales.Orders -- 2025-01-01 00:00:00.0000000
select DATETRUNC(MONTH,CreationTime) from Sales.Orders -- 2025-02-01 00:00:00.0000000
select DATETRUNC(DAY,CreationTime) from Sales.Orders -- 2025-01-05 00:00:00.0000000
select DATETRUNC(MINUTE,CreationTime) from Sales.Orders -- 2025-01-01 12:34:00.0000000

-- best use case will be while reports fetching the tickets whose are solved 
/*
select DATETRUNC(MONTH,CreationTime),count(id) from
Sales.Customers
where status in (12,13)
group by DATETRUNC(MONTH,CreationTime)
*/

-- EOMONTH - End of the Month.... ALWAYS ON THE DATE
-- EOMONTH(creationTime)

-- TO GET THE FIRST_of the month
select DATETRUNC(MONTH,CreationTime) as first_day_of_month from Sales.Orders

-- For making ""⚠️ reports""
-- Sales By year, Quarter, Month

-- how many orders wew places each year

select
DATETRUNC(YEAR,CreationTime) as year_only ,
COUNT(*) as no_of_orders
from Sales.Orders
group by DATETRUNC(YEAR,CreationTime)

-- in the another way....
select sum(orders_count) from (
select CreationTime,
COUNT(*) as orders_count
from Sales.Orders
group by CreationTime
) as subi


select SUM(monthly_count) from 
(
	SELECT 
    DATENAME(MONTH, CreationTime) AS order_month,
    COUNT(*) AS monthly_count,
    DATEPART(MONTH, CreationTime) AS intereg
FROM Sales.Orders
GROUP BY 
    DATENAME(MONTH, CreationTime),
    DATEPART(MONTH, CreationTime)
ORDER BY 
    DATEPART(MONTH, CreationTime)

) as stng

-- SHOW ALL THE ORDERS THAT WERE PLACES DURING THE MONTH OF FFEB??	

-- Filtering data using "" ⚠️ AN INTEGER IS FASTER than "" a string
select * from 
Sales.Orders
-- where DATEPART(MONTH,CreationTime)=2
 where DATENAME(MONTH,CreationTime)='February'

 -- DATA TYPES
 /*

 🎯 DATEPART  - INT
 🎯 DATENAME  - String
 🎯 DATETRUNC - Date&Time
 🎯 EOMONTH   - DATE
 S
 */