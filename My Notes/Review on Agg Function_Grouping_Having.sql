use Publishers
go

-- Select All Authors
select *
from authors
-- How many authors we have in authors
select count(*)'Number of authors'
from authors

select count(au_id)'Number of authors'
from authors

-- count(*)				: Null values are included
--   vs
-- count(specific_column: Ignore null values

-- How many authors we have from California

-- Number of States from which authors come from
-- Distinct considers only the distinct values
select count(distinct state) 'Number of Unique States'
from authors
select count(all state) 'Number of Unique States'
from authors

-- Number of authors from each state and sort the result based on number of authors
select	state,
		count(au_id) 'Number of Authors'
from authors
group by state		-- Sorts in ascending order
order by 'Number of Authors' -- You can use function, alias, posn of column in list

select * from authors 
order by state

-- Number of authors from each state and sort the result based on number of authors
select	state,
		count(au_id) 'Number of Authors'
from authors
group by state		-- Sorts in ascending order
having count(au_id) >= 2	-- if Agg function [sum, count, min, max, avg] involved in condition 
order by 'Number of Authors' -- You can use function, alias, posn of column in list

-- Ex
-- Number of authors from each city
-- Number of authors from each city, but need only those where we have atteast 3 authors
-- Number of authors from each state and each city separately HINT Nested grouping

select * from authors
order by city

-- Number of authors from each city
select count(au_id) 'Number of Authors',
		city
from authors
group by city

-- Number of authors from each city, but need only those where we have atteast 3 authors
select	count(au_id) 'Number of Authors',
		city
from authors
group by city
having count(au_id)>=3

-- Number of authors from each state and each city separately HINT Nested grouping
select	state,
		city,
		count(au_id) 'Number of Authors'
from authors
group by state, city
order by state, city
		


