-- DATE ADD AND SUB Functions

-- DATEADD(what_we_need_to_change,+-times,on_which_column)

select 
DATEADD(day,5,CreationTime) as new_date,
DATEADD(day,-5,CreationTime) as sub_date
from 
Sales.Orders

-- year
-- month
-- day

-- DATEDIFF(what_we_need_to_change,Start_date,end_date)

select 
DATENAME(Month,CreationTime) as name_of_month,
DATEDIFF(day,OrderDate,ShipDate) as day_differ
from Sales.Orders

-- Caluclate the age of the Employess
select 
DATEDIFF(YEAR,BirthDate,GETDATE())
from Sales.Employees

-- Find the average Shipping duration in days for each month
select 
DATENAME(Month,CreationTime) as name_of_month,
AVG(DATEDIFF(day,OrderDate,ShipDate)) as average_Shipping_duration
from Sales.Orders
group by DATENAME(Month,CreationTime)

-- Find the number of days between each order and previous order
select OrderDate from Sales.Orders

SELECT 
    OrderDate,
	-- lag is the window function---
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS PrevDate,
    DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) AS DaysDifference
FROM Sales.Orders;

-- ISDATE
-- CHeck the datatype if the value
-- 1 if its true

select ISDATE(OrderDate) from Sales.Orders
/*
CASE
	WHEN (ISDATE(OrderDate)=1)
		THEN
			--do something
		ELSE
			--do something

END
*/

SELECT
    OrderID,
    OrderDate,
    CASE 
        WHEN ISDATE(CreationTime) = 1 THEN 'Valid'
        ELSE 'Invalid'
    END AS DateStatus
FROM Sales.Orders;











