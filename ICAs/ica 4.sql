use Chinook
go

declare @min int = 6
declare @max int = 7

select left(cast(TrackId as varchar(10)) + ': ' + [Name] + ' - ' + isnull(Composer, 'N/A'), 100) 'Track Information'
from Track
where milliseconds between @min * 60000 and @max * 60000
and UnitPrice < 0.69
order by TrackId

select cast(GenreID as varchar(10)) + ': ' + Name as 'Genres'
from Genre

select convert(varchar(12),'I... wanna write SQL Statements all night')

select left('I... wanna write SQL Statements all night',12)
	
select ltrim('I... wanna write SQL Statements all night')

select concat('Hello',' from', ' the', ' other', ' side')

select 'Hello' + ' from' + ' the' + ' other' + ' side'

select rtrim(concat('Hello',' from', ' the', ' other', ' side'))

select convert(varchar(10), getdate()) 'ANSI Date'

select 5*2 as Ten

select convert(varchar(10), getdate(), 102) as 'ANSI Date' 


	
select DateDiff(year,GetDate(),0)

select Convert(varchar(15),GetDate(),114)

select DateName(year,GetDate())

select Year(GetDate())

use dkinganjatou1_Northwind
go

select top 5 OrderID 
from Orders
where Shippeddate is not null
order by datediff(ss,OrderDate,ShippedDate)desc

select *
from Orders
where convert(date,OrderDate)='2019-08-27'

select *
from orders
where datediff(dd,requireddate,shippeddate)>10
order by datediff(ss, orderdate, shippeddate) desc

select *
from orders
where datediff(mm,orderdate,shippeddate)>=2

select *
from orders
where datediff(hh,orderdate,shippeddate)<10

select *
from orders
where month(ShippedDate) = month(getdate())
	  and day(ShippedDate) = day(getdate())