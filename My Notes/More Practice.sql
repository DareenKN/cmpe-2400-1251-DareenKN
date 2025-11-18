--Week 12 Day 01.... More Practice

use dkinganjatou1_NorthWind

/*
Write a query to obtain the product name, Category Id Categgory Name of products that are in the confections or Seafood categories and have a unit price more than 20, from the NorthwindTraders DB.
Result should be orderd by CategoryID, then by Product Name
*/

Select * from products
select * from categories

-- With Joins
select  p.ProductName,
        c.CategoryID,
        c.CategoryName
from Products p
    join Categories c
    on p.CategoryID = c.CategoryID
where c.CategoryName in ('Confections', 'Seafood')
and p.UnitPrice > 20
order by c.CategoryID, p.ProductName

-- With Subqueries
select  p.ProductName, 
        p.CategoryID
from Products p
where p.CategoryID in   (
                            select c.CategoryID
                            from Categories c
                            where c.CategoryName in ('Confections', 'Seafood')
                        )
                    and p.UnitPrice > 20
order by p.CategoryID, p.ProductName

-- With Subqueries exists
select  p.ProductName, 
        p.CategoryID
from Products p
where exists   (
                    select c.CategoryID
                    from Categories c
                    where p.CategoryID = c.CategoryID
                    and c.CategoryName in ('Confections', 'Seafood')
                )
and p.UnitPrice > 20
order by p.CategoryID, p.ProductName
