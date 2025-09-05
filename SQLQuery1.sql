select * from dkinganjatou1_Northwind.dbo.Orders

-- Fully qualified names
-- DatabaseName.SchemaName.TableName
-- Ex. Select all the authors from pubs database by using fully qualified names
select * from dkinganjatou1_pubs.dbo.authors

use dkinganjatou1_pubs
go
select * from authors

-- Selecting specific columns
use dkinganjatou1_Northwind
go

select	OrderID as 'Order ID', 
		customerId, 
		Orderdate 
from dkinganjatou1_Northwind.dbo.Orders

-- Count function will give you the number of rows/columns in the 

select	s.first_name as 'Student First Name',
		s.last_name as 'Student Last Name',
		s.student_id as 'Student ID'
from dkinganjatou1_ClassTrak.dbo.Students as s -- You can use alias for table name as well

-- Some terms
-- Table			- Entity
-- Rows				- Records
-- Columns			- Attributes/ fields
-- Primary key[PK]	- Column or set of columns that uniquely identifies each record
-- Composite Key[CK]- If more than one column composite of PK

-- Rest ordering
-- Select all authors

use dkinganjatou1_Pubs
go
select	au_id,
		au_lname,
		au_fname
from authors
order by city desc, 3 asc

-- Order by clause is used to sort your data in ascending or descending order
-- Syntax
-- Order by column
-- Default is asc


