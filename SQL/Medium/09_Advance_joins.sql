-- ADVANCED JOINS

-- >> LEFT ANTI JOINS 

select * from customers
left join orders
on id=customer_id
where customer_id is Null

-- >> RIGHT ANTI JOINS
select * from customers
right join orders
on id=customer_id
where id is NULL

-- >> FULL ANTI JOIN 
SELECT *
FROM customers
FULL JOIN orders
ON customers.id = orders.customer_id
WHERE customers.id IS NULL
   OR orders.customer_id IS NULL;

select * from customers
full join orders
on customers.id=orders.customer_id
where orders.customer_id is NOT NUll
and customers.id is NOT NULL

-- >> CROSS JOINS
-- ALL POSSIBLE COMBINATIONS
select * from customers
cross join orders