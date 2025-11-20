-- Question 1
/*
This question assumes use of NorthwindTraders database.

Rearrange the SQL Statement to return a list containing the results of both the following:

Customer Company Names which have no orders
Supplier Company Names which have no products
The entire resultset must be ordered by Company Name
*/
use NorthwindTraders
go

select c.CompanyName as 'Customer/Supplier with Nothing' 
from Customers c 
    left outer join Orders o 
        on c.CustomerID = o.CustomerID 
where o.OrderID is null 

union all 

select s.CompanyName 
from Suppliers s 
    left outer join Products p 
        on s.SupplierID = p.SupplierID 
where p.ProductID is null
order by CompanyName 

-- Q2

select 
    'Customer' as Type,
    c.CompanyName as 'Customer/Supplier with Nothing'
from Customers c
left outer join Orders o
    on c.CustomerID = o.CustomerID
where o.OrderID is null

union all

select
    'Supplier' as Type,
    s.CompanyName as 'Customer/Supplier with Nothing'
from Suppliers s
left outer join Products p
    on s.SupplierID = p.SupplierID
where p.ProductID is null

order by Type, [Customer/Supplier with Nothing];
