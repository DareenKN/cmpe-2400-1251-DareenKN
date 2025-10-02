
-- Week 4 day 03: 26.09.2025
-- bulit in functions

use NorthwindTraders
go

declare @numberOfOrders int 

select @numberOfOrders = count(*)
-- count(): will count the number of records/rows
from Orders
-- cast is used to convert int [@numberOfOrders] value to string value
print 'Number of orders: ' + cast (@numberOfOrders as varchar(3))
-- Covert can be used to convert int [@numberOfOrders] value to string value
print 'Number of orders: ' + convert ( varchar(3), @numberOfOrders)

select lastname +' ' +firstname 'Name',
	   lastname +space(1) +firstname 'Name',
	   cast(EmployeeID as varchar(5)) + ': '+ lastname +space(1) +firstname 'Name'
from employees

-- MATH funcitons
select 5 / 2 * 4 -- both operands are int, so it will int division
select 5.0 / 2 * 4 -- both operands are int, so it will int division

select sqrt(25) as 'Sqaureroot of 25',
	   POWER(2, 3) as '2 raise to power 3',
	   pi() as 'PI',
	   round( pi() , 3 ),
	   abs( -5.4 ) as ' Absolute value',
	   sin( 45),  -- sin, cos, tan, acos, atan
	   CEILING(3.3),
	   floor(3.3), 
	   rand()  'Random value', -- between 0 and 1
	   sign(-23), -- -1 if value is negative + 1 if positive
	   square(4)  -- 4 raise to power 2


-- String functions
select 'Simran' + 'Aulakh',
       concat('Simran', 'Aulakh'),
	   CONCAT_WS(':', 'Simran', 'Aulakh'),	-- gives you flexibility to provide separator
	   left('Simran', 4),					-- left most 4 characters
	   right('Simran', 4),					-- right most 4 characters
	   --clean data values
	   ltrim('  Simran  '),					-- removes white spaces from left side of string
	   rtrim('  Simran   '),                -- removes white spaces from right side of string
	   trim('   Simran   '),				-- remove white spaces from both sides of a string
	   'Simran' + space(1) + 'Aulakh',		-- Space(n): adds n white spaces
	   substring('SQL string', 2, 4),		-- start position, number of characters 
	   ascii('A') 'ASCII value',
	   char(97) as 'character for 97',
	   nchar(25000) as 'Unicode character'


select CONCAT_ws(' ', FirstName, LastName)
from Employees
-- BREAK TIME  :  8:52 am

select len('This is a string') 'Length of string',
       datalength('Simran'), -- returns the number of bytes used to represent an expression
	   datalength(convert(nvarchar,'Simran')),
	   charindex('story', 'This is a long story'),
	   charindex('is', 'This is a long story'), 
	   replace('The company of Stevenson', 'Stevenson', 'Adam')

select *
from employees
where len(firstname) >=5