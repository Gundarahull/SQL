-- RECURSIVE CTE

-- LIKE LOOPS???

-- HIERARCHY Structure????

-- Query Querying ITSELF...

-- Genarate a Sequnce of NUmbers from 1 to 20..

-- Anchor Query and Recursive Query

with CTE_series as(
	-- Anchor Query
	select 
	1 as my_num

	UNION ALL

	-- Recursive Query
	select 
	my_num+1
	from CTE_series
	where my_num<20
)
select 
* 
from CTE_series
OPTION (MAXRECURSION 1000)
-- limit only 100 we can change this

-- show the employee hierrachy by 
-- displaying each employees level within the organization

select * from Sales.Employees