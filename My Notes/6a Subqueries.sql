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
select *        -- parent query
from products
where CategoryID = ( select categoryid  -- Child/ sub query
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
select *      -- parent query
from products p    -- observe the use of IN here becasue subquery is returning more than 1 value
where p.CategoryID in (  -- Child/ sub query 
					select c.CategoryID
					from categories  c
					where CategoryName like 'C%'
				   )
order by p.CategoryID

use Publishers
go

select *   -- grand parent query
from authors a
where a.au_id in (
					select au_id      -- parent query
					from titleauthor ta
					where ta.title_id in (  -- grandchild
										select t.title_id
										from titles t
										where type ='business'
										)
				 )
order by a.au_lname