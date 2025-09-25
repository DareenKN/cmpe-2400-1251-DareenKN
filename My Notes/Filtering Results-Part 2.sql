-- Week 3 Day 1 16 Sep 2025
-- Filtering Data Continue

use dkinganjatou1_Northwind
go

-- Between and operator

select * 
from Products
--where UnitsInStock >= 30 and UnitsInStock <=40
where UnitsInStock between 30 and 40
-- boundary values are included

select * 
from dkinganjatou1_pubs.dbo.titles
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
use dkinganjatou1_ClassTrak
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


-- null is a speacial value : NOTE: CHEAT SHEET
select * 
from dkinganjatou1_Northwind.dbo.Customers
where region is null

select * 
from dkinganjatou1_Northwind.dbo.Customers
where region is not null




-- 19.09.2025
-- Review of Exercise we did in previous class
-- Make sure you have hard copy of the activity
-- and create Practice Database- Script available 
-- under database creation scripts

use dkinganjatou1_practice
go

select * 
from employees

-- PART A : Relational and Logical Operators

--1.	Select employees whose age is greater than 30.
select *
from Employees
where age > 30 

--2.	Select employees whose salary is less than 70000.
select *
from Employees
where salary < 70000

--3.	Select employees whose department is IT and city is Seattle.
select *
from Employees
where Department = 'IT' and city = 'Seattle'

--4.	Select employees whose department is HR or salary is greater than 80000.
select *
from Employees
where Department = 'HR' or Salary > 80000
--5.	Select employees not in the 'Finance' department.
select *
from Employees
where Department <> 'Finance'

--6.	Select employees whose age is greater than or equal to 35 and salary is less than or equal to 80000.
select *
from Employees
where age >=35 and Salary<=80000
--7.	Select employees whose age is less than 40 or city is  Boston.
select *
from Employees
where age < 40 or city ='Boston'
--8.	Select employees whose salary not equal to 75000.
select *
from Employees
where Salary <> 75000
--9.	Select employees whose department is IT and age between 25 and 35.
select *
from Employees
where Department ='IT' and age >= 25 and age <=35
--10.	Select employees whose city is New York or city is Los Angeles.
select *
from Employees
where city = 'New York' or city = 'Los Angeles'

--PART B: IN and BETWEEN Operators
--1.	Select employees whose department is in HR, IT, or Finance.
select *
from Employees
where Department in ('HR', 'IT', 'Finance')

--2.	Select employees whose city is in 'Chicago', 'Boston'.
select *
from Employees
where city in ('Chicago','Boston')

--3.	Select employees whose salary is between 60000 and 80000.
select *
from Employees
where salary between 60000 and 80000
--4.	Select employees whose age is between 28 and 40.
select *
from Employees
where age between 28 and 40

--Part C: LIKE Operator (Pattern Matching)
--1.	Select employees whose name starts with 'J'.
select *
from Employees
where name like 'J%'
--2.	Select employees whose name ends with 'n'.
select *
from Employees
where name like '%n'
--3.	Select employees whose name contains 'a'.
select *
from Employees
where name like '%a%'

--4.	Select employees whose city starts with 'S'.
select *
from Employees
where city like 'S%'
--5.	Select employees whose city contains 'o'.
select *
from Employees
where city like '%o%'
--6.	Select employees whose name starts with 'O' and ends with 'u'.
select *
from Employees
where name like 'o%u'
--7.	Select employees whose department contains 'I'.
select *
from Employees
where Department like '%i%'
--8.	Select employees whose name has second letter 'a'.
select *
from Employees
where name like '_a%'
--9.	Select employees whose city has 6 letters.
select *
from Employees
where city like '______'
--10.	Select employees whose name contains 'e' anywhere.
select *
from Employees
where name like '%e%'

-- Email format a@a.com  - a means atleast one letter should be there  at 2 letters should be there 
-- where email like '_%@_%.__%' -- Characters
-- where email like '[a-z]%@[a-z]%.[a-z][a-z]%' -- Letters only

--BREAK TIME TIll 9:00 AM