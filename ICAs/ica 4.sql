use Chinook
go

declare @min int = 6
declare @max int = 7

select left(cast(TrackId as varchar(10)) + ': ' + [Name] + ' - ' + isnull(Composer, 'N/A'), 100) 'Track Information'
from Track
where milliseconds between @min * 60000 and @max * 60000
and UnitPrice < 0.69
order by TrackId

select cast(GenreID as varchar(10)) + ': ' + Name as 'Genres'
from Genre

select convert(varchar(12),'I... wanna write SQL Statements all night')

select left('I... wanna write SQL Statements all night',12)
	
select ltrim('I... wanna write SQL Statements all night')

select concat('Hello',' from', ' the', ' other', ' side')

select 'Hello' + ' from' + ' the' + ' other' + ' side'

select rtrim(concat('Hello',' from', ' the', ' other', ' side'))

select convert(varchar(10), getdate()) 'ANSI Date'

select 5*2 as Ten