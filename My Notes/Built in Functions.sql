-- Week 04 day 3: 25.09.2025
-- Built in functions

use dkinganjatou1_Northwind
go

declare @numberOfOrders int  
-- count() - will count the number of records/rows 
select @numberOfOrders= count(*) -- assigning value of count to variable
from orders
-- cast is used to convert int[numberOfOrder] value to string value
print 'Number of orders : ' + cast(@numberOfOrders as varchar(5))
-- covert function can be used to convert int[numberOfOrder] value to string value
print 'Number of orders : ' + convert(varchar(5), @numberOfOrders)

-- List order shipped within 10 days 
select OrderDate,
	   ShippedDate,
	   datediff(dd, orderdate, shippeddate) 'Number of days it takes'
from dkinganjatou1_Northwind.dbo.orders
where datediff(dd, orderdate, shippeddate) <=10
	  and
	  Shippeddate is not null  -- filtering out null values
order by 3  -- postion of column in your SELECTED LIST

select EmployeeID,
       LastName + ' ' + Firstname 'Name',
	   LastName + space(1) + Firstname 'Name',
	   LastName + space(1) + Firstname  + space(1)+ cast(HireDate as varchar(20)) 'Employee Details',
	   left( LastName + space(1) + Firstname  + space(1)+ cast(HireDate as varchar(20))
	       , 20) 'Employee Details left most 20 characters'
from Employees

order by 4

-- left(value , n ) : left() will return left most n characters
-- n is a number 
select * 
from Employees

-- math functions
select 20 / 10 % 4 *  2

select sqrt(25) as 'SqaureRoot of 25', 
       power(2, 3) ' 2 raise to power 3',
	   pi() as 'PI',
	   round(3.141592, 3),
	   abs( -5.4) as 'Absolute value',
	   tan(45), -- value is in radian  - sin, cos, tan, acos, atan
	   ceiling(4.3),
	   floor(4.3),
	   rand(),	  -- random value between 0 and 1
	   square(4), --4 raise to power 4 
	   sign(-7) -- sign -1 if negative 1 if number is positive 

-- BREAK TIME 09:10 am

-- String functions
select 'Simran' + 'Aulakh',
	   concat('Simran', 'Aulakh'),
	   CONCAT_WS(':', 'Simran', 'Aulakh'),	-- gives you flexiblity to provide separator
	   left('simran', 4),					-- left most 4 characters
	   right('Simran', 4),					-- right most 4 characters
	   -- Clean the data
	   ltrim ('   Simran  '),				-- removes white spaces from left side of string
	   rtrim ( '  Simran    '),				-- removes white spaces from right side of string
	   trim( '   Simran  '),				-- removes white spaces from both ends
	   'Simran' + space(1) + 'Aulakh',		-- space(n): adds n white spaces  
	   substring('SQL string', 2, 4),		-- start postion, number of characters
	   ASCII('A') as 'ASCII',
	   char(97) as 'Charcter value for 97',
	   nchar(25000) as 'Unicode Character'


select len('This is a string') 'Length of string',
	   datalength('This is a string'),
       datalength( convert( nvarchar, 'This is a string')),  -- retuns number of bytes used to represent an expression
	   charindex('story', 'This is a long story'),
	   charindex('is', 'This is a long story'),
	   replace('The company of Stevenson', 'Stevenson', 'Adam') -- It will replace 2nd argument with 3rd argument in provided string at 1
	   -- It will replace Stevenson with Adam

select Firstname
from Employees
where len(firstname) >= 5


