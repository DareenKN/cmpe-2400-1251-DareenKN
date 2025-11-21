-- WEEK 11 Day 03 14.11.2025
-- Union, Union All, Intersect, Except

use publishers
go
select fname, lname, 'Employee' as 'Category'
from employee
	
	union   -- Allows you to combine the result of two or more select
	        -- statements into one result set
			-- The result sets that are combined must have samae structure
			-- Same number of columns, compatiable data types
select au_fname, au_lname, 'Author' as 'Category'
from authors

order by 'category'


select fname, 'Employee' as 'Category'
from employee
	
	union   -- Allows you to combine the result of two or more select
	        -- statements into one result set
			-- The result sets that are combined must have samae structure
			-- Same number of columns, compatiable data types
select au_fname, 'Author' as 'Category'
from authors
order by 1
-- Union will remove duplicate values and give you single entry in the result set

select fname, 'Employee' as 'Category'
from employee
	
	union all   -- Allows you to combine the result of two or more select
	        -- statements into one result set
			-- The result sets that are combined must have samae structure
			-- Same number of columns, compatiable data types
select au_fname, 'Author' as 'Category'
from authors
order by 1

-- Union		- will remove all duplicates from the result set
-- union all	- will include all records

select fname
from employee
	
	intersect   -- Allows you to combine the result of two or more select
	        -- statements into one result set
			-- The result sets that are combined must have samae structure
			-- Same number of columns, compatiable data types
select au_fname
from authors
order by 1

-- Intersect will give you common entries from both or all result sets involved


select fname
from employee
	
	except   -- Allows you to combine the result of two or more select
	        -- statements into one result set
			-- The result sets that are combined must have samae structure
			-- Same number of columns, compatiable data types
select au_fname
from authors
order by 1


select CompanyName, Phone, 'Customer' as 'Company Type'
from NorthwindTraders.dbo.customers
	union all
select CompanyName, phone, 'Shippers' as 'Company Type'
from NorthwindTraders.dbo.Shippers
	union all
select CompanyName, phone, 'Suppliers' as 'Company Type'
from NorthwindTraders.dbo.Suppliers
order by 3 desc  -- 3 means company Type column
-- Exercise 
/*
Write a select query to list the firstname and last name of all students and instructors 
from your own copy of ClassTrak Database. Have a column for 'status' which will be 'student'
or 'instructor'
*/

use harsimrana_classtrak
go

select s.first_name, s.last_name, 'Student' as 'Status'
from students s
union all
select i.first_name, i.last_name, 'Instructor' as 'status'
from Instructors i

/*
	first query 
		set operator [union, union all, intersect, except]
    second query
	-- Both query must have same result structure [same number of columns, compatible data types of columns]
*/

use Publishers
go
-- We want to find top 3 titles in terms of revenues for the year
select top 3 with ties title as 'Title',
       price * ytd_sales as 'Revenues'
from titles
--order by price * ytd_sales desc

union all -- combine both resutl sets
-- we want to find 3 stores from which we have got the most revenues
select top 3 with ties st.stor_name,-- t.price, s.qty, t.title_id, 
	   sum(t.price * s.qty) as 'Revenues'	
from stores st
	inner join sales s
		on st.stor_id = s.stor_id
	inner join titles t 
		on s.title_id = t.title_id
group by st.stor_name
order by  sum(t.price * s.qty) desc


-- Let's learn the correct way

select 'Title' as 'Catergory', t.Title as 'Title/Store Name', t.Revenues as 'Total Revenues'
from ( -- instead of mentioning table name, we are using a subquery to bring that result
		select top 3 with ties title as 'Title',
				price * ytd_sales as 'Revenues'
		from titles
		order by price * ytd_sales desc
	 ) as t  -- temp name for this table

union all

select 'Stores' as 'Catergory',  st.stor_name 'Title/Store Name', st.Revenues 'Total Revenues'
from (
		select top 3 with ties st.stor_name ,-- t.price, s.qty, t.title_id, 
			   sum(t.price * s.qty) as 'Revenues'	
		from stores st
			inner join sales s
				on st.stor_id = s.stor_id
			inner join titles t 
				on s.title_id = t.title_id
		group by st.stor_name
		order by  sum(t.price * s.qty) desc		
	 ) as st  -- temp name for this table

order by 'Catergory'