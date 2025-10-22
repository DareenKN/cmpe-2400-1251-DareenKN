select ArtistId,
    count (*)
from Chinook.dbo.Album
group by ArtistId

use NorthwindTraders
go

select  CategoryId, 
        sum(UnitsOnOrder) as 'On Order'
from Products
group by CategoryID

select SupplierID
from Products
group by SupplierID
having count(UnitsInStock) >= 2 AND 