-- Value Window Functions..
-- Window Analyatical Functions....

-- to get the values within rows previous , next , first and last rows

--  ✨ 1. LEAD(
--				Column_Name, 
--				how_many_rows_need_to_jump(default=1)
--				if_values_not_exist(default=null)
--				) || LAG() both are same
-- OVER(Parition BY optional, Order by Required)

-- Analyze the month-over-month performace by finidng the %change in sales
-- between current and previous month


select PERCENT_RANK() OVER(Order by ANILI)*100 as mom_perce , * from (
	select *, lag(sales_month,1,0) OVER(ORDER BY date_month) as ANILI from (
		select 
			DATEPART(MONTH,OrderDate) as date_month,
			SUM(Sales) as sales_month
		from Sales.Orders
		GROUP BY DATEPART(MONTH,OrderDate)
	) as sumi
) as sumiy

-- Customer Retention Analysis

-- Analyze customer loyality by ranking customers based on the average number of days between orders
select * from (
	select AVG(DATEDIFF(DAY,first_one,lead_one)) Over(partition by customerID) as difference,CustomerID from (
		select
			CustomerID,
			OrderDate,
			OrderDate as first_one,
			LEAD(OrderDate,1) Over(Partition by customerID order by Orderdate) as lead_one
		from Sales.Orders
		) as sumi
	) as sumiy
group by difference,CustomerID
order by CustomerID

-- Find the lowest and highest sales for each product
-- fidn the differnce betweeen current and lowest sales

select
	ProductID,
	MAX(Sales) OVER(Partition by ProductID) as maxi_pr,
	MIN(Sales) OVER(Partition by ProductID) as mini_pr,
	Sales,
	Sales-MIN(Sales) OVER(Partition by ProductID) as current_mini
from Sales.Orders


