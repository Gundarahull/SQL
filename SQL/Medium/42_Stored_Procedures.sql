--  Stored Procedures...
-- QUERIES in the Python???(MAy be Network Delays...)
-- We can execute the SP in the Python as well
-- How to execute the SP in python? (if the project in the PY)

-- SYNTAX

/*
CREATE PROCEDURE sp_procedure_name AS
BEGIN

	-- SOMe SQL statments

END

EXEC sp_procedure_name
*/

-- For US customers find the total number of customers and the average score

select
	count(CustomerID) as total_number , 
	AVG(Score) as avg_score
from Sales.Customers
where Country='USA'

-- INTO SP

CREATE PROCEDURE sp_US_SUMMARY AS
BEGIN
	select
		count(CustomerID) as total_number , 
		AVG(Score) as avg_score
	from Sales.Customers
	where Country='USA'
END

-- EXECUTION:

EXEC sp_US_SUMMARY


select * from Sales.Customers

-- PARAMETERS (INPUT)
CREATE PROCEDURE sp_params_summary 
@Country NVARCHAR(100)
AS
BEGIN
	select
		count(CustomerID) as total_number , 
		AVG(Score) as avg_score
	from Sales.Customers
	where Country= @Country
END

-- Execution

EXEC sp_params_summary @Country='USA';


-- TO ALTER and DEFAULT
ALTER PROCEDURE sp_params_summary 
@Country NVARCHAR(100)= 'USA'
AS
BEGIN
	select
		count(CustomerID) as total_number , 
		AVG(Score) as avg_score,
		@Country as country
	from Sales.Customers
	where Country= @Country;
	-----ANother ONE
	select
		count(OrderID) as too,
		SUM(Sales) as ts
	from Sales.Orders o
	join Sales.Customers c
	on o.CustomerId=c.CustomerId
	where Country=@Country
END

EXEC sp_params_summary 

EXEC sp_params_summary @Country='Germany'

-- T) DROP 
DROP PROCEDURE sp_US_SUMMARY

-- FInd the total no of orders and their sales

select * from Sales.Orders

select
	count(OrderID) as too,
	SUM(Sales) as ts
from Sales.Orders o
join Sales.Customers c
on o.CustomerId=c.CustomerId
where Country='USA'

-- VARIABLES

-- 1. Decalre Variable
-- If we want to decalre the varaibles 

-- we cant see the variables.....

ALTER PROCEDURE sp_params_summary
@Country NVARCHAR(100) = 'USA'
AS
BEGIN
    DECLARE @TotalCustomers INT, @avgScore INT;

    -- Just for info (optional)
    SELECT
        COUNT(OrderID) AS TotalOrders,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders o
    JOIN Sales.Customers c ON o.CustomerId = c.CustomerId
    WHERE c.Country = @Country;

    -- Store results in variables
    SELECT
        @TotalCustomers = COUNT(CustomerID),
        @avgScore = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @Country;

    -- Print with proper type conversion-- it should be Convert into VARCHAR
    PRINT 'TOTAL CUSTOMERS : ' + CAST(@TotalCustomers AS NVARCHAR(20));
    PRINT 'AVERAGE SCORE : ' + CAST(@avgScore AS NVARCHAR(20));
END;






-- IF ELSE

ALTER PROCEDURE sp_params_summary
@Country NVARCHAR(100) = 'USA'
AS
BEGIN
    DECLARE @TotalCustomers INT, @avgScore INT;

	IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score is NULL and Country=@Country)
		BEGIN
			PRINT('In the IF Condition and UPDATING THE SOURCE')
			UPDATE Sales.Customers
			SET Score=0
			WHERE Score is NULL and Country=@Country
		END;
	ELSE
		BEGIN
			PRINT('IN THE ELSE CONDITION')
		END;

    -- Just for info (optional)
    SELECT
        COUNT(OrderID) AS TotalOrders,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders o
    JOIN Sales.Customers c ON o.CustomerId = c.CustomerId
    WHERE c.Country = @Country;

    -- Store results in variables
    SELECT
        @TotalCustomers = COUNT(CustomerID),
        @avgScore = AVG(Score)
    FROM Sales.Customers
    WHERE Country = @Country;

    -- Print with proper type conversion
    PRINT 'TOTAL CUSTOMERS : ' + CAST(@TotalCustomers AS NVARCHAR(20));
    PRINT 'AVERAGE SCORE : ' + CAST(@avgScore AS NVARCHAR(20));
END;

EXEC sp_params_summary 


-- ERROE HANDLING 

-- TRY and Catch......

ALTER PROCEDURE sp_params_summary
@Country NVARCHAR(100) = 'USA'
AS
BEGIN
    BEGIN TRY
        DECLARE @TotalCustomers INT, @avgScore INT;

        -- Check for NULL scores and handle them
        IF EXISTS (
            SELECT 1 
            FROM Sales.Customers 
            WHERE Score IS NULL AND Country = @Country
        )
        BEGIN
            PRINT('In the IF Condition and UPDATING THE SOURCE');
            UPDATE Sales.Customers
            SET Score = 0
            WHERE Score IS NULL AND Country = @Country;
        END
        ELSE
        BEGIN
            PRINT('IN THE ELSE CONDITION');
        END;

        -- Info query (optional)
        SELECT
            COUNT(OrderID) AS TotalOrders,
            SUM(Sales) AS TotalSales
        FROM Sales.Orders o
        JOIN Sales.Customers c 
            ON o.CustomerId = c.CustomerId
        WHERE c.Country = @Country;

        -- Store results in variables
        SELECT
            @TotalCustomers = COUNT(CustomerID),
            @avgScore = AVG(Score)
        FROM Sales.Customers
        WHERE Country = @Country;

        -- Force an error for testing
        DECLARE @x INT = 1 / 0;  -- this will trigger CATCH

        -- Print the results
        PRINT 'TOTAL CUSTOMERS : ' + CAST(@TotalCustomers AS NVARCHAR(20));
        PRINT 'AVERAGE SCORE : ' + CAST(@avgScore AS NVARCHAR(20));
    END TRY

    BEGIN CATCH
        PRINT('Error Occurred: ' + ERROR_MESSAGE());
        PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(10)));
        PRINT('Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A'));
    END CATCH
END;
