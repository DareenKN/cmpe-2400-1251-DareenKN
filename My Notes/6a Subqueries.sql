-- WEEK 08 Day 01: 21.10.2025
-- Subqueries
-- Subquery is query that is nested within a parent query
-- Use when we want to most of the information 
-- from one table and one item of data from other table

use NorthwindTraders
go
-- Old way 
declare @DairyProductId int

select @DairyProductId= CategoryID
from categories
where CategoryName = 'Dairy Products'

select *
from products
where CategoryID = @DairyProductId

-- NEW way
-- List of products for category 'Dairy Products'
select *
-- parent query
from products
where CategoryID = ( select categoryid
-- Child/ sub query
from Categories
where CategoryName= 'Dairy Products'
				   )

-- Need to find list of students score above class average
-- Steps
-- find avg  mark value for the class
-- use that value to filter students
-- IT is just an example to understand it: you won't be to run this query
--select * from students 
--where marks > ( select avg(marks) from students)

-- List of products where category name starts with letter C
select *
-- parent query
from products p
-- observe the use of IN here becasue subquery is returning more than 1 value
where p.CategoryID in (  -- Child/ sub query 
					select c.CategoryID
from categories  c
where CategoryName like 'C%'
				   )
order by p.CategoryID

use Publishers
go

select *
-- grand parent query
from authors a
where a.au_id in (
					select au_id
-- parent query
from titleauthor ta
where ta.title_id in (  -- grandchild
										select t.title_id
from titles t
where type ='business'
										)
				 )
order by a.au_lname

use dkinganjatou1_Northwind
go

select*
from products p
where exists (
				select *
				from Categories C
				where CategoryName = 'Dairy Products'
					and c.CategoryID = p.CategoryID
			 )

select *
from products p
where p.CategoryID in (
						select c.CategoryID
from categories c
where CategoryName like 'C%'
)

select *
from products p
where exists (
				select c.CategoryID
				from categories c
				where CategoryName like 'C%'
				and c.CategoryID = p.CategoryID
			 )

-- You can put subqueries in your where, having, select list from clause
select p.ProductID,
	p.ProductName,
	p.CategoryID,
	(select c.CategoryName
	-- It must return single values else it would break
	from Categories c
	where CategoryID = 6) as 'CategoryName'
-- Alias for Calculated column
-- Try to find more than one category by commenting out the condition, Not possible

from products p
where p.CategoryID = 6

-- Performance Consideration
-- IN vs EXISTS
/*
	Exists is faster than IN when subquery result set is very large
	In Clause is faster when the subquery result set is small

	In cannot compare with NULL values whereas EXISTS can compare anything with NULL
*/

-- Your Boss wants to quickly check the lowest product price in the catalog
-- You need to find the lowest price in the catalog.

select *
from Products p
where p.UnitPrice = (
						select min(UnitPrice)
						from products
					)

select min(UnitPrice)
from products

-- Alternative Solution
select top 1 with ties *
from Products
order by UnitPrice

-- Try with Exists
select *
from Products p1
where exists (
				select *
				from Products p2
				where p1.UnitPrice = p2.UnitPrice
				and p2.UnitPrice = (
									select min(UnitPrice)
									from Products p1
								   )
			 )
-- Uisng Exists here is not effiscient as = for this specific case since you are not joining multiple tables
-- But it is a good practice exercise

-- Exercise N02
-- Find the product(s) that cost more than the average product price
select *
from Products p 
where p.UnitPrice > (
						select avg(UnitPrice)
						from Products
					)

-- Exercise N03
-- Find the products costlier than any product supplied by 'Exotic Liquids'

select *
from Products p1 
where p1.UnitPrice > (
						select max(UnitPrice)
						from Products p2
						where p2.SupplierID = (
												select SupplierID
												from Suppliers
												where CompanyName = 'Exotic Liquids'
											)
					)



