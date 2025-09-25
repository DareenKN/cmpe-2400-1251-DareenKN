-- Week 01 Day 03 : 05 Sep 2025
-- Author : Harsimranjot

-- The use statement specifies which database to access
use dkinganjatou1_Northwind
go
-- go causes the current group of statements to be executed
-- immediately by the query processor

/*
To Execute your query, press F5 on the top row of keyboard
or click on execute button
*/

-- To select information from any table
-- use select clause

-- * means all columns
-- avoid using * in production environment
   -- Table is changed, it will break your code
   -- to avoid using extra resouces
select * from products

-- Ex. I want all data about customer orders
   -- find right table
   -- Expand database tree in the left pane
   -- auto complete can help when you fill stuff for from clase
   -- Use database diag.
   -- Built in stored procedures

exec sp_tables -- built in Stored procedure to get all the tables in the selected database


select count(*) 'Number of Orders' from Orders
-- count function will give you the number of rows/records in the table

-- Fully qualified names
-- DatabaseName.SchemaName.TableName

select * from dkinganjatou1_Northwind.dbo.orders

--Ex. Select all authors from pubs database by using fully qualified names

-- Selecting specific columns
use dkinganjatou1_Northwind
go

select OrderID as 'Order ID',
       customerId 'Customer ID',
       Orderdate
from dkinganjatou1_Northwind.dbo.orders

-- Columns Alias
-- use as keywords to provide alias for your column
-- Keyword as is optional
-- Syntax
--  Column Name as 'NameofYourChoice'
-- Why Alias
   -- Change the name of the column 
   -- Name Calculated fields/ column/ attributes

select s.first_name as 'Student First Name',
       s.last_name as 'Student Last Name',
       s.student_id 'Student ID'
from dkinganjatou1_ClassTrak.dbo.students as s -- You can use alias for table name as well

-- Some Terms
-- Table            -   Entity
-- Rows             -   Records
-- Columns          -   Attributes/ fields
-- Cell             -   where data is actually stored
-- Primary Key [PK] -   Column or set of columns that uniquely identifies each record
-- Composite Key[PK] -  If more than one columns Composite PK

-- Result ordering 
-- select all authors

use dkinganjatou1_pubs
go
select * 
from authors
order by city desc
-- order by clause is used to sort your data in ascending or descending order
-- Syntax
-- order by column
-- default is asc

use dkinganjatou1_pubs
go
select au_id, 
       au_lname,
       au_fname as 'First Name'
from authors
-- Three version : Uncomment the one you want to test
--order by city desc, au_fname asc   -- Actual column names
--order by city desc, 3 asc          -- order number of column in the selected list
order by city desc, 'First Name' asc -- Alias

use NorthwindTraders
go

exec sp_statistics suppliers
exec sp_columns suppliers
exec sp_server_info
exec sp_tables

use NorthwindTraders
go

select  FirstName,
        LastName,
        HireDate,
        City
from Employees

select * from region

select Shippers.CompanyName from NorthwindTraders.dbo.Shippers

select s.first_name as 'Student First Name',
       s.last_name as 'Student Last Name',
       s.student_id 'Student ID'
from dkinganjatou1_ClassTrak.dbo.students as s


select  e.LastName,
        e.FirstName,
        e.BirthDate 

from Employees e
order by e.BirthDate desc



