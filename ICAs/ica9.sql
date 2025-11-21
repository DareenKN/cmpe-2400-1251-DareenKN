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

select top 100 percent
    left(Name, 50) as Name,
    left(Country, 20) as Country,
    Phone
from (
    /* ====================== Northwind ====================== */

    /* Customers with CompanyName */
    select
        left(C.CompanyName, 50) as Name,
        left(C.Country, 20) as Country,
        C.Phone
    from NorthwindTraders.dbo.Customers C
    where C.CompanyName is not null
      and C.Phone is not null

    union all

    /* Customers with First/Last Name */
    select
        left(P.LastName + ', ' + P.FirstName, 50) as Name,
        left(P.Country, 20) as Country,
        P.Phone
    from (
        select
            LastName, FirstName, Country, Phone
        from NorthwindTraders.dbo.Customers
        where CompanyName is null
          and Phone is not null
    ) P

    union all

    /* Employees */
    select
        left(E.LastName + ', ' + E.FirstName, 50) as Name,
        left(E.Country, 20) as Country,
        E.HomePhone as Phone
    from NorthwindTraders.dbo.Employees E
    where E.HomePhone is not null


    /* ====================== AdventureWorksLT ====================== */

    /* Customers with CompanyName */
    union all
    select
        left(C.CompanyName, 50) as Name,
        left(A.CountryRegion, 20) as Country,
        C.Phone
    from AdventureWorksLT.dbo.Customer C
        join AdventureWorksLT.dbo.CustomerAddress CA on C.CustomerID = CA.CustomerID
        join AdventureWorksLT.dbo.Address A on CA.AddressID = A.AddressID
    where C.CompanyName is not null
      and C.Phone is not null

    /* Customers with First/Last Name */
    union all
    select
        left(P.LastName + ', ' + P.FirstName, 50) as Name,
        left(A.CountryRegion, 20) as Country,
        C.Phone
    from AdventureWorksLT.dbo.Customer C
        join AdventureWorksLT.dbo.Customer P on C.CustomerID = P.CustomerID
        join AdventureWorksLT.dbo.CustomerAddress CA on C.CustomerID = CA.CustomerID
        join AdventureWorksLT.dbo.Address A on CA.AddressID = A.AddressID
    where C.CompanyName is null
      and C.Phone is not null


    /* ====================== Chinook ====================== */

    /* Chinook Customers */
    union all
    select
        left(C.LastName + ', ' + C.FirstName, 50) as Name,
        left(C.Country, 20) as Country,
        C.Phone
    from Chinook.dbo.Customer C
    where C.Phone is not null

    /* Chinook Employees */
    union all
    select
        left(E.au_lname + ', ' + E.FirstName, 50) as Name,
        left(E.Country, 20) as Country,
        E.Phone
    from Chinook.dbo.Employee E
    where E.Phone is not null


    /* ====================== Publishers (All USA) ====================== */

    /* Authors */
    union all
    select
        left(A.au_lname + ', ' + A.au_fname, 50) as Name,
        left('USA', 20) as Country,
        A.Phone
    from Publishers.dbo.Authors A
    where A.Phone is not null

    /* Publisher Companies */
      union all
    select
        left(P.Name, 50) as Name,
        left('USA', 20) as Country,
        P.Phone
    from Publishers.dbo.Publishers P
    where P.Phone is not null
) X
order by Country, Name;

select
        left(P.Name, 50) as Name,
        left('USA', 20) as Country,
        P.Phone
    from Publishers.dbo.Publishers P

select *
    from Publishers.dbo.Publishers P