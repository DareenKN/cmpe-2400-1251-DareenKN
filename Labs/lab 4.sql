-- Question 1
/*
You found a stored procedure that is already built in to SQL Server! Look at the following execution samples, assuming NorthwindTraders database, and answer the following questions.
*/
use NorthwindTraders
go 

exec sp_depends @objname = 'Order Details'

exec sp_depends 'Order Details'

exec sp_depends

/*
Which of the above executions will display dependencies for 'Order Details'	
- Execution on Line 1
- Execution on Line 3
- Execution on Line 5
- None of the Above
*/

