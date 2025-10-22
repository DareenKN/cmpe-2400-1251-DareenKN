-- Week 07 Day 03 : Group By Having and agr. Function
-- More Practice

use publishers
go

select contract,
	   count(au_id) 'Number of authors based on Contract state',
	   case   -- That is also possible to use a if else logic
			when contract =1 then 'Have Contract'
			when contract =0 then 'Have No Contract'
	   End as 'Contract State'
from authors
group by contract

-- Count all titles for which there has been some sale during the year
select count(*) 'Number of titles sold'
from titles
where ytd_sales is not null

--Alternative 
select count(ytd_sales) 'Number of titles sold'
from titles

-- Write a query to find the revenue for each title
select title,
       isnull(cast(price * royalty * ytd_sales as varchar(10)), 'NA') 'Revenue'
from titles

-- Write a query to find the total revenew we have obtained from 
-- all the sales during the year
select sum(price * royalty * ytd_sales ) as 'Total Revenue from all titles'
from titles

-- Change to find total revenue for each category/type

select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type

/*
Business    447734

*/

-- Change to filter Group where sum is null
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type
having sum (price * royalty * ytd_sales) is not null

-- Try it with Where clause
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
where sum (price * royalty * ytd_sales) is not null -- Not possible Because we are filtering groups
group by type


-- Change the question: I don't want business type in my result
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
where type != 'business'  -- filtering out individual rows before forming group
group by type
having sum (price * royalty * ytd_sales) is not null

--Try it with having clause
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type
having sum (price * royalty * ytd_sales) is not null and type !='business'  -- Filtering out group after all calculation

-- Make change : I need to excude titles having royalty 24

select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
where royalty != 24
group by type

-- Let's try this one with having
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type
having royalty != 24  -- Not part of group by or aggregate function

-- Change it further: where total revenue for each category is atleast 50000
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type
having sum (price * royalty * ytd_sales) >= 50000
-- Change it further : Please sort my data according Total revenue in reverse order
select type, sum (price * royalty * ytd_sales) 'Total Revenue'
from titles
group by type
having sum (price * royalty * ytd_sales) >= 50000
--order by sum (price * royalty * ytd_sales) desc   -- Possible by using function/expressiong involved
--order by 'Total Revenue' desc						-- Possible by column alias
order by 2 desc										-- possible by column position in select list

-- BREAK TIME 09:15 AM
