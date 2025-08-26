-- WHERE
-- 1 . Comparsion Operators
-- compre two things
-- Main SceNARIOS where we use the condition
		-- 1.1 - Column1 = Column 2  >> users.id=customers.user_id
		-- 1.2 : column = value      >> id= 1234
		-- 1.3 : function = value    >> lower(name)='rahul' 
		-- 1.4 : expression = value  >> mobileNumber%100 = 2
		-- 1.5 : subQuery = value  

-- First Opeartor --  " = " (Equals)
select * from customers where country='Germany'

-- Second Operator -- " != || <> " (Not Equals to)
select * from customers where country !='Germany'

-- Third Operator -- " > " (Greater than)
select * from customers where score>500

-- Fourth Operator -- " >= " (Greater than or Equal to)
select * from customers where score>=500

-- Five Operator -- " < " (Lesser than)
select * from customers where score<500

-- Sixth Operator -- " <= " (Lesser than or Equal to)
select * from customers where score <=500

-- ************************************************************************************************************

-- 2 . Logical Operators
-- AND operator fullfills the all conditions
select * from customers where country='USA' and score >500 -- and id=7

-- OR operator fullfills any one of the condition
select * from customers where country='USA' OR score >500 or id=4

-- NOT 

	-- Flip each comparison to its opposite.
	-- Flip AND ↔ OR.
	-- Apply to the whole expression inside the NOT.

select * from customers where NOT(score <500)

-- same reverse
select * from customers where score>=500


-- ************************************************************************************************************

-- 3 . Range Operators
-- Betweeen (Lower Boundary -- Upper Boundary)(Inclusive) we need two things to do this
select * from customers where score between 100 and 500

-- we can write this also...
select * from customers where score>=100 and score<=500

-- ************************************************************************************************************

-- 4 . MemberShip Operators
-- IN (Which is in the LIST)
select * from customers where country='Germany' or country='USA'

-- In another Method
select * from customers where country IN ('Germany','USA')

-- ⚠️⚠️⚠️⚠️************************************************************************************************************

-- 5. SEARCH Operator (IMPORTANT ONE)

-- LIKE OPERATOR

-- >> M%
--		M should be at the last of the Word , then remaining anything it will be fine
-- >> %in
--		at the last should be 'in' before this anyhing will be fine
-- >> %r%
--		between the word , if 'r' presnts its satisfy
-- >> __g%
--		at the thitd position should be 'g' then anything is fine

select * from customers where first_name LIKE 'M%'
select * from customers where first_name LIKE '%n'

select * from customers where first_name LIKE '%r%'

select * from customers where first_name LIKE '__o%'


SELECT '[' + first_name + ']' AS name, 
       LEN(first_name) AS len
FROM customers
WHERE first_name LIKE '__o%';




