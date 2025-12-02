--Week 14 Day 01 02.12.2025
--PL/SQL, STored Procedures
--SQL Programming Basic
/*
1.How to decalre a variable?
2
2.a Branching: if,if else, case
2.b Looping: while loop
3.User Defined functions/Stored Procedure
*/

--1. How to decalre variables?
--decalre @name dataType= value --Declaration AND INITIALIZATION
--decalre @name dataType        --Declaration
--set @name = value             --Assigning value to variable SET keyword @ is very important

declare @age int =20
--print this value

print @age
--select @agee will appear as a table

declare @nameOfStudent varchar(40)
set @nameOfStudent = 'Eunice'

print 'Name of the Student = '+ @nameOfStudent

-- 2. Control Flow Statements
-- 2a. Branching: if, if else, case
-- 2b. Looping: while loop

declare @marks int = 60

if @marks >= 50 -- No parenthesis around condition
    print 'You are pass'    -- No curly brackets if ther is a single statement
else
    print 'Come again in the next term'
GO

declare @marks int = 40
declare @grade CHAR

if @marks >= 50
        begin
            set @grade = 'A'
            print 'You are pass'
        end
    else
        begin
            set @grade = 'F'
            print 'Come again in the next term'
        end
print 'Your Grade = ' + @grade

-- case which is similar to switch statement in C#
-- First version
/*
    case Startingvalue then action 1
        when comparisonvalue then action 1
        when comparisonvalue1 then action 2
        ..
        ..
        else action n
    end
*/
declare @caseResultValue varchar(30)
set @caseResultValue = case len('TEST')
                            when 1 then 'Length is 1'
                            when 2 then 'Length is 2'
                            when 3 then 'Length is 3'
                            when 4 then 'Length is 4'
                            else 'Over 4'
                        end
-- to end your case statement
print @caseResultValue

-- Sencond Version of case
/*
    case
        when booleanExpression then action
        when booleanExpression then action1
        ...

        else action n
    end
*/
declare @marks1 int = 100
print case
    when @marks1 >= 91 and @marks1 <= 100
        then 'Grad is A+'
    when @marks1 >= 81 and @marks1 <= 90
        then 'Grade is A'
    else -- default case in switch statement
        'Grade is F'
    end

-- 2b. Looping: while loop
declare @i int = 1
declare @sum int = 0

print 'Numbers from from 1 to 10'

while @i <= 10
    begin
        print @i
        set @sum = @sum + @i
        set @i = @i + 1
    end

print 'Sum of Numbers = ' + convert(varchar(10), @sum)

-- 3.User Defined functions/Stored Procedure
use dkinganjatou1_pubs
go

-- Alternative 1
drop procedure if exists SP_AuthorNames
go

-- Alternative 2
if exists
(
    select [name]
    from sysobjects
    where [name] = 'SP_AuthorNames'
)
drop procedure SP_AuthorNames
go

-- Define a stored procedure
create procedure SP_AuthorNames
as
    select au_fname + ' ' + au_lname 'AuthorName'
    from dkinganjatou1_pubs.dbo.authors -- Better to use fully qualified names here
go        

-- To run stored procedures
execute SP_AuthorNames
-- Shorter form, same result
exec SP_AuthorNames


-- Making sure to drop procedure
drop procedure if exists SP_TitlesInfo
go

-- Create procedure with parameter
create procedure SP_TitlesInfo
-- You can include parameters
@TitleId varchar(6)
as 
    select * 
    from dkinganjatou1_pubs.dbo.titles
    where title_id = @TitleId
go

exec SP_TitlesInfo 'BU1032'

exec sp_help titles



