-- Conditional Logic


/*
CASE (Start of the block)
	WHEN (cond1) THEN process>> result1
	
	WHEN (cond2) THEN process>> result2
	
	... like so many conditions
	
	ELSE result 
END (End of the block)
*/

-- if we didnt use ELSE, it will get NULL

-- USE CASE 
-- CATEGORIZING THE DATA

-- GEnerate a report, showing the total sales. HIGH: sales>50 , MEDIUM , Sales 20-50, Low: <=20, sort the result from low to high

select COUNT(categories) as count_of_categories,categories from (
	SELECT 
	CASE
		WHEN Sales>50 THEN 'HIGH'
		WHEN Sales between 20 and 50 THEN 'MEDIUM'
		ELSE 'LOW'
	END as categories
	from Sales.Orders
) as subi
group by categories
order by count_of_categories 


-- RULES
-- Each condition of the result should be in same DataType
-- we can use in select, join, group any where .. intersting

-- Retrive employee details with gender displayed as full text

select 
Gender,
CASE

	WHEN Gender='M' THEN 'Male'
	WHEN GENDER = 'F' THEN 'Female'
	ELSE 'Others'

END as gender_full_text
from Sales.Employees


-- Retrieve customer details with abbr country cose
 select * from Sales.Customers

 select Country,
 CASE
	WHEN Country='Germany' THEN 'GER'
	WHEN Country='USA' THEN 'US'
	ELSE 'OTH'
 END as short_country
 from Sales.Customers

 -- Count how many times each customer has made an order with sales>30

 select
 count(c.CustomerID) as count_of_orders,
 CONCAT(c.FirstName,c.LastName) as full_name
 from Sales.Orders as o
 inner join Sales.Customers as c
 on o.CustomerID=c.CustomerID
 where Sales>30
 group by c.CustomerID, CONCAT(c.FirstName,c.LastName)
 order by count_of_orders

