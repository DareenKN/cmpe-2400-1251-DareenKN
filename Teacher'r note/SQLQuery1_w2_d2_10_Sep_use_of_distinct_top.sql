use dkinganjatou1_Northwind
go

select * 
from orders 
order by OrderDate desc
-- You need to sort the data
-- Then filter it
-- top n - will give you top n record
-- top n percent - will give you top n percentage
select top 5 OrderID,
       CustomerID
       
from Orders
order by OrderDate desc

select top 1 percent * 
from Orders
order by OrderDate desc

--

select * 
from [Order Details]
order by Quantity desc, OrderID

-- Run it with top 3
select top 3 * 
from [Order Details]
order by Quantity desc

-- Now run it with top 3 with ties

select top 3 with ties *  
from [Order Details]
order by Quantity desc
-- it is always safe to use with ties


-- Import Points:
-- When using top
--    Make sure to sort data according to 
--    requested criteria
--    Use top with ties always

-- make sure to add sorting part
-- otherwise database engine
-- will pick PK field for sorting

select * 
from orders

use NorthWindTraders
go

select top 5 *
from Orders

select top 5 with ties * 
from [Order Details]
-- even worse when composite PK is involved


-- distinct
-- remove duplicate data from
-- the returned result set

select distinct Country 
from Customers
order by Country

select * from products
select distinct ProductName, SupplierID
from products

-- If multiple columns are involved
-- then any difference in any columns
-- is going to define the uniqueness
select distinct CategoryID, SupplierID 
from Products


-- filtering 
    -- top n
  
select * 
from [Order Details]
-- wher is something if in C#
where Quantity < 5

-- Individual conditions
-- relational operators could be used
/*
< 
>
<=
>=
==   = 
!=   != , <>
Not Greater than   !>
Not Less than      !<

*/
select * 
from [Order Details]
-- wher is something if in C#
where Quantity !> 5


select * 
from [Order Details]
where Quantity !> 5
order by UnitPrice desc


-- What if we need to combine condition
-- C# Logical operators
 /*
    Logical And  and
    Logical or   or 
    Logical not  !
 */

select * 
from [Order Details]
-- wher is something if in C#
where Quantity < 5 and UnitPrice > 10


use NorthWindTraders
go

select top  5    
            ProductName 'Product Name',
            UnitPrice 'Unit Price'
from NorthwindTraders.dbo.Products
order by UnitsInStock Desc



