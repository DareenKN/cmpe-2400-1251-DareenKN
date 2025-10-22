-- Week 07 Day 02 : Group By Having and agr. Function
-- More Practice

use Publishers
go

-- select All authors
select *
from authors

-- How many authors we have in authors
select count(*) 'Number of authors'
from authors

select count(au_id) 'Number of authors'
from authors

-- count(*)				  :  null values are included
--  vs 
-- count(specific_column) : ignore null values

-- How many authors we have from California
select count(au_id) 'Number of authors from CA'
from authors
where state = 'CA'  -- filtering values before doing count

--PAY ATTENTION HERE

-- Number of states from which authors come from
select count(all state) 'Number of Unique states'  --default is all
from authors

select count(distinct state) 'Number of Unique states'  --default is all
from authors

-- Number of authors from each state and sort result based on number of authors
select state,
       count(au_id) 'Number of Authors'
from authors
group by state
order by 2 -- you can use function, alias or position of column in the select list
-- 2 refers to position of count(au_id) column in the select list


-- Number of authors from each state and sort result based on number of authors
-- states where we have atleast 2 authors
select state,
       count(au_id) 'Number of Authors'
from authors
group by state
having count(au_id) >= 2 -- if Agg function [sum, count, min, max, avg] involved in condition, use HAVING 
order by 2 -- you can use function, alias or position of column in the select list
-- 2 refers to position of count(au_id) column in the select list


-- Ex 
-- Number of authors from each city
select City, count(au_id) 'Number of Authors'
from authors
group by city 
-- Number of authors from each city, but I need only those where we have atleast 3 authors
select City, count(au_id) 'Number of Authors'
from authors
group by city 
having count(au_id) >=3

-- verify the solution
select *
from authors
order by city
-- Number of authors from each state and each city separately : HINT Nested grouping 
select state,
       city,
       count(au_id) 'Number of authors'
from authors
group by state, city
order by state, 3


-- Number
select * from authors
order by state

