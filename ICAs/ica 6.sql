use NorthwindTraders
go

-- Question 1
/*This question uses the NorthwindTraders database.

Rearrange the following so that the query returns the CompanyName, ContactName and City of customers who have orders that have freight over $800. The results should be ordered by CompanyName. Note that this query uses in.*/
declare @freight int = 800

select  c.CompanyName,
        c.ContactName,
        c.City
from Customers c
where c.CustomerID in   (
                            select o.CustomerID
                            from Orders o
                            where o.Freight > @freight
                        )
order by c.CompanyName

-- Question 2
/*This question uses the NorthwindTraders database.

Rearrange the following so that the query returns the CompanyName, ContactName and City of customers who have orders that have freight over $800. The results should be ordered by CompanyName. Note that this query uses exists.*/
select  c.CompanyName,
        c.ContactName,
        c.City
from Customers c
where exists    (
                    select *
                    from Orders o
                    where c.CustomerID = o.CustomerID
                    and o.Freight > @freight
                )
order by c.CompanyName

-- Question 3
/*This question uses the NorthwindTraders database.

Rearrange the following so that the query returns the ProductName and CategoryName of Products that have 0 units in stock.*/
select  p.ProductName,
        (            
            select c.CategoryName
            from Categories c
            where c.CategoryID = p.CategoryID
        ) 'Category'
from Products p
where p.UnitsInStock = 0

-- Question 4
/*This question uses the NorthwindTraders database

Fill in the missing parts of this SQL statement such that it returns the Product Name of products that are in the Confections or Seafood categories,

and have a Unit Price more than 20. Results should be ordered by CategoryId then by Product Name.*/
select ProductName
from Products
where UnitPrice > 20
and CategoryID in   (
                        select CategoryID
                        from Categories
                        where CategoryName in ('Confections', 'Seafood')
                    )
order by CategoryID, ProductName

-- Question 5
/*This question assumes use of the NorthwindTraders database.

Fill in the following template so that the SQL Statement returns the indicated company information. Results are restricted to only those customers who have associated Order Details records with Unit Price * Quantity less than 15. The provided variable must be used. Results must be ordered by the Customer's country. Indicated table aliases must be used for all column references.*/
declare @amount int = 15

select  c.CompanyName as 'Company Name',
        c.Country
from Customers c
where exists    (
                    select *
                    from Orders o
                    where o.CustomerID = c.CustomerID
                    and exists  (
                                    select *
                                    from [Order Details] od
                                    where od.OrderID = o.OrderID
                                    and od.UnitPrice * od.Quantity < @amount
                                )
                )
order by c.Country