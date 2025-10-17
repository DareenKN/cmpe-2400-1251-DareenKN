use NorthwindTraders
go

select	CategoryID,
		[Description]
from Categories
where CategoryName like 'Beverages'

use NorthwindTraders
go

select	OrderID as 'OrderId',
		CustomerID,
		EmployeeID,
		ShipName,
		ShipCity
from Orders
where	month(shippeddate) = 7
		and year(shippeddate) = 2019
		and ShipRegion is null
		and (ShipCountry like 'F%' or ShipCity like '%er%')
order by ShipCountry, EmployeeID

use Chinook
go

declare @min int = 6
declare @max int = 7

select left(cast(TrackId as varchar(10)) + ': ' + [Name] + ' - ' + isnull(Composer, 'N/A'), 100) 'Track Information'
from Track
where milliseconds between @min * 60000 and @max * 60000
and UnitPrice < 0.69
order by TrackId

use NorthwindTraders
go

select	ProductID,
		ProductName,
		UnitPrice
from Products
where	Discontinued !=1
		and UnitsInStock between 20 and 30

use NorthwindTraders
go

select *
from orders
where datediff(dd,requireddate,shippeddate) >10
order by datediff(dd,requireddate,shippeddate) desc

select *
from orders
where datediff(mm,OrderDate,shippeddate)>=2

select *
from orders
where datediff(hh,OrderDate,shippeddate)<10

select	CustomerID,
		ContactName,
		City,
		Region
from customers 
where fax is null
	  and Region is not null
order by Country, city desc
		 
select 5*2 Ten
select 5*2 as Ten

	
--select Ten as 5*2

	
--select 5*2 from Ten

	
select 5*2 'Ten'

select convert(varchar(12),'I... wanna write SQL Statements all night')

	
select ltrim('I... wanna write SQL Statements all night')

	
select left('I... wanna write SQL Statements all night',12)

	
--select cast('I... wanna write SQL Statements all night', varchar(12))


	
select 'Hello' + ' from' + ' the' + ' other' + ' side'

	
select rtrim(concat('Hello',' from', ' the', ' other', ' side'))

	
select concatenate('Hello',' from', ' the', ' other', ' side')

	
select concat('Hello',' from', ' the', ' other', ' side')

select convert(varchar(10), getdate(), 102) as 'ANSI Date' 

use NorthwindTraders
go

select	CategoryID,
		CategoryName,
		[Description]
from Categories
where CategoryName like '[SB]%'

select Shippers.CompanyName
from NorthwindTraders.dbo.Shippers

use NorthwindTraders
go

select *
from Orders
where convert(date,OrderDate)='2019-08-27'

select	top 5
		ProductName as 'Product Name',
		UnitPrice as 'Unit Price'
from Products
order by UnitsInStock desc
	
select DateDiff(year,GetDate(),0)

	
select DateName(year,GetDate())

	
select Year(GetDate())

	
select Convert(varchar(15),GetDate(),114)

select top 5
		OrderID
from Orders
where ShippedDate is not null
order by datediff(ss,orderdate,shippeddate) desc

use Chinook
go 
select cast(GenreID as varchar(10)) + ': ' + [Name] as 'Genres'
from Genre

use NorthwindTraders
go

select *
from orders
where month(ShippedDate) = month(getdate())
	  and day(ShippedDate) = day(getdate())

use dkinganjatou1_IQSchool
go

-- Change to find total revenue for each category/type

use Publishers
go

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              