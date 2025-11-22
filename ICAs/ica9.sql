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

-- Question 2

/*
This question assumes use of NorthwindTraders database. 

Rearrange the following so that the SQL statement returns Customer Company Names which have no orders, and below those, Supplier Company Names which have no products. Ensure that the results are ordered by Type and then the Company Name.
*/

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


select 'Customer' as 'Type', CompanyName as 'Customer/Supplier with Nothing'
from Customers c left outer join Orders o on c.CustomerID = o.CustomerID
where o.OrderID is null
union all
select 'Supplier', CompanyName
from Suppliers s left outer join Products p on s.SupplierID = p.SupplierID
where p.ProductID is null
order by 'Type', CompanyName 


-- Question 3
/*
This question requires fully qualified database names for all tables 

It's your lucky day! Telemarketers R US wants to pay you BIG money if you sell them all the phone numbers from these databases: NorthwindTraders, AdventureWorksLT, Chinook and Publishers. Note that all Authors in the Publishers database live in USA.

Compile a list of Names (Lastname, Firstname OR CompanyName), Country, and Phone Number from all tables with such information in any of the above databases. Organize the list by Country then Name.

Ensure the Names are limited to 50 characters, and Country to 20 characters. 

You get paid 10 bucks per phone number... you have the potential to make big money if you get this one right! 

Paste your SQL statement below - this question will be graded manually by your instructor.
*/

(
    -- NorthWindTraders
    -- Employees
    select  left(e.LastName + ', ' + e.FirstName, 50) 'Name',
            left(e.Country, 20) 'Country',
            e.HomePhone 'Phone'
    from NorthwindTraders.dbo.Employees e
    --where e.HomePhone is not null

    -- union all
    -- -- Shippers
    -- select  distinct s.CompanyName 'Name',
    --         o.ShipCountry 'Country',
    --         s.Phone 'Phone'
    -- from NorthwindTraders.dbo.Shippers s
    --   join NorthwindTraders.dbo.Orders o
    --     on o.ShipVia = s.ShipperID
    -- where s.Phone is not null

    union all
    -- Suppliers
    select  left(su.CompanyName, 50) 'Name',
            left(su.Country,20) 'Country',
            su.Phone 'Phone'
    from NorthwindTraders.dbo.Suppliers su
    --where su.Phone is not null
    
    union all
    -- Customers with CompanyName
    select  left(c.CompanyName, 50) 'Name',
            left(c.Country, 20) 'Country',
            c.Phone 'Phone'
    from NorthwindTraders.dbo.Customers c
    --where c.Phone is not null

    -- AdventureWorksLT

     -- Customers with CompanyName 
    union all
    select  distinct left(c.CompanyName, 50) 'Name',
            left(a.CountryRegion, 20) 'Country',
            c.Phone 'Phone'
    from AdventureWorksLT.dbo.Customer c
        join AdventureWorksLT.dbo.CustomerAddress ca
          on c.CustomerID = ca.CustomerID
        join AdventureWorksLT.dbo.Address a
          on ca.AddressID = a.AddressID
    --where c.Phone is not null


    -- Chinook
    -- Chinook Customers 
    union all
    select  left(c.LastName + ', ' + C.FirstName, 50) 'Name',
            left(c.Country, 20) 'Country',
            c.Phone 'Phone'
    from Chinook.dbo.Customer c
    --where c.Phone is not null

    -- Chinook Employees 
    union all
    select  left(e.LastName + ', ' + e.FirstName, 50) 'Name',
            left(e.Country, 20) 'Country',
            e.Phone 'Phone'
    from Chinook.dbo.Employee e
    --where e.Phone is not null


    -- Publishers (All USA) 
    -- Authors 
    union all
    select
        left(a.au_lname + ', ' + a.au_fname, 50) 'Name',
        left('USA', 20) as 'Country',
        a.Phone
    from Publishers.dbo.Authors a
    --where a.Phone is not null
) 
order by Country, Name



