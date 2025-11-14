use Publishers
go 
select fname, lname, 'Employee' as 'Category'
from employee

    union

select au_fname, au_lname, 'Author' as 'Category'
from authors

select fname, 'Employee' as 'Category'
from employee

    union 

select au_fname, 'Author' as 'Category'
from authors

select fname, 'Employee' as 'Category'
from employee

    union all 

select au_fname, 'Author' as 'Category'
from authors

select CompanyName, Phone, 'Customers' as 'Company Type'
from NorthwindTraders.dbo.Customers
union all
select CompanyName, Phone, 'Shippers' as 'Company Type'
from NorthwindTraders.dbo.Shippers
union all 
select CompanyName, Phone, 'Suppliers' as 'Company Type'
from NorthwindTraders.dbo.Suppliers
order by 3 desc -- 3 means company type column

-- Exercise
/*
Write a sect query to list the firstname and last name of all students and instuctors from your own copy of ClassTrak Database. Have a column for 'Status' which will be for 'Student' or 'Intructor'
*/