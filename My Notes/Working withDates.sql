-- Week 05 Day 03 03.10.2025
-- Working With dates

--Write suitable statements, using the getdate()
--function (with appropriate cast), to display:
--1. The current time, giving fractional seconds to 4
--decimal places
select cast(getdate() as time(4)) as 'Time only' -- 4 means fractional seconds to 4 decimal places
--2. The current date only (time not displayed)
select cast(getdate() as date) as 'Date only'
select convert(varchar , getdate(), 1)  -- Observe 3rd parameter with covert: style value
select convert(varchar , getdate(), 101)
--3. The current date and time, giving the fractional
--seconds to 5 decimal places
select cast(getdate() as datetime) 'Date and Time' -- it supports only 3 decimal places for fractional seconds
-- datetime2 supports 7 digits for fractional seconds: 7 default value
select cast(getdate() as datetime2(5)) 'Date and Time'
select cast(getdate() as datetimeoffset(5)) 'Date and Time'
/*
covert the value to datetimeoffset, which stores:
Date, Time and Time zone offset (the difference from UTC )
(5) specifies the fractional seconds precision
het it keeps to 5 digits after the seconds e.g 32333 [value may differ if you are going to run it at different time]

+00:00 means the stored time is in Coordinated Universal time [UTC]
Ex. -06:00 would mean 6 hours behind UTC [like in Alberta during standard time]
Ex. +5:30  would mean 5 hour and 30 minutes aheaf of UTC [like Indian time standard]

Why it shows +00:00
Casting Getdate() which has no time zone to datetimeoffset defaults to UTC offset of +00:00

If you want your local offset, you would use sysdatetimeoffset()
*/

select getdate(), getUTCdate(), SYSDATETIMEoffset()
-- sysdatetimeoffset() will return current data and time with your server's actual time zone offset


select convert(varchar , getdate(), 1) 
select convert(varchar , getdate(), 101)
select convert(varchar , getdate(), 3)
select convert(varchar , getdate(), 103)  -- British/ French
select convert(varchar , getdate(), 104)  -- German
select convert(varchar , getdate(), 109)  -- Default + milli sec
select convert(varchar , getdate(), 110)  -- USA
select convert(varchar , getdate(), 111)  -- Japan

-- More for reference:
--https://www.w3schools.com/sql/func_sqlserver_convert.asp
--https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver17

/*
You can also construct your time value using string
format conform to ANSI [American National Standards Institute]

smalldatetime and datetime
yyyy-mm-dd hh:mm[:ss[.fff]] it supports 3 decimal digital for fractional seconds

date, time, datetime2 and datetimeoffset
yyyy-mm-dd hh:mm[:ss[.fffffff]] {+/- hh:mm}  -- time offset
*/

declare @orderdate datetime2 ='2025-10-03 09:25:25.123456'
print @orderdate

-- Not going to work because smalldatetime supports 3 decimal places for fractional part
declare @orderdate1 smalldatetime ='2025-10-03 09:25:25.1234567'
print @orderdate1
-- This one will work fine
declare @orderdate2 smalldatetime ='2025-10-03 09:25:25.123'
print @orderdate1

-- Coverting date and time values can be bit tricky and challenging as well, so be
-- very careful to use correct values in your string literals