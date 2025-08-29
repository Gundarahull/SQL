-- STRING FUNCTIONS

-- 1. String MANIPULATION Functions
-- 2. String CALCULATION Functions only LEN()
-- 3. String EXTRACTION Functions


-- MANIPULATION FUNCTIONS
-- 1.Concat Func
-- Concatenate First_name and country into one column
-- CONCAT() automatically converts non-string types (like INT, FLOAT, DATE) into strings internally before concatenating.
select * from customers

select CONCAT(first_name,'-',country) as nameCOuntry from customers

select CONCAT(id,score,first_name,country) as nameCOuntry from customers


EXEC sp_help 'customers';

-- 2. UPPER -into uppercase
-- upper() required only 1 parameter

select UPPER(first_name) from customers

-- 3. LOWER
select LOWER(first_name) as lowe from customers where first_name='Rahul'

-- 4.TRIM 
-- Remove leading and trailing Spaces


-- to find the spaces 
select
first_name,
LEN(first_name) -- length of the data
from customers
where first_name like '% %'

select 
first_name
from customers 
where first_name !=TRIM(first_name)

select * from 
	(
	select 
	first_name,
	LEN(first_name)-LEN(TRIM(first_name)) as cal
	from customers
	) 
as calculation where cal>=1

-- REPLACE 
-- REPLACE (targetd_column || data,'old value','new value')
-- select first_name, REPLACE(first_name,'-','') as replcaced from customers


-- EXTRACTION FUNCTIONS
-- 1. LEFT (at the starting)
-- LEFT(column_NAME, how many characters)
select first_name , LEFT(first_name,3) from customers

-- 2. RIGHT (at the Ending)
-- RIGHT(column_NAME, how many characters)
select first_name , RIGHT(first_name,3) from customers

-- 3. SUBSTRING (IN THE MIDDLE SOMEWHERE)
-- SUBSTRING(column_NAME, start of the character, end of the character(how many characters we need to sub))
-- DYNAMIC
-- SUBSTRING(column_NAME,start, upto end of the data use LEN())>> i think it dont throw the error...
-- excludes the LAST INDEX (means) if 5, it will go upto 4 characters onlt
-- RAHUL
-- R:1 st charcater
-- A:2 nd charcater
-- H:3 rd charcater
-- U:4 th charcater
-- L:5 th charcater
-- SUBSTRING('RAHUL,2,2) >> AH
select first_name, SUBSTRING(first_name,2,LEN(first_name)-2) from customers


select 'RAHUL', SUBSTRING('RAHUL',2,2)



