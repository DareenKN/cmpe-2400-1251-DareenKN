-- WEEK 08 Day 03: 24.10.2025
-- Subqueries , Exists operator

use dkinganjatou1_Northwind
go


/*
 EXISTS operator used to test for the existence of any record/row in a subquery
 It returns TRUE if the subquery returns one or more records/rows
 You can think about this one as a nested loop in C#
 Each parents table row will be compared to child query table rows
 with a true on the first match
*/
-- List of products for category 'Dairy Products'
select *        -- parent query
from products
where CategoryID = ( select categoryid  -- Child/ sub query
				     from Categories
				     where CategoryName= 'Dairy Products'
				   )
-- Rewrite the same query using EXISTS operator
select *
from products p
where exists (
				select * 
				from Categories c
				where CategoryName = 'Dairy Products'
				and c.CategoryID = p.CategoryID
			 )
select *      -- parent query
from products p    -- observe the use of IN here becasue subquery is returning more than 1 value
where p.CategoryID in (  -- Child/ sub query 
						select c.CategoryID
						from categories  c
						where CategoryName like 'C%'
					  )

-- Rewrite this one using EXISTS

select *      -- parent query
from products p    
where exists (  -- Child/ sub query 
					select c.CategoryID
					from categories  c
					where CategoryName like 'C%'
					and c.CategoryID = p.CategoryID -- comparison criteria for exists operator
				   )
-- Subquery in you where, having, select list, from clause
select p.ProductID,
       p.ProductName,
	   p.CategoryID,
	   (select c.CategoryName  -- Subquery in your select list : It must return single value otherwise it will break
	   from Categories c 
	   where CategoryID= 6) as 'CategoryName' -- Alias for calculated column
	   -- Try to find more than one category by commenting out where clause
	   -- NOT POSSIBLE using subqueries BIG NOOOOOOOOOOO
from products p
where p.CategoryID = 6

--Performance Consideration
-- IN vs EXISTS
/*
	Exists is faster than IN when subquery result set is very large
	In Clause is faster when the subquery result set is small

	In cannot compare with NULL values whereas EXISTS can compare anything with null
*/

-- Your boss wants to quickly check the lowest product price in the catalog

select *
from products
where UnitPrice = (
					select min(Unitprice) 
					from products
				  )
-- Alternative solution 
select top 1 with ties *
from products
order by UnitPrice

-- Try with exists

select *
from products p1
where exists (
				select * 
				from products p2
				where p1.unitprice= p2.UnitPrice
				and p2.unitprice= 
									(select min(unitprice)
									 from products p3
									)
			   )
-- using Exists here is not a efficient as = for this specific case 
--( since your not joing multiple tables), but it is good practice to exercise 

-- Ex02
-- Find the product(s) that cost more than the average product price 

select *
from products 
where UnitPrice > (
					select avg(unitprice)
					from products
				  )
order by UnitPrice
-- Always break it down

-- Ex03
-- Find the products costlier than any product supplied by 'Exotic Liquids'

select * from products
select * from Suppliers

-- Need to find supplier id of that company
select s.SupplierID
from suppliers s
where CompanyName ='Exotic Liquids'

-- Need to find all products supplied by that supplier
select * 
from products p
where p.SupplierID = 1

-- JOin previous 2 pieces
select * 
from products p
where p.SupplierID = (
						select s.SupplierID
						from suppliers s
						where CompanyName ='Exotic Liquids'
					 )

select max(UnitPrice) 
from products p
where p.SupplierID = (
						select s.SupplierID
						from suppliers s
						where CompanyName ='Exotic Liquids'
					 )

-- Costlier product by 'Exotic liquids'
-- Need to find all the products costlier than 19
select *
from products
where UnitPrice > 19


-- Join all the pieces now
select *
from products
where UnitPrice > (
					select max(UnitPrice) 
					from products p
					where p.SupplierID = (
											select s.SupplierID
											from suppliers s
											where CompanyName ='Exotic Liquids'
										 )
					)
-- Call it a day here

