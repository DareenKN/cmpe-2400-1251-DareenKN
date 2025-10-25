select ArtistId,
    count (*)
from Chinook.dbo.Album
group by ArtistId

use NorthwindTraders
go

select CategoryId,
    sum(UnitsOnOrder) as 'On Order'
from Products
group by CategoryID

select SupplierID,
    sum(UnitsInStock) as 'TotalUnits'
from Products
where UnitsInStock >= 2
group by SupplierID
having avg(UnitPrice) < 20

select e.Title, count(e.City) 'Unique Cities'
from Employees e
group by e.Title

select distinct e.Title, count(e.City) 'Unique Cities'
from Employees e

order by e.Title

select e.Title, count(distinct e.City) 'Unique Cities'
from Employees e
group by e.Title

select  EmployeeID,
        count(ShipVia) as 'Total',
        count(ShippedDate) as 'Shipped',
        avg(datediff(day, OrderDate, ShippedDate)) as 'Average (Days)',
        min(datediff(hour, OrderDate, ShippedDate)) as 'Fastest (Hours)',
        max(datediff(day, OrderDate, ShippedDate)) as 'Slowest (Days)',
        '$' + convert(varchar, cast(sum(Freight) as money), 1) as 'Total Freight'
from Orders
group by EmployeeID
having min(datediff(hour, OrderDate, ShippedDate)) > 15
order by 4, EmployeeID



