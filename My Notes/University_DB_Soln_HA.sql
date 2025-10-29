use master
go

--drop database if exists simran_university
--go

--create database simran_university
--go

use dkinganjatou1_University
go

drop table if exists Enrollments 
go
drop table if exists Students
go
drop table if exists Courses
go
drop table if exists Instructors
go


create table Students(
	StudentID 	int 		identity 	primary key,
	FirstName 	varchar(50) 			not null,
	LastName 	varchar(50) 			not null,
	DateOfBirth date 					not null,
	Major 		varchar(50) 
		constraint CH_students_major 
			check (Major in('Computer Science', 'Engineering','Business', 'Arts', 'Science')),
	--calculated field for fun
	Age as datediff(YYYY,DateOfBirth,getdate()),
	
	constraint CH_Students_DateofBirths_over18 check ( datediff(YYYY,DateOfBirth,getdate())>=18)
)
create table Courses(
	CourseID int identity primary key,
	CourseName varchar(50) not null,
	Department varchar(50) not null,
	Credits int not null)
go

/*alter table Courses drop constraint chk_credits
go*/
alter table Courses add constraint chk_Courses_credits check (Credits between 1 and 5)


create table Instructors (
	InstructorID int identity primary key,
	FirstName varchar(50) not null,
	LastName varchar(50) not null
)



create table Enrollments(
	EnrollmentID int identity primary key,
	StudentID int, 
	constraint FK_Enrollments_Students foreign key (StudentID) 
		references Students (StudentID),
	CourseID int not null,
	constraint FK_Enrollments_Courses foreign key (CourseID) 
		references Courses (CourseID),
	InstructorID int,
	constraint FK_Enrollments_Instructors foreign key (InstructorID) 
		references Instructors (InstructorID),
	Grade char(2)
		constraint CH_enrollments_grade
		check ( Grade in ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F')),
	constraint CH_Enrollment_Instructor_Student 
	check (StudentID is not null or InstructorID is not null)
)

-- Testing part
--insert into courses (Coursename, Department, credits)
--values ('CMPE2000','CNT',7)

--delete from courses