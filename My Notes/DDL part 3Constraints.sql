use master
go

--drop database if exists dkinganjatou1_classpractice
--go

--create database dkinganjatou1_classpractice
--go

use dkinganjatou1_classpractice
go

-- drop table 
drop table if exists Marks
drop table if exists Student
go

create table student
(
	St_id char(9) not null
		constraint PK_StudentId primary key clustered,
	LastName varchar(20) not null
)

-- check constraint
/*
	constraint CK_name check ( expression )
	expression
	  1. cannot be a subquery 
	  2. must evaluate to true or false
	  3. can be compound boolean expression using logical operator && ||
	  4. can refer to another columns in the same table one

*/
create table Marks
(
	St_id char(9) not null
		constraint FK_Marks_to_Student references student(St_id),
	courseId char(4) not null          -- first letter C second any [a-z] third and fourth should be number
	  constraint CH_CourseId check (courseId like 'C[a-z][0-9][0-9]'),
	marks float null 
		constraint CH_PostiveMarks check (marks >= 0),
    MaxMarks float 
	   constraint DF_MaxMarks default 100,  -- sqrt(100)  or null
	-- table level- if more than one column is involved 
	constraint PK_Mark_Stid_courseid primary key clustered (St_id, courseId),

	constraint CH_MarksLessThanMax check ( marks <= MaxMarks)
)
go
-- FOR TESTING PURPOSE- DON't Worry about insert part now
insert into Marks        -- fail because negative marks value
values (1, 'ca34', -3, 100 )

insert into Marks        -- fail because marks > max 
values (1, 'ca34', 101, 100 )

insert into Marks        -- fail - FK constraint no value for student 1 in Students table
values (1, 'ca34', 90, 100, null )

insert into Student        -- fail because negative marks value
values (1, 'ABC' )


-- Foreign key constraint 

-- Drop a child table before you drop the associated parent table
-- Create a parent table before you create the associated child table
-- The value of a column acting a foregn key be:
	-- a. A value that exists as a PK in parent table
	-- b. NULL


/*
Default Constraint  can be applied on any column
except 
	1. a column with timestamp datatype
	2. a column with the identity property 

	Constraint DF_NameofConstraint Default constant |  null  |  function
*/




-- Alter table 
/*
Alter Table table name
	add column_name properties
	add table lvevle constraint 
	alter column_name_existing_one

	drop column column_name
	drop constraint constraint_name
	
	check | no check constraint contraint_name
*/

-- adding a new column to marks table

alter table Marks
	add
	semesterId char(9) null
		constraint DF_semesterid default null


select * from marks-- 

-- dropping constraint
alter table Marks
	drop 
	constraint DF_semesterid
-- drop a column

alter table marks 
	drop
	column semesterId

alter table marks 
	add
	semesterId char(9) null

alter table marks 
	add                               -- for column name
	constraint DF_semesterId default null for semesterId

-- disable a constraint 
alter table marks 
	nocheck constraint CH_CourseId

-- enable a constraint 
alter table marks 
	check constraint CH_CourseId

-- check constraints using built in Stored procedure 
exec sp_help Marks