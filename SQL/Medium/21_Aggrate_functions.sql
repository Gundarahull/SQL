-- MULTI-ROW FUNCTIONS

-- Aggregate FUnctions...
-- takes the all rows or specicfed rows into the function (its multi)

-- COUNT()
-- SUM()
-- AVG()
-- MAX()
-- MIN() These all functions takes multiple row values right


-- find the total number of customers
select COUNT(CustomerID) as total_no_of_customers from Sales.Customers
select Sales, SUM(Sales) as toatl_sales, AVG(COALESCE(Sales,0)),MAX(Sales), MIN(Sales)  from Sales.Orders