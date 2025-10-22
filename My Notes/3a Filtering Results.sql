-- Week 2 Day 3 12 Sep 2025
-- Filtering Data

use harsimrana_Northwind
go

select distinct CITY as 'Customer City' 
from Customers

select top 4 with ties *
from Employees
order by BirthDate desc

-- Today's work
-- filtering 

select * 
from Employees
where EmployeeID > 5  -- employee id greater than 5

-- Relational Operator
/*
=		 Equal to 
!=, <>   Not equal to 
>		 Greater than
>=		 Greater than equal to
<		 Less than
<=		 Less than equal to
!>		 Not Greater than
!<       Nor Less than


Logical operators - To combine conditions
C#	SQL
||  or		Logical or   - True if one of the conditions is true
&&	and		Logical and  - True if all the conditions are true
!	 !		Logical Not	
*/

select *
from harsimrana_Northwind.dbo.Employees
where EmployeeID = 5   -- Employee id is 5

select *
from harsimrana_Northwind.dbo.Employees
--where EmployeeID <> 5   -- Employee id is not 5
where EmployeeID != 5   -- Employee id is not 5

-- You can perform simple calculations without targeting any table
select 2 + 3 as 'Sum of 2 + 3'
select (2.4 * 4 + 6.7)

/*
Ex 01
	Write a select query that will display 
	the title id, title name, title category, 
	price and royalty from 
	publishers database, where the royalty is more than 10
*/
/*
 Which database			: publishers	
 Which Table			: titles
 What columns			: title_id, title, type, price, royalty 
 Condition				: royalty > 10
 sorting involved		: No
 Change column headers	: No
*/
use harsimrana_pubs
go

select title_id,
       title,
	   [type],
	   price,
	   royalty
from titles
where royalty > 10

-- fully qualified names

select titles.title_id,
       titles.title,
	   titles.[type],
	   titles.price,
	   titles.royalty
from harsimrana_pubs.dbo.titles
where royalty > 10

-- For typing convenience use alias for table name
select t.title_id,
       t.title,
	   t.[type],
	   t.price,
	   t.royalty
from harsimrana_pubs.dbo.titles as t
where royalty > 10

/*
Ex 02 :
Write a select query that will display title id, titlename
, title type, cost paid to purchase title, royatly paid
from publishers database for all publications 
where price is not 19.99
Provide the result according to purchase price in reverse order

 Which database			: Publishers	
 Which Table			: Titles
 What columns			: title_id, title, type, price, royalty
 Condition				: Price != 19.99 
 sorting involved		: price desc
 Change column headers	: No
*/

select t.title_id,
       t.title,
	   t.[type],
	   t.price,
	   t.royalty
from harsimrana_pubs.dbo.titles as t
where price <> 19.99
order by price desc


-- CHECKLIST
-- which database	        : 
-- which table		        : 
-- what columns		        : 
-- condition		        : 
-- sorting involved         : 
-- Look for column headers  :
/*
Logical operators - To combine conditions
C#	SQL
||  or		Logical or   - True if one of the conditions is true
&&	and		Logical and  - True if all the conditions are true
!	 !		Logical Not	
Ex. 3
Write a query that will display 
the title-id , title, type, price and royalty
form publishers database, for all publications
for those where the price is at least 11 and the royalty is 
greater than 10

*/

select t.title_id,
       t.title,
	   t.[type],
	   t.price,
	   t.royalty
from harsimrana_pubs.dbo.titles as t
where price >= 11 and royalty > 10

/*
Ex 04
 Write a select query that will display
 the title-id, title, type, price, and royaty 
 from publishers database, for all publications
 for this the price is at least 11 or the royalty is 
 greater than 10

*/
select t.title_id,
       t.title,
	   t.[type],
	   t.price,
	   t.royalty
from harsimrana_pubs.dbo.titles as t
where price >= 11 or royalty > 10


/*

 -- CHECKLIST
-- which database	        : 
-- which table		        : 
-- what columns		        : 
-- condition		        : 
-- sorting involved         : 

Ex 05
 Write query to display the product id,
 product name, unit price, units in stock 
 and reorder level for all products 
 in Northwind DB,
 for which the number of units in stock is 
 at leaset 30 but not greater than 40
*/

select ProductID,
	   ProductName,
	   UnitPrice,
	   UnitsInStock,
	   ReorderLevel
from harsimrana_Northwind.dbo.products
--where UnitsInStock >= 30 and UnitsInStock <= 40
where UnitsInStock >= 30 and UnitsInStock !> 40  -- not greater than
order by UnitsInStock desc

-- Order does matter
-- SELECT
-- FROM 
-- WHERE
-- ORDER BY 




