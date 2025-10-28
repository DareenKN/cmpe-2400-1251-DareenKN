-- Use master as another database first
use master
go

-- Drop DB/ Create DB commented out
-- drop database if exists dkinganjatou1_University
-- create database dkinganjatou1_University

-- Use my newly created DB
use dkinganjatou1_University
go

-- Dropping tables
drop table if exists Enrollments
drop table if exists Students
drop table if exists Courses
drop table if exists Instructors
go 


-- Creating tables
create table Students 
(
    StudentID int not null primary key,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    DateOfBirth datetime not null 
        constraint CH_DateOFBirth check (datediff(year, DateOfBirth, getdate()) >=18),
    Major varchar(50) not null
)
go

create table Courses
(
    CourseID int not null primary key,
    CourseName varchar(50) not null,
    Department varchar(50) not null,
    Credits int not null
)
go

create table Instructors
(
    InstructorID int not null primary key,
    FirstName varchar(50) not null,
    LastName varchar(50) not null
)
go 

create table Enrollments
(
    EnrollmentID int not null primary key,
    StudentID int not null
        constraint FK_StudentID references Students(StudentID),
    CourseID int not null
        constraint FK_CourseID references Courses(CourseID),
    InstructorID int not null 
        constraint FK_InstructorID references Instructors(InstructorID),
    Grade varchar(50) not null
)