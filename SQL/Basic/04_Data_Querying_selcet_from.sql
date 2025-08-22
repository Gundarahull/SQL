select * from customers

-- this a comment for the single line

/* THIS 
IS 
A multiple line
comment */

select *    -- 2. then fetch the columns we want
from orders --  1. first it will go to the table

select 
	first_name,
	score 
from customers


-- WHERE (condition)
select *		--3
from customers	 --1.
where score != 750	 --2

select * from customers where country= 'Germany'
-- when the values containers characters need to put , single ' '
-- when the column name have characters like first_name
select * from customers where first_name= 'Maria'

-- SORT (Sorting the data)
-- deafult always Ascending order

select *			-- 3
from customers		-- 1
order by score desc	-- 2 order by score asc

-- Nested Sorting (sorting nestedly with 2 columns)
-- this will use when the sorting have some duplicates to avoid this type then again we add another field to sort that...
select *			-- 4
from customers		-- 1
order by
	country asc,	-- 2
	score desc;		-- 3
-- asc: refres to the alphabetically


-- Group BY 
-- combines the same values in the column....

-- the cplumn which is in the select block when we apply the group by, it should have to be in group by or in the aggregattion

select country , min(score) as min_score -- as (ALIAS)
from customers
group by country

-- RULE : ALL COLUMNS IN the selct must be either aggregated or included in the GROUP BY 


select 
	country, 
	sum(score) as total_score,
	COUNT(id) as no_of_customers
from customers
group by country

-- HAVING 

-- whenEver set the condition in the group BY
-- ** filters the data after aggregation **

select 
	country,
	sum(score) as total_score
from customers
group by country
having SUM(score)>800


/* EXECUTION ORDER
	SQL Query Logical Execution Order

		1. FROM / JOIN – Pick the table(s) and join them if needed.

		2. WHERE – Filter rows (row-level filtering).

		3. GROUP BY – Group the remaining rows.

		4. AGGREGATE FUNCTIONS – Compute aggregates like SUM(), AVG(), COUNT().

		5. HAVING – Filter groups (group-level filtering).

		6. SELECT – Choose the columns/expressions and assign aliases.

		7. ORDER BY – Sort the result.

		8. LIMIT / OFFSET – Restrict number of rows returned.SQL Query Logical Execution Order

*/


select AVG(score) as average_score,country
from customers
where score !=0
group by country
having AVG(score)> 430


-- DISTINCT(unique values)

-- only Once

-- in the dsitinct only we can use only one parameters --  distinct(country,score)

-- distinct will slow down the query

select distinct(country)
from customers

-- TOP (limit)
-- top is like limit how many rows we want to see...
select 
	TOP 3
	* 
from customers

select top 2*
from customers
order by score asc;

/*
	CODING ORDER
		1.SELECT
		2.DISTINCT
		3.TOP
		3.1 .Aggregation 
		4.FROM
		5.WHERE
		6.GROUP BY
		7.HAVING
		8.ORDER BY
*/
