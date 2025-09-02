-- PART:2 DATE and TIME FUNCTIONS...

-- YYYY-MM-dd HH:mm:ss International Standard (ISO_8601)

-- DATEPART(isoyear, GETDATE()) to get the week number

select DATEPART(week,GETDATE())

-- FORMATTING
-- FORMAT 
-- returned value as String..
-- It formats date and time value...
-- >> format - 'dd/MM/yyyy'
-- >> format only for month and year >> MMM yy
-- >> default culture : en-us
select FORMAT(GETDATE(),'dd-rabu-MM-rabu-yyyy',optional)

select FORMAT(GETDATE(),'dd/MM/yyyy','ja-JP')
select FORMAT(GETDATE(),'D','fr-FR')

-- Casting , changing datatype into another data type...

select 
OrderID,
FORMAT(OrderDate,'MM') as dd, -- >> (week number) sunday-0. monday-1
FORMAT(OrderDate,'MM') as ddd, -- >> (shoert of week) Sun,Mon,tue
FORMAT(OrderDate,'MMMM') as dddd, -- >> full abbrivation - unday,Monday
FORMAT(OrderDate,'MMMMM') as ddddd
from Sales.Orders

select 
OrderID,
FORMAT(OrderDate,'MM') as dd, -- >> (week number) sunday-0. monday-1
FORMAT(OrderDate,'MMM') as ddd, -- >> (shoert of week) Sun,Mon,tue
FORMAT(OrderDate,'MMMMM') as dddd,
FORMAT(OrderDate,'MMMMM') as ddddd
from Sales.Orders
select 
OrderID,
FORMAT(OrderDate,'MM') as dd, -- >> (week number) sunday-0. monday-1
FORMAT(OrderDate,'MMM') as ddd, -- >> (shoert of week) Sun,Mon,tue
FORMAT(OrderDate,'MMMMM') as dddd,
FORMAT(OrderDate,'MMMMM') as ddddd
from Sales.Orders

select CONCAT('DAY',' ',FORMAT(CreationTime,'ddd'),' ', FORMAT(CreationTime,'MMM'),' ','Q',DATEPART(QUARTER,CreationTime),' ', YEAR(CreationTime),' ', FORMAT(CreationTime,'hh:mm:ss tt')) from Sales.Orders
-- >> DAY Wed Jan Q1 2025 12:34:56 PM

select CONCAT('DAY',' ',DATENAME(WEEKDAY,CreationTime),' ', DATENAME(MONTH,CreationTime),' ','Q',DATEPART(QUARTER,CreationTime),' ', YEAR(CreationTime),' ', FORMAT(CreationTime,'hh:mm:ss tt')) from Sales.Orders
-- >> DAY Wednesday January Q1 2025 12:34:56 PM

select CONCAT('Q',DATEPART(QUARTER,CreationTime)) from Sales.Orders


select FORMAT(CreationTime,'d') from Sales.Orders
-- >> Wednesday, January 1, 2025

select FORMAT(GETDATE(),'hh:mm:ss tt') from Sales.Orders
-- 09:53:31 AM

-- NUMBERS

SELECT FORMAT(ROUND((80/1000.0),2),'P')

select Format(123456,'f')

-- CONVERT
-- Changing dataType

-- String to Integer

select CONVERT(int,'12344')-- from Sales.Orders
-- datetime for both 
select CONVERT(date,'09-12-2025')
select * from Sales.Orders

-- CAST >> DIRECT and as simple... 
select CAST(OrderDate as varchar) from Sales.Orders

SELECT SQL_VARIANT_PROPERTY(CAST(OrderDate AS VARCHAR), 'BaseType') AS DataType
FROM Sales.Orders;
