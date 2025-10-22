/*
Week 04 Day 02: 24.09.2025
Date Functions 

*/
-- Already  covered:
-- day(), month(), year(), datepart()

-- Today:
-- 

--UTC Time: Standard globally used to regulate clocks and time 
select getdate() 'Current Date and Time of server',
	   getutcdate() 'Current Coordinated Universal Time'

--dateadd() : return a new datetime value based on adding an internal
-- to the date provided
-- Syntax : dateadd(datepart, number, date)

/*
possible dateparts values
Year		yyyy	yy
Month		mm		m
Day			dd		d
DayofYear	dy		y
Week		wk		ww
quater		qq
Hour		hh	
Minute		mi		n
seconds		ss		s
millisecond ms

*/
select dateadd(dd, 4, getdate()) 'Date after 4 days',
	   dateadd(mm, 6, getdate()) 'Date after 6 months',
	   dateadd(hh, 70, getdate()) 'Date after 70 hours'

/*
datediff() - returns the difference between twon dates
Syntax : datediff(datepart , startValue, Enddate)
*/

select datediff(dd, '2025-09-02', getdate() ) ' Number of days since semester starts',
	   datediff(hh, '2025-09-02', getdate() ) ' Number of hours since semester starts'
-- 543 - 18 - 10 = 515 7 * 22 = 154 515- 154 = 461

-- Ex1 : List all the orders which are shipped within 4 days after order is places

use harsimrana_northwind
go
select orderdate,
       isnull( cast(ShippedDate as char(20)), 'n/a') as 'Shipped Date', 
	   isnull( convert( char(20), ShippedDate), 'n/a') as 'Shipped Date', 
	   isnull( datediff(dd,orderdate, ShippedDate), 0) as 'Numberofdays'
from orders
--where datediff(dd,orderdate, ShippedDate) = 4  -- You cannot use alis or column number in where clause
order by Numberofdays

-- isnull( Value , ReplacedValue) : if value is null, it will be replaced by second arguments

-- cast( expression as datatype)
-- covert (datatype , expression)

declare @userId int = 5  -- Declaration and initialization together
declare @userId1 int -- declaration
set @userId1 = 5  -- assignment

print 'Your name is 
          simran' + ' Instructor: ' + cast(@userId1 as varchar(1)) 

select LastName + space(1) + FirstName  as 'Name ' 
from Employees

select left(LastName + space(1) + FirstName, 5) as 'Name ' 
from Employees

select isnull(left(LastName + space(1) + FirstName, 5), 'n/a') as 'Name ' 
from Employees