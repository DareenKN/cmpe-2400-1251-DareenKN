use Chinook
go

declare @min int = 6
declare @max int = 7

select left(cast(TrackId as varchar(10)) + ': ' + [Name] + '-' + Composer, 100) 'Track Information'
from Track
order by TrackId
where 