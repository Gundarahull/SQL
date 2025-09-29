-- ColumnStore Index

-- The data page will store the data Column By COlumn

-- split the data into HAlF by rows

-- then separate columns

-- then compression

-- Mappting for equally like things

-- values of the columns side by side in LOB page

-- i think for aggregartion FUnctions its best for Column storeINDEX


-- SYNTAX

-- CREATE [Clustred || nonclustered] [columnstore] Index idx_name ON table_name (col1,col2)


-- For one table

-- we need to have only one CLustred INDEX whether its a ROW or COlumn

-- ONLY ONE COLUMNSTORE Index allowed in table


