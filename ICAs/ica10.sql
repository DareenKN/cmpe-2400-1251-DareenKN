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

-- select *
-- from Instructors


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
    ('Computing in Airplanes', 15, 29, '2025-Sep-01')

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
print @ClassId

insert into Class_To_Student
    (class_id, student_id, active)
select 139, s.student_id, 1
from students s
where s.last_name like '[aeiou]%'

select *
from class_to_student
order by class_to_student_id
select *
from Students s
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
where instructor_id = 15

select *
from Courses
where course_abbrev like 'CMPE10%'

select *
from Classes
where instructor_id = 15

select s.*
from Students s
    join class_to_student cs
    on s.student_id = cs.student_id
    join Classes c
    on cs.class_id = c.class_id
where c.instructor_id = 15
order by s.last_name, s.first_name

-- 

-- Question 6
/*
This question requires use of your personal ClassTrak DB

1. Rearrange the SQL Statement to change add an 'x' to the end of all students' lastnames. Ensure that the statement is rolled back at the end. [10 marks]
*/
begin transaction
update students 
set last_name = last_name + 'x'
rollback 

/*
Provide the statement to display all the records to see if they were updated: 
hint: (four "words/symbols" separated by 3 spaces) [3 marks]
*/
select * from Students

/*
3. Assuming you ran the above statement after a rollback, which one or more of the below would be true statements?
	
* When executed after rollback, the verification statement is not useful in testing if the update statement performed the update correctly.
	
* The update statement would appear to not have changed anything.
	
* The verification statement's results would prove that the update statement worked as intended.
	
* The verification statement would need to be executed before the rollback in order to verify the effect of the update statement.
*/

-- The update statement would appear to not have changed anything.
-- The verification statement would need to be executed before the rollback in order to verify the effect of the update statement.

-- Question 7
/*
This question requires your local ClassTrak DB, and requires the completion of questions 1-5 first.

Produce the following SQL statements, in the indicated order, that will effectively remove all data that was inserted in questions 1-5. Assume that years have perhaps gone by since questions 1-5 were completed - so you cannot simply "continue the script" from those previous questions!

Remove all students from the "Computing in Airplanes" class with no use of variables (use a join and filtering) [5 marks]
Create variables that will be used to store the following: [6 marks]
ClassId of the "Computing in Airplanes" class
CourseId for CMPE1010
InstructorId for Adrian Hunterson
Use ONE select statement against ONE table to populate the above variables. Hint: the Classes table holds all this information [4 marks]
Using the above variables: [6 marks]
Delete the Computing in Airplanes class
Delete the CMPE1010 course
Delete the Adrian Hunterson instructor record
Provide select statements that confirm the removal of all the above was successful. [4 marks]
*/


select s.*
from Students s
    join class_to_student cs
    on s.student_id = cs.student_id
    join Classes c
    on cs.class_id = c.class_id
where c.class_desc like 'Computing in Airplanes'

-- Big no on this one haha
delete s
from Students s
    join class_to_student cs
    on s.student_id = cs.student_id
    join Classes c
    on cs.class_id = c.class_id
where c.class_desc like 'Computing in Airplanes'
-------------------------------------------------
--Final Part 1
delete cs
from class_to_student cs
    join Classes c 
        on cs.class_id = c.class_id
where c.class_desc = 'Computing in Airplanes'

-- Final Part 2
declare @ClassId int, 
        @CourseId int,
        @InstructorId int

-- Final Part 3
select  @ClassId = c.class_id,
        @CourseId = c.course_id,
        @InstructorId = c.instructor_id
from Classes c
where c.class_desc = 'Computing in Airplanes'

print @ClassId
print @CourseID
print @InstructorId

-- Final Part 4
delete from Classes 
where class_id = @ClassId

delete from Courses
where course_id = @CourseID

delete from Instructors
where instructor_id = @InstructorId

-- Final Part 5
select * from class_to_student 
where class_id = @ClassId
select * from Classes
where class_id = @ClassId
select * from Courses
where course_id = @CourseID
select * from Instructors
where instructor_id = @InstructorId


select * from Classes c
where c.class_desc like 'Computing in Airplanes'