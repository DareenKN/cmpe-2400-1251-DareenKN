use NorthwindTraders
go

-- top n - number of records
-- need top 5 recent orders
-- you need to sort your date
-- Then filter it
-- top n - give your the top n records

select top 5 *
from orders
order by orderdate desc

-- I need top n %

select top 1 percent *
from orders
order by orderdate desc

select *
from [order details]
order by quantity desc

-- run it with ties and without ties
select top 3 *
from [Order Details]
order by Quantity desc	

select top 3 with ties *
from [Order Details]
order by Quantity desc	

select top 5 *
from orders

select top 5 *
from [Order Details]

select top 5 with ties *
from [Order Details]
-- It will break when sorting [order by] is not used with ties

/*
	Importan point:
	When using top n
		Make sure to sort data arccording to requested criteria
			Otherwise database engine will pick primary for sorting
		Use top with ties always
*/

-- distinct
-- remove duplicate data from the returned
-- result set
select distinct country
from customers

-- If multiple columns are involved
-- Then any difference in any columns is going to define the uniqueness
select distinct categoryID, supplierID from products

select *
from Employees
where EmployeeID > 5 -- employee id greater than 5

-- Relational Operator
/*
=		equal to
!=, <>	not equal to
>		greater than
>=		greater than equal to
<		less than
<=		less than equal to
!>		not greater than
!<		not less than

Logical Operators - To combine conditions
C#	SQL
||	or	logical or	- True if one of the conditions is true
&&	and	Logical and	- True if all the conditions are true
!	!	Logical not
*/

use dkinganjatou1_Northwind
go
select *
from dkinganjatou1_Northwind.dbo.Employees
--where EmployeeID <> 5
where EmployeeID != 5


select 2 + 3 as 'Sum of 2+3'

/*
Ex01
	Write a select query that will display
	the title idl title name, title category,
	price and royalty from
	publishers database, where the royalty is more than 10
*/

select	t.title_id,
		t.title,
		t.[type],
		t.price,
		t.royalty
from dkinganjatou1_pubs.dbo.titles as t
where royalty > 10

/*
	Which database		:
	Which Table			:
	What columns		:
	Condition			:
	sorting involved	:
*/

/*
Ex 02
Write a select query that will display title id, titlename
title type, cost paid to purchase title, royatly paid
from publishers database for all publications
where price is not 19.99
Provide the result according to purchase price in reverse order

Which database			:	Publishers
Which Table				:	Titles
What columns			:	title_id, title, type, price, royalty
Condition				:	price is not 19.99
sorting involved		:	purchase price in reverse order
Change column headers	:
*/

select	t.title_id 'Title id',
		t.title 'Title name',
		t.[type] 'Title type',
		t.price 'Cost paid',
		t.royalty 'Royalty paid'
from dkinganjatou1_pubs.dbo.titles as t
where price != 19.99
order by price desc

-- which database			:
-- which table				:
-- what columns				:
-- condition				:
-- sorting involved			:
-- Look for column headers	:

/*
Logical Operators - To combine conditions
C#	SQL
||	or	logical or	- True if one of the conditions is true
&&	and	Logical and	- True if all the conditions are true
!	!	Logical not
Ex. 3
Write a query that wilt display
the title—id, title, type, price and royalty
from publishers database, for all publications
for those where the price is at least 11 and the royalty is
greater than 10
*/

-- Which database		:	Publishers
-- Which Table			:	Titles
-- What columns			:	title_id, title, type, price, royalty
-- Condition			:	price atleast 11 and royalty greater than 10
-- sorting involved		:	None
-- Change column headers:

select	t.title_id 'Title id',
		t.title 'Title',
		t.[type] 'Type',
		t.price 'Price',
		t.royalty 'Royalty'
from dkinganjatou1_pubs.dbo.titles as t
where price >= 11 and royalty > 10

/*
Ex 05
	Write query to display the product id,
	product name, unit price, units in stock
	and reorder level for all products
	in Northwind DB,
	for which the number of units in stock is
	at tease 30 but not greater than 40
*/

-- Which database		:	Northwind
-- Which Table			:	Products
-- What columns			:	ProductID, ProductName, UnitPrice, UnitsInStock, ReorderLevel
-- Condition			:	UnitInStock >=30 and <=40
-- sorting involved		:	None

select	t.ProductID 'Product ID',
		t.ProductName 'Product Name',
		t.UnitPrice 'Unit Price',
		t.UnitsInStock 'Units In Stock',
		t.ReorderLevel 'Reorder Level'
from dkinganjatou1_Northwind.dbo.Products as t
where UnitsInStock>=  30 and UnitsInStock <= 40

/*
Provide a SQL statement that will return the 5 products 
that have the most units in stock. Your results should match 
what is provided below.
*/

-- Which database		:	Northwind Traders
-- Which Table			:	Products
-- What columns			:	ProductID, ProductName, UnitPrice, UnitsInStock, ReorderLevel
-- Condition			:	UnitInStock >=30 and <=40
-- sorting involved		:	None

use NorthwindTraders
go

select *
from NorthwindTraders.dbo.Products as P

EXEC SP_TABLES

select Shippers.CompanyName
from NorthwindTraders.dbo.Shippers

use NorthwindTraders
go

select FirstName, LastName, HireDate, City
from Employees

select	e.LastName,
		e.FirstName,
		e.BirthDate
from Employees e
order by e.BirthDate desc