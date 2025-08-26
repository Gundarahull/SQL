-- DML Lnaguague (DATA MAnipulation Language)

INSERT INTO customers(
	id,
	first_name,
	country,
	score
	)
values(6,'Rahul','INDIA',900)


INSERT INTO customers(id,first_name,country,score)
values (7,'Sunny',null,897)

-- without wriring the column name we can directly insert the values
-- only iF we are matching with no of columns = no of values
INSERT INTO customers 
values (8,'Gunda','HYD',907)


-- INSERT USING SELECT (Mind Bending...)


CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE ,
	phone varchar(50) NOT NULL
	CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- **********************************************************

-- (MAD) inserting the data into TBALE, using select
-- we need to see and verify the column names need to set accordingly to the source TABLE to set in the table of TARGETED TABLE....
INSERT INTO persons (id,person_name,birth_date,phone)
select id,first_name,null,'phoneNumber' from customers

-- **********************************************************

-- ************* UPDATE************
-- when u dont write the where condition it will update Whole TABLE

-- *⚠️⚠️ Always use where to avoid UPDATING all rows unIntentionally

UPDATE customers
set score=NULL
where id=6

UPDATE customers 
set score=0,
	country='UK'
where id=8

update customers
set score=0
where score IS NULL

-- ************ DELETE ***************

DELETE FROM customers
where id>5

select * from customers

delete from persons -- it removes all rows but still processes them individually.
-- Does not reset auto-increment counters.

truncate TABLE persons -- Removes all rows instantly.
-- Resets identity/auto-increment to the seed value.

-- truncate is faster than DELETE

select * from persons 