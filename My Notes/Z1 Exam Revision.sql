use NorthwindTraders
go

--Follow this checklist while working on questions

--CHECKLIST
-- which database  		    : 
-- which table    			: 
-- what columns    			: 
-- condition                 :  
-- sorting involved             : 
-- Look for column headers      :
-- Function					    :
-- How to deal with null values :

select isnull( cast(ShippedDate as varchar(10)), 'N/a'),
       coalesce (orderdate, null, 'N/a')
from orders
where shippedDate is null 

select orderdate,
       RequiredDate,
       datediff(dd, orderDate, requiredDate),
       datediff(dd, requiredDate, orderDate)
from orders
where abs(datediff(dd, orderDate, requiredDate)) < 20

select *
from orders
where shipcity like '_[ea]%'
-- looking for er letters together anywhere
select *
from orders
where
shipcity like '%er%'  --Lander
-- looking for letter e or r anywhere 
select *
from orders
where
shipcity like '%e%' or shipcity like '%r%'  -- Aebcgr

-- version 1  27 August 2019
select *
from orders
where day(OrderDate) = 27
      and  month(orderdate) = 08
      and year (orderdate) = 2019

-- version 2
select *
from orders
where datediff(dd,orderdate, '2019-08-27') = 0

-- version 3
select *
from orders
where orderdate > '2019-08-27' and 
      orderdate <= '2019-08-28'

-- version 4
select *
from orders
where  cast(orderdate as date) = '2019-08-27'

-- version 5
select *
from orders
where datepart(day, orderdate) = 27
      and datepart(month, orderdate)= 08
      and datepart(year, orderdate) = 2019

select cast(EmployeeID as varchar(10)) + ' '+ shipcity ,
       concat_ws(' ',EmployeeID, ShipCity)  'Empid City'
from orders

select CustomerId,
       EmployeeID as 'emid'
from orders
where 'emid' >1  -- XX Always use column name/function
order by 'emid' desc, orderdate

select top 3 with ties CustomerId,
       EmployeeID as 'emid'
from orders
where EmployeeID >1  -- XX Always use column name/function
order by 'emid' desc

select distinct ShipCity, employeeid -- any unique combination
from orders
order by 1



use harsimrana_IQSchool
go

--1. Select all the information from the club table

select * from Club
-- changing column headers
select ClubID 'Club ID', left(ClubName,5) 'Club Name' from Club

--2. Select the FirstNames and LastNames of all the students

select firstname, lastname from student

--3. Select all the CourseId and CourseName of all the coureses. Use the column aliases of Course ID and Course Name

select courseId 'CourseID',
       coursename as 'Course Name'
from Course

--4. Select all the course information for courseID 'DMIT101'

select * from course
where CourseId = 'DMIT101'

select * from course
where CourseId like 'DMIT%'

--5. Select the Staff names who have positionID of 3
-- some experiments are done
select firstname + ' : '+ lastname + cast(PositionID as varchar(10)) 'Name' ,
       concat_ws(' : ',firstname , lastname, PositionID ) 'Name'
from staff
where PositionID = 3

--6. select the CourseNames whos CourseHours are less than 96

select CourseName, CourseHours
from Course
where CourseHours < 96


--7. Select the studentID's, OfferingCode and mark where the Mark is between 70 and 80
Select studentid, OfferingCode, mark from Registration where Mark between 70 and 80

--8. Select the studentID's, Offering Code and mark where the Mark is between 70 and 80 and the OfferingCode is 1001 or 1009

Select studentid, OfferingCode, mark from Registration 
where (Mark between 70 and 80) and OfferingCode in (1001,1009)

--9. Select the students first and last names who have last names starting with S
Select firstname, lastname from Student
where LastName LIKE 'S%'

--10. Select Coursenames whose CourseID  have a 1 as the fifth character
Select Coursename from Course
where CourseId like '____1%'

--11. Select the CourseID's and Coursenames where the CourseName contains the word 'programming'
Select courseid, Coursename from Course 
where CourseName like '%programming%'

--12. Select all the ClubNames who start with N or C.
Select clubname from club where clubname like 'N%' or Clubname like 'C%'
--OR
Select clubname from club where clubname like '[NC]%'

--13. Select Student Names, Street Address and City where the lastName has only 3 letters long.
Select firstname, lastname, streetaddress, city from Student
where  lastname like '___'
--OR wth len function (have not learned yet)
Select firstname, lastname, streetaddress, city from Student
where  len(lastname) =3
--14. Select all the StudentID's where the PaymentAmount < 500 OR the PaymentTypeID is 5
Select studentid from Payment where amount <500 or PaymentTypeID =5




