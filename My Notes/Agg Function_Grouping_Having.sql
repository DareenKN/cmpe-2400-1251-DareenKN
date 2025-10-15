use master
go

--drop database if exists practice_dkn_grouping
--go

--create database practice_dkn_grouping
--go

use practice_dkn_grouping
go

drop table  if exists stickyNote
go

create table stickyNote
(
	color  varchar(10) not null,
	number int null
)
go

insert into stickyNote
values ('orange', 7),
	   ('orange', 8),
	   ('orange', -1),
	   ('yellow', 3),
	   ('yellow', 4),
	   ('yellow', null),
	   ('blue', 1),
	   ('blue', 2)

select * from stickyNote

-- count all values
select count(*) 'Total values'
from stickyNote

--Count without null(empty)
select count(number) 'Without Null'
from stickyNote

-- Count all positive number
select count(number) 'Without negative'
from stickyNote
where number >= 0

-- sum all values
select sum(number) 'Sum of number'
from stickyNote

-- sum of all positive numbers
select sum(number) 'Sum of positive numbers'
from stickyNote
where number >=0


-- Group by
select color, 
       count(*) 'Count',
       sum(number) 'Sum',
	   sum(cast(number as float))/ count(*) 'Own Avg',
	   sum(cast(number as float))/ count(number) 'Own Avg',
	   avg(cast(number as float))  'Average',
	   max(number) 'Max',
	   min(number) 'Min'
from stickyNote
group by color
having sum(number) > 3
order by sum(number)

-- where: to filter row values 
-- having: to filter groups 


-- ignore all null values and negatives values

select color, 
       count(*) 'Count',
       sum(number) 'Sum',
	   sum(cast(number as float))/ count(*) 'Own Avg',
	   sum(cast(number as float))/ count(number) 'Own Avg',
	   avg(cast(number as float))  'Average',
	   max(number) 'Max',
	   min(number) 'Min'
from stickyNote								--1
where number is not null and number >= 0	--2
group by color								--3
having sum(number) > 3						--4
order by sum(number)						--5

