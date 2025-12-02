---- Week 12 Day 03 21.11.2025: DML Operations: 
---- INSERT, UPDATE and DELETE

-- use master 
-- go 

-- create database DMLDemo
-- go 

-- use DMLDemo

-- create table Students
-- (
-- 	sid int identity (100, 1) primary key,
-- 	Slname varchar(30),
-- 	Sfname varchar(30),
-- 	phone  char(12),
-- 	email varchar(30) not null
-- )
-- go

use DMLDemo 
-- How to insert data into any table

insert into Students
		(slname, Sfname, phone, email)
values 
		('Aulakh', 'Harsimran','587-000-0007', 'simran@nait.ca')

select * from Students

-- Multiple rows same time 
insert into Students
		(slname, Sfname, phone, email)
values 
		('Aulakh', 'Harsimran','587-000-0007', 'simran@nait.ca'),
		('Kelemen', 'Shane','587-000-0009', 'Shane@nait.ca'),
		(null , 'Steven','587-000-0007', 'steven@nait.ca');

insert into Students
		(slname, Sfname, phone, email)
values                 -- Not possible to insert null for email because it is mandatory column
		('Aulakh', 'Harsimran','587-000-0007', null)

-- Try to insert something for student ID
-- Not possible because Sid is identity column
insert into Students
		([sid], slname, Sfname, phone, email)
values                 
		(104, 'Aulakh', 'Harsimran','587-000-0007', 'Simran@nait.ca')


select * from Students
-- Delete any student
Delete from students 
where sid = 101 -- without where clause it will delete everything


insert into Students
		(slname, Sfname, phone, email)
values 
		('Abc', 'Abc','587-000-0007', 'simran@nait.ca')

-- is it possible to disable identity for a specific situation
set identity_insert DMLdemo.dbo.students on

insert into Students
		([sid], slname, Sfname, phone, email)
values                 
		(101, 'Xyz', 'fasdfs','587-000-0007', 'Simran@nait.ca')

select * from Students

-- enable identity again by setting it to off
set identity_insert DMLdemo.dbo.students off

-- Update existing data
update students
set email = 'newemail@nait.ca'
where sid = 101  --WITHOUT WHERE YOU CAN IMAGINE 


update students
set email = 'newemail@nait.ca',
    phone = '000-000-0000'
where sid = 101  --WITHOUT WHERE YOU CAN IMAGINE 

select * from students