(
  -- NorthWindTraders
  -- Employees
  select  left(e.LastName + ', ' + e.FirstName, 50) 'Name',
          left(e.Country, 20) 'Country',
          e.HomePhone 'Phone'
  from NorthwindTraders.dbo.Employees e

  union all
  -- Suppliers
  select  left(su.CompanyName, 50) 'Name',
          left(su.Country,20) 'Country',
          su.Phone 'Phone'
  from NorthwindTraders.dbo.Suppliers su
  
  union all
  -- Customers with CompanyName
  select  left(c.CompanyName, 50) 'Name',
          left(c.Country, 20) 'Country',
          c.Phone 'Phone'
  from NorthwindTraders.dbo.Customers c

  -- AdventureWorksLT
    -- Customers with CompanyName 
  union all
  select  distinct left(c.CompanyName, 50) 'Name',
          left(a.CountryRegion, 20) 'Country',
          c.Phone 'Phone'
  from AdventureWorksLT.dbo.Customer c
      join AdventureWorksLT.dbo.CustomerAddress ca
        on c.CustomerID = ca.CustomerID
      join AdventureWorksLT.dbo.Address a
        on ca.AddressID = a.AddressID

  -- Chinook
  -- Chinook Customers 
  union all
  select  left(c.LastName + ', ' + C.FirstName, 50) 'Name',
          left(c.Country, 20) 'Country',
          c.Phone 'Phone'
  from Chinook.dbo.Customer c

  -- Chinook Employees 
  union all
  select  left(e.LastName + ', ' + e.FirstName, 50) 'Name',
          left(e.Country, 20) 'Country',
          e.Phone 'Phone'
  from Chinook.dbo.Employee e

  -- Publishers (All USA) 
  -- Authors 
  union all
  select
      left(a.au_lname + ', ' + a.au_fname, 50) 'Name',
      left('USA', 20) as 'Country',
      a.Phone
  from Publishers.dbo.Authors a
) 
order by Country, Name

-- Question 4
/*
This question assumes use of NorthwindTraders database. 

Management wants to know who's on top! The top 3 Employees, the top 3 Customers, and the top 4 Suppliers - 10 prizes to be awarded in all! To qualify, in your category, you must be within the top 3 (or 4) of total quantity sold across all orders you are related to, in any given year. Results must be combined, with Category displayed as shown, and ordered by highest to lowest Total Quantity. Notice that there are 3 records for Employees, 3 records for Customers, and 4 records for Suppliers. Employees are listed by "Lastname Firstname"; others are listed by Company name. 

Paste your SQL statement below - this question will be graded manually by your instructor.
*/

(
    -- EMPLOYEES (Top 3 per year)
    select 
        distinct top 3 'Employees' as Category,
        left(e.LastName + ' ' + e.FirstName, 50) 'Entity',
        datepart(year, o.OrderDate) 'Year',
        sum(od.Quantity) 'TotalQuantity'
    from NorthwindTraders.dbo.Employees e
        join NorthwindTraders.dbo.Orders o
            on e.EmployeeID = o.EmployeeID
        join NorthwindTraders.dbo.[Order Details] od
            on o.OrderID = od.OrderID
    group by
        e.LastName, e.FirstName,
        datepart(year, o.OrderDate)


union all


    -- CUSTOMERS (Top 3 per year)
    select distinct top 3
        'Customers' as Category,
        left(c.CompanyName, 50) as Entity,
        datepart(year, o.OrderDate) as Year,
        sum(od.Quantity) as TotalQuantity
    from NorthwindTraders.dbo.Customers c
        join NorthwindTraders.dbo.Orders o
            on c.CustomerID = o.CustomerID
        join NorthwindTraders.dbo.[Order Details] od
            on o.OrderID = od.OrderID
    group by
        c.CompanyName,
        datepart(year, o.OrderDate)


union all


    -- SUPPLIERS (Top 4 per year)
    select distinct top 4
        'Suppliers' as Category,
        left(s.CompanyName, 50) as Entity,
        datepart(year, o.OrderDate) as Year,
        sum(od.Quantity) as TotalQuantity
    from NorthwindTraders.dbo.Suppliers s
        join NorthwindTraders.dbo.Products p
            on s.SupplierID = p.SupplierID
        join NorthwindTraders.dbo.[Order Details] od
            on p.ProductID = od.ProductID
        join NorthwindTraders.dbo.Orders o
            on o.OrderID = od.OrderID
    group by
        s.CompanyName,
        datepart(year, o.OrderDate)
)

order by TotalQuantity desc

