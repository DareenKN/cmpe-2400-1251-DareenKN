use NorthwindTraders
go

select  e.FirstName + space(1) + e.LastName 'Employee Name'
from employees e

select * from Employees


-- Q2
select  c.CategoryName,
        avg(UnitPrice)
from Products p
    join Categories c
        on c.CategoryID = p.CategoryID
group by c.CategoryID, c.CategoryName
having avg(UnitPrice)> 30

-- Q3
select  o.CustomerID,
        s.CompanyName,
        count(distinct od.ProductID)  'Number of Distinct product'
from Orders o
    join [Order Details] od
        on od.OrderID = o.OrderID
    join Shippers s
        on s.ShipperID = o.ShipVia
group by o.CustomerID, s.CompanyName
having count(od.ProductID) > 5


-- Q4
select  s.CompanyName,
        p.ProductName, 
        c.CategoryName
from Suppliers s
    join Products p
        on p.SupplierID = s.SupplierID        
    join Categories c
        on p.CategoryID = c.CategoryID
where c.CategoryName in ('Confections')

select  s.CompanyName,
        p.ProductName, 
        c.CategoryName
from Suppliers s
    join Products p
        on p.SupplierID = s.SupplierID        
    join Categories c
        on p.CategoryID = c.CategoryID
where  c.CategoryName in ('Beverages')
