-- Window or Analaytical Functions

-- window is also grouping the things, but it will have the row level,
-- wheras in the group by, it compress the row levels with unique ones
-- row - level functions
-- returns a result for each row
-- if we want to keep aggregaration + keep details, we will go with WINDOW


-- where GROUP BY is not enough for us? then WINDOW will come into the picture...

-- find the total sales across all orders

select 
	SUM(Sales) 
from Sales.Orders

-- find the total sales for each product

select
ProductID,SUM(Sales) as total_sales_per_product 
from Sales.Orders
GROUP by ProductID

-- find the total sales for each product, additionally provide details such order id and order date
select 
ProductID,
SUM(Sales) as t_p,
OrderID,
OrderDate
from 
Sales.Orders
group by ProductID,OrderID,OrderDate
