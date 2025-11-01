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