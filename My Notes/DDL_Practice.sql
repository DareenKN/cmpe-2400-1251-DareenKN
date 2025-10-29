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
go 
drop table if exists Students 
go       
drop table if exists Courses  
go       
drop table if exists Instructors    
go 
 


-- Creating tables
create table Students 
(
    StudentID   int identity primary key,
    FirstName   varchar(50)     not null,
    LastName    varchar(50)     not null,
    DateOfBirth date            not null,         
    Major       varchar(50)     not null,
    constraint CH_students_major
        check (Major in ('Computer Science', 'Engineering', 'Business', 'Arts', 'Science')),
    constraint CH_Students_DateOfBirth_over18 
        check (datediff(year, DateOfBirth, getdate()) >=18)
)
go

create table Courses
(
    CourseID    int identity primary key,
    CourseName  varchar(50) not null,
    Department  varchar(50) not null,
    Credits     int         not null,
    constraint CH_Courses_Credit_rangeWithin6
        check (Credits between 1 and 6)
)
go

create table Instructors
(
    InstructorID    int identity primary key,
    FirstName       varchar(50) not null,
    LastName        varchar(50) not null
)
go 

create table Enrollments
(
    EnrollmentID int identity primary key,
    StudentID int
        constraint FK_Enrollments_StudentID foreign key
            references Students(StudentID),
    CourseID int not null
        constraint FK_Enrollments_CourseID foreign key
            references Courses(CourseID),
    InstructorID int
        constraint FK_Enrollments_InstructorID foreign key
            references Instructors(InstructorID),
    Grade char(2) not null
        constraint CH_Enrollments_Grade_checkRange
            check (Grade in ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-','F')),
    constraint CH_Enrollment_Instructor_Student
        check (StudentID is not null or InstructorID is not null)

)

-- Index for improved search
create index IX_Student_LastName on Students(LastName)
create index IX_Courses_Department on Courses(Department)
create index IX_Enrollments_StudentID on Enrollments(StudentID)
create index IX_Enrollments_CourseID on Enrollments(CourseID)
create index IX_Instructors_LastName on Instructors(LastName)