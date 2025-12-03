-- Question 1
/*
This question requires use of your personal ClassTrak DB

1. Rearrange the SQL Statement to insert a new instructor named Adrian Hunterson. [10 marks]
*/
use ClassTrak
go

-- select *
-- from Instructors

insert into Instructors
    (last_name, first_name)
values
    ( 'Hunterson' , 'Adrian' )


/*
2. Declare a variable called @InstructorId that can hold an integer value [2 marks]
*/

declare @InstructorId int

/*
3. Assign the newly generated ID for Adrian Hunterson to @InstructorId (no hardcoding and no select statement allowed)  [3 marks]
*/
set @InstructorId = @@identity
print @InstructorId

-- Question 3
/*
This question assumes use of your personal ClassTrak database. 

1. Rearrange the following to insert a new course: CMPE1010 "Aero-computing" [10 marks]
*/
insert into Courses
    (course_abbrev, course_desc)
values
    ( 'CMPE1010' , 'Aero-Computing' )



declare @CourseID int=@@identity
print @CourseID

-- Question 3
/*
This question assumes use of your personal ClassTrak database. 

1. Rearrange the following to insert a new Class [10 marks]:

Description: "Computing in Airplanes"
Start Date: September 1, 2025
The Instructor Id is stored in @InstructorId
The Course Id is stored in @CourseId
*/


-- is it possible to disable identity for a specific situation
-- set identity_insert ClassTrak.dbo.Instructors off
-- set identity_insert ClassTrak.dbo.Classes off

insert into Classes
    (class_desc, instructor_id, course_id, start_date)
values
    ('Computing in Airplanes', @InstructorId, @CourseId, '2025-Sep-01')

print @CourseID
print @InstructorId

-- select *
-- from Classes

-- Question 4
/*
This question assumes use of your personal ClassTrak database.

Add all students whose last name starts with a vowel to the new class, identified by @ClassId [15 marks]
*/

declare @ClassId int = @@identity

insert into Class_To_Student
    (class_id, student_id, active)
select @ClassId, s.student_id, 1
from students s
where s.last_name like '[aeiou]%'      

select * from class_to_student
order by class_to_student_id
select * from Students s
where s.last_name like '[aeiou]%' 

-- Question 5
/*
This question assumes use of your personal ClassTrak database. 

Write the select statements to prove that the inserts in questions 1-4 worked correctly. These statements must run independently of your previous statements (do not use variables stored from before)

Select the newly added instructor from the Instructors table
All courses that have a course abbreviation starting with 'CMPE10'
All classes that Adrian Hunterson is teaching
All students who are in any class that Adrian Hunterson is teaching, ordered by Student Lastname, Firstname 

Paste your 4 SQL statements below - this question will be graded manually by your instructor. Each statement is worth 5 marks.
*/

select *
from Instructors
where instructor_id = 16

select * 
from Courses
where course_abbrev like 'CMPE10%'

select *
from Classes
where instructor_id = 16

select s.*
from Students s 
    join class_to_student cs
        on s.student_id = cs.student_id
    join Classes c
        on cs.class_id = c.class_id
where c.instructor_id = 21
order by s.last_name, s.first_name