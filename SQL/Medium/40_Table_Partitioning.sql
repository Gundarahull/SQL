-- SQL partitioning

-- Normally we divide the tables (paritions) by DATES

-- step: 1 : Creating a partition function

CREATE PARTITION FUNCTION PartitionByYear(DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31','2024-12-31','2025-12-31')

-- here we are setting the boundaries , left meaans the boundary will includes in the left part,
-- when we set right, it will includes in the right side boundary part....


-- To see
select * from sys.partition_functions


-- Step : 2 -- Creating Filegroups

ALTER DATABASE SalesDB ADD FILEGROUP FG_2023
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026


-- to DROP
ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023

-- To see
select * from sys.filegroups where type='FG'


-- STEP 3 : Create DATA Files .ndf to each fileGroup

ALTER DATABASE SalesDB ADD FILE
(
	NAME=P_2023,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2023.ndf'
) TO FILEGROUP FG_2023

ALTER DATABASE SalesDB ADD FILE
(
	NAME=P_2024,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2024.ndf'
) TO FILEGROUP FG_2024

ALTER DATABASE SalesDB ADD FILE
(
	NAME=P_2025,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2025.ndf'
) TO FILEGROUP FG_2025

ALTER DATABASE SalesDB ADD FILE
(
	NAME=P_2026,
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\p_2026.ndf'
) TO FILEGROUP FG_2026

-- To see
select * from sys.filegroups where type='FG'



-- STEP: 4 Partition Schema

-- Order should be in the SORT, from asc-desc
CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION PartitionByYear
to (FG_2023,FG_2024,FG_2025,FG_2026)


-- STEP 5: Create the partitioned Table

create table Sales.Orders_partitioned
(
	OrderID int,
	OrderDate Date,
	Sales INT
) ON SchemePartitionByYear(OrderDate) -- Column on which based we are going to do parttion

-- Step 6: Insert into the Table

INSERT into Sales.Orders_partitioned VALUES (1,'2024-01-01',100)


select * from Sales.Orders_partitioned

--the performnace will be too good, becuase we are dividing the parts of tABLE RIGHT...