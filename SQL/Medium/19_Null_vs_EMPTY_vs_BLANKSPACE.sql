-- NULL DOESNT KNOW whats the value..
-- empty string - '' no charcter
-- blank space - one or more space character

select DATALENGTH(''),DATALENGTH(' ')

-- LEN() → Counts characters (ignores trailing spaces).
-- DATALENGTH() → Counts bytes (includes trailing spaces).

--Trailing Spaces:
-- LEN() → Ignores them.
-- DATALENGTH() → Counts them.

-- DATA POLICY 
-- its best to INSERT as NULL

--TRIM() it will trim leading and trailing spaces

select DATALENGTH(TRIM(' RAHUL')),DATALENGTH(' ')
