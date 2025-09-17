-- Week 3 Day 1 16 Sep 2025
-- Filtering Data Continue

use harsimrana_Northwind
go

-- Between and operator

select * 
from Products
--where UnitsInStock >= 30 and UnitsInStock <=40
where UnitsInStock between 30 and 40
-- boundary values are included

select * 
from harsimrana_pubs.dbo.titles
where royalty between 10 and 16
--where royalty>=10 and royalty <=16

-- IN operator
-- Select products 
-- where unit price is 1 or 45 or 90
select * 
from Products
--where UnitPrice = 1 or UnitPrice= 45 or UnitPrice= 90
-- using in operator
where unitprice in (1, 45, 90)

-- IN true if the comparison value is equal to one value in the comma
-- separated list
select * 
from Products
--where UnitsInStock in ( 39, 17, 53, 0)
-- using logical and relational operator
where UnitsInStock = 39 or UnitsInStock = 17 or UnitsInStock= 53 or UnitsInStock=0 
/*
Ex02
Write a query to display the productid, 
name, unit price and units in stock
for all products in NorthwindTraders DB
for which the unit price is at least $20 
but not greater than $30
Write your solution using relation and logical operators
Rewrite the solution using between and and
*/
select ProductID,
	   ProductName,
	   UnitPrice,
	   UnitsInStock
from products 
--where UnitPrice between 20 and 30
where UnitPrice >= 20 and UnitPrice  <= 30
/* 
Ex 02
Write a query to display products
for which units in stock is anyone of the 
following values:
5,10,15,20,25,30
write solution using relation and logical operators
Rewrite using in operator
*/

select * 
from products
--where UnitsInStock in ( 5,10,15,20,25,30)
where UnitsInStock = 5  or
      UnitsInStock = 10 or
	  UnitsInStock = 15 or
	  UnitsInStock = 20 or
	  UnitsInStock = 25 or
	  UnitsInStock = 30 

-- Break Time : 08:50 - 09:00 
-- String comparison
use harsimrana_ClassTrak
go 

select * 
from Courses
where course_abbrev = 'CNT151' -- exact comparison is good with =

-- select courses where course abbrev starts with CNT
-- pattern matching like opertor 
select *
from Courses
where course_abbrev like 'CNT%'

/*
 Wildcard characters
 %  - any number of characters (including 0)
 _ (underscore) -any single character 
 [] - specify the list accesptable characters
 [^] - other than the list of characters
 [ - ] - specify the range of character
 [^ - ] - specify a range of unacceptable range 
*/
--Write a select query to display all courses whose abbreviation start with CNT
select *
from Courses
where course_abbrev like 'CNT%' -- starts with CNT

-- CNT1 , CNT CNT123445 CNTavc1232*73

select *
from Courses
where course_abbrev like 'CNT___' -- starts with CNT and then there should be maximun 3 letter afterwards

select *
from Courses
where course_abbrev like '[NC]%'  -- starts with letter or N and then n number of character

select *
from Courses
where course_abbrev like '[^CN]%' -- starts with other than the provided letters

select *
from Courses
where course_abbrev like '[a-h]%' -- starts with range of characters a to h

select *
from Courses
where course_abbrev like '[^a-h]%' -- starts with other than range of characters a to h provided


/*
Ex 10 : Binary 3 :

Write a select query to display all courses 
whose abbreviation contains the character 4
*/
select * 
from Courses
where course_abbrev like '%4%'

-- Any thing ends with 4
select * 
from Courses
where course_abbrev like '%4'

-- Assume we have email columns
-- @something .3 c 
-- abc @gmail.com
-- email like '_%@_%.___'

-- course description starts with either I or U
select *
from Courses
where course_desc like '[IU]%' -- what about without square brackets

-- course description starts with any of the letters from U to Z in the
select *
from Courses
where course_desc like '[U-Z]%'

-- course description should starts with any letter except I or U
select *
from Courses
where course_desc like '[^IU]%'

-- course description should starts with any letter except letters from S to Y
select *
from Courses
where course_desc like '[^S-Y]%'


-- null is a speacial value
select * 
from harsimrana_Northwind.dbo.Customers
where region is null