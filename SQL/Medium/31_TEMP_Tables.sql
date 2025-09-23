-- TEMP TABLES

-- as in the name, this are just temporary tables, they will delete automatically when the session end 
-- session means - time between connecting and disconnection of the Database Server...

-- Syntax

Select
*
INTO #TEMP_Employees_Table -- Inserting into TEMP table
from Sales.Employees

select * from #TEMP_Employees_Table -- fteching the Details...

-- we can analyize with temp table....

-- we can copy the temp table into desired table to STore the modified data..



-- DATABASE will store the temp tables in the Disk Storage (temp) and catlog too....

