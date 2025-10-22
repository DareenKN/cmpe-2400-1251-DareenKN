-- Week 05 Day 02: 01.10.2025
-- More built in function


use harsimrana_northwind
go
-- Globals

select * 
from orders

select @@Language, -- starts with 2 @ signs
       @@error,     -- Error code for last executed query
       @@ROWCOUNT   -- Number of rows affected by last executed query


select isnull(ShipRegion, 'N/a') as 'ShipRegion',
       isnull(ShipPostalCode, 'n/a') as 'Ship Postal Code',
       coalesce( ShipRegion, ShipPostalCode, 'N/a') 
from orders

select coalesce( null, null,  'Best one', 'A', 'B') -- First not null value
 
 -- Excercise Slide 36: Lecture 4B
 /*
 Use the Publishers database
 Write a query that displays the title id, title,
royalty, price and the amount the authors will
obtain per copy (that will be royalty/100 *
price) for all titles from the titles table where
the amount obtained by the authors does not
exceed $2.00. Include any rows where the
amount obtained is null. When Royalty or price
is null, display them as 0.
 Limit the titles to the first 50 characters.
 Result on next slide
 */

-- use fully qualified name
select Title_id as 'Title id',
       Title,
       isnull(Royalty, 0) 'Royalty' ,
       cast(coalesce(Price, 0.00) as decimal(10,2)) 'Price',
       cast((royalty / 100.0 * price) as decimal(10,2)) as 'Author Amount'
from Publishers.dbo.titles
where royalty / 100.0 * price <= 2
      or 
      royalty / 100.0 * price is null
order by  5 desc

-- fix the format of value in previous question
-- Exercise 
/*
Modify the previous query so that where the
royalty or the price is null, they appear as ‘N/A’
instead of 0.
*/

select Title_id as 'Title id',
       Title,
       isnull(cast (Royalty as varchar(10)), 'N/a') 'Royalty' ,
       coalesce(cast(Price as varchar(10)), 'N/a')  'Price',
       cast((royalty / 100.0 * price) as decimal(10,2)) as 'Author Amount'
from Publishers.dbo.titles
where royalty / 100.0 * price <= 2
      or 
      royalty / 100.0 * price is null
order by  5 desc