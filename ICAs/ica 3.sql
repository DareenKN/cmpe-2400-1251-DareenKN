use NorthwindTraders
go

select	ProductID,
		ProductName,
		UnitPrice
from Products
where Discontinued != 1 and UnitsInStock between 20 and 30

select * from Products

select	CategoryID,
		CategoryName,
		"Description"
from Categories
where CategoryName like '[SB]%'

select	CustomerID,
		ContactName,
		City,
		Region
from Customers
where Fax is null and Region is not null 
order by Country asc, City desc


