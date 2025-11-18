use publishers
go
select* from employee
select* from jobs
 
--ANSI Syntax
select *
from employee e
     inner join jobs j     --Trnasit centre
     on j.job_id=e.job_id  --Bus or train
     where j.job=13        --Other condition
 
--SQL Server Syntax
select *
from employee e, jobs j    --seprate table list by comma
where j.job_id=e.job_id    --joining condition
      and j.job_id=13      --Other condition
 
--
select j.job_desc, count(*)  'Number of employees'
from employee e
     inner join jobs j      --Transit centre
     on j.job_id=e.job_id
group by j.job_desc
 
--Outer Join
--Left outer join
--Right outer join
--Full outer join
 
use NorthwindTraders
select * 
from employees
select *
from EmployeeTerritories
 
select* 
from employees e
     inner join EmployeeTerritories et
     on e.EmployeeID=et.EmployeeID
 
--I need all the employees
select*
from employees e
     left outer join EmployeeTerritories et 
     on e.EmployeeId=et.EmployeeID
 
--I need information for all employeeeTerritories
select*
from employees e
     right outer join EmployeeTerritories et 
     on e.EmployeeId=et.EmployeeID
 
--Cross Join:all join are cross first then we are filtering the rows
--depending upon the joining condition
 
select *
from products p,Categories c --Cross join if no condition is specified
order by p.ProductID
 
use publishers
go
--Write a query to show all discounts, includong the store name that has a discount
--Tables involved:discount,stores
--Type of join: inner, left, right,cross
 
select* from discounts
select* from stores
 
--innerjoin
select* 
from discounts d
     inner join stores s 
           on d.stor_id=s.stor_id
 
--left join
select* 
from discounts d
     left outer join stores s 
           on d.stor_id=s.stor_id
 
--right join
select* 
from discounts d
     right outer join stores s 
           on d.stor_id=s.stor_id
 
--full outer join
select* 
from discounts d
     full outer join stores s 
           on d.stor_id=s.stor_id
 
--Cross Join
select*
from discounts,stores  