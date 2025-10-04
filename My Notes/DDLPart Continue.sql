-- Week 4 Day 1 23.09.2025
-- DDL PART Continue
-- always switch to master or any other db before executing drop statement
use master
go

--drop database if exists harsimran_1251_DDL_A02
--go
---- create new database
--create database harsimran_1251_DDL_A02
--go

-- now switch newly created database
use harsimran_1251_DDL_A02
go

-- if there is no relation between tables,
-- you can delete them any order
-- student and studenttocourse are connected
-- course and studenttocourse are also connected
drop table if exists studenttocourse
drop table if exists students
drop table if exists instructors
drop table if exists courses

go

-- same is true here if there is no relation
-- between tables
create table students
(   -- identity is autoincrement value
                   -- seed, increament
	[sid] int identity (100,1) not null primary key,
	sfirstname varchar(30) not null,
	slastname varchar(30) null,
	email varchar(15) null,
	phone char(12) not null
)

create table Instructors
(
	Iid int identity(1000, 1) not null primary key,
	Ifirstname varchar (30) not null,
	Ilastname varchar(30) null,
	email varchar(15) null,
	phone char(12) not null,
	salary money null,
	hiredate datetime null 
)


create table courses
(
	courseid int identity (1000, 1) not null primary key,
	coursename varchar(20) not null,
	coursecredits float(2) null,
	courseduration int null
)

create table studenttocourse
(
	[studentid] int 
	  constraint FK_sid references students([sid]),
	courseid int 
      constraint FK_courseId references courses(courseid)
)

go

select *
from students

-- To check information about any table
exec sp_help studenttocourse

-- BREAK TIME : 09:10 am

-- Date Functions

use harsimrana_Northwind
select  * 
from Orders
where year(OrderDate) = 2020

--day(), month(), year()
select day('2019-09-23') as 'Day',
       month('2019-09-23') 'Month' ,
	   year('2019-09-23') 'Year',
	   datepart(dy, '2025-09-23')
	   
select OrderDate,
       day(OrderDate),
	   -- datepart, date  
	   datepart(dy , OrderDate)  -- interger representation of datepart
from orders

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

-- To check information about any table
exec sp_help orders
