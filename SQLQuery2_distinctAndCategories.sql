use NorthwindTraders
go

-- top n - number of records
-- need top 5 recent orders
-- you need to sort your date
-- Then filter it
-- top n - give your the top n records

select top 5 *
from orders
order by orderdate desc

-- I need top n %

select top 1 percent *
from orders
order by orderdate desc

select *
from [order details]
order by quantity desc

-- run it with ties and without ties
select top 3 *
from [Order Details]
order by Quantity desc	

select top 3 with ties *
from [Order Details]
order by Quantity desc	

select top 5 *
from orders

select top 5 *
from [Order Details]

select top 5 with ties *
from [Order Details]
-- It will break when sorting [order by] is not used with ties

/*
	Importan point:
	When using top n
		Make sure to sort data arccording to requested criteria
			Otherwise database engine will pick primary for sorting
		Use top with ties always
*/

-- distinct
-- remove duplicate data from the returned
-- result set
select distinct country
from customers

-- If multiple columns are involved
-- Then any difference in any columns is going to define the uniqueness
select distinct categoryID, supplierID from products