
select OrderID, c.FirstName, p.Product,o.Sales,p.Price, e.FirstName, o.Sales*p.Price as TotalPrice
from Sales.Orders as o
LEFT JOIN Sales.Customers as c
on o.CustomerID=c.CustomerID
-- this top becames one TABLE and then it will macth with the bottom table... like this flow goes
-- Seleect is just what u want to see on the result only, 
-- benath this will happen like this.....
LEFT JOIN Sales.Products as p
on o.ProductID=p.ProductID
LEFT JOIN Sales.Employees as e
on o.SalesPersonID=e.EmployeeID

