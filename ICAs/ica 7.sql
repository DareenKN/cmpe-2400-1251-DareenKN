use NorthwindTraders
go

-- Question 1
/*
This question assumes use of NorthwindTraders database. 

Rearrange the SQL Statement to retrieve the company name of the Supplier and the product name that supplier offers, and the product's unit price. Order the results by (1) Company Name and (2) Product Name. Only Suppliers in the USA should be returned.
*/

declare @country varchar(10) = 'USA'

select  s.CompanyName 'Company Name',
        p.ProductName 'Product Name',
        p.UnitPrice 'Unit Price'
from Suppliers s
    inner join Products p 
        on s.SupplierID = p.SupplierID
where s.Country = @country
order by    s.CompanyName, p.ProductName 

-- Question 2
/*
This question assumes use of NorthwindTraders database. 

Rearrange the SQL Statement to retrieve the Name (note the formatting!) and Territory the employee is assigned to. Only employees in Seattle should be displayed. Results should be sorted by Territory Description. Ensure your joins are in a logical order.
*/

select * from Territories
select * from EmployeeTerritories
select * from Employees

declare @city varchar(10) = 'Seattle'

select  e.LastName + ', ' + e.FirstName 'Name',
        t.TerritoryDescription 'Territory Description'
from Employees e 
    join EmployeeTerritories et
        on e.EmployeeID = et.EmployeeID
    join Territories t 
        on t.TerritoryID = et.TerritoryID
where e.city = @city
order by 2

-- Question 3
/*
This question assumes use of NorthwindTraders database. 

Fill in the blanks, and rearrange the SQL Statement to retrieve the unique CompanyName and ProductName ordered by the ProductName. Restrict the result to only include customers who have orders with Discount of 25% or greater, and whose freight is more than 500. Ensure your joins are in a logical order.
*/
declare @discount float = 0.25
declare @freight int = 500


select  c.CompanyName,
        p.ProductName
from Customers c
    join Orders o
        on c.CustomerID = o.CustomerID
    join [Order Details] od
        on od.OrderID = O.OrderID
    join Products p 
        on p.ProductID = od.ProductID
where   od.Discount >= @discount
        and o.Freight > @freight
order by p.ProductName

-- Declare a variable for the day difference
declare @Days int = 30

select  o.ShipName 'Shipper',
        p.ProductName 'Product Name',
        c.CategoryName 'Catergory'
from Orders o
    join [Order Details] od 
        on o.OrderID = od.OrderID
    join Products p 
        on od.ProductID = p.ProductID
    join Categories c 
        on p.CategoryID = c.CategoryID
where   p.Discontinued = 1
        and datediff(dd, o.ShippedDate, o.RequiredDate) > @Days
order by o.ShipName

    