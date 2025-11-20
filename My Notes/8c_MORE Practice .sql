--Week 12 Day 2 : 19.11.2025

use harsimrana_Northwind
go

-- Try to write solution using
-- Subquery
-- exists
-- JOIN ANSI if inner join
-- JOIN SQL Syntax if inner join 

/*
Write a query to obtain the product Name, Category Id
Category Name of products that are in the Confections
or Seafood categories and have a unit price more than
20, from the NorthwindTraders DB. 
Results should be ordered by CategorId, then by 
Product Name.
*/

select * from products

select * from Categories

select * 
from products p
where p.UnitPrice > 20 and p.CategoryID in (3,8)  -- hard coded 


select c.CategoryID from Categories c
where c.CategoryName ='seafood' or c.CategoryName like 'Confections'

select --*  -- I don't need all the columns
       p.ProductName,
	   p.CategoryID
from products p
where p.UnitPrice > 20 and p.CategoryID in (
	
	select c.CategoryID from Categories c
	where c.CategoryName ='seafood' or c.CategoryName like 'Confections'
) 

-- Exits
select --*  -- I don't need all the columns
       p.ProductName,
	   p.CategoryID
from products p
where p.UnitPrice > 20 and exists (
	
	select c.CategoryID from Categories c
	where (c.CategoryName ='seafood' or c.CategoryName like 'Confections') and
	      p.categoryid= c.categoryid
) 


select p.ProductName,
       c.CategoryID,
	   c.CategoryName
from Products p
	inner join Categories c
		on c.CategoryID = p.CategoryID
where p.UnitPrice > 20 and c.CategoryName in ('seafood', 'confections')
