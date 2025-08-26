-- To combine the Tables, we have two options 
--  1 . Combinw with Columns (JOINS) -> WIDER
--  2 . Combine with Rows  (SETS) -> Longer


-- Combine the data to get the BIG-PICTURE
-- TO GET The EXTRA info...

-- >> "NO JOINS"
-- get the data without joining the tables..

select * from customers;
select * from orders;

-- >> "Inner JOIN"
select * from customers 
inner join orders
on customers.id=orders.customer_id

-- how it works
-- the customers id will match orders customers_id, yeah matched then go through all ids then another customer id then ala ala ayithundhi anamata...

-- >> "LEFT JOIN"
select * from customers
left join orders
on customers.id=orders.customer_id
where order_id IS NULL

-- Working 
-- first it will set the data into result then search for the matching id into right table one...

-- >> "RIGHT JOIN "

select * from customers
right join orders
on customers.id=orders.customer_id

select * from orders
left join customers
on customers.id=orders.customer_id


-- >> FULL JOIN
-- Returns both tables first match and then --> unmacthed
select * from customers
full join orders
on customers.id=orders.customer_id

-- first it will put the all data in the left side into the result then search then  like that...