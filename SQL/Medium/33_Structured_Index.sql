-- INDEXs

-- without Scanning Everything...

-- Types of Indexs

-- Some indexs are better for searching , some other are better fo writing...

-- 🎯♦️ Structured INDEX



-- Tables will store in the form of Page 
-- PAge, The smallest unit of data storage in a database (8kb)


-- HEAP - Table without any particular SORT Method...


-- FULL TABLE SCAN



-- ✨ Clustered Index

-- First Sorting 

-- Grouping the pointer to Data page

-- Reading Index Page is so faster than the reading Data page..

-- Primary KEY



-- ✨ Non-Clustered Index

-- No Sorting 

-- FileId:PAgeNUmber refer to the pointer with row number like this 1>> 1:101:83 something..

-- One extra page is neede to scan the data



--- HOW to CREATE INDEX


-- Syntax

-- CREATE [CLUSTERED || NONCLUSTERED] INDEX index_name ON table_name (col1,col2)

-- Default is NONClustered Index

-- CREATE CLUSTERED INDEX IX_Customers_ID ON Customers (ID)

-- CREATE NONCLUSTERED INDEX IX_City_ID ON Customers (City)




CREATE 
CLUSTERED INDEX idx_DBCustomers_CustomerID 
ON Sales.DBCustomers(CustomerID)

-- CAnt more than one Clusterd INDEX

DROP INDEX idx_DBCustomers_CustomerID 
ON Sales.DBCustomers


CREATE
INDEX idx_DBCustomers_LastName ON Sales.DBCustomers(LastName)

-- Composite INDEX



Select * from Sales.Customers where Country='USA' and Score>700

--  ⚠️⚠️ RULE
--		THE COlumns of Index order must match the order in the QUERY

--		while fteching we need to write the conditipns in this order only, other wise indexs dont work 

--		Order is Important

--		it will use single condition which comes from first COlumn in Left side
--		>> this means INDEX will work on Country too

CREATE
INDEX idx_DBCustomers_CountryScore ON Sales.DBCustomers(Country,Score)


