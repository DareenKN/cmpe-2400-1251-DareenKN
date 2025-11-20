use Lab2_FlightsOfFancy
go

--Q1



select cast([Name] + ' (' + IATA + ')' as varchar(60)) 'Airport',
	   cast(City + ', ' + Country as varchar(30)) 'Serving City',
	   TimeZone
from Airports
where [Name] not like '%International%'
	  and IATA not like 'Y%'
order by Country, City

--Q2 
select * 
from Bookings


select b.FlightCode,
	   b.ConfirmationNumber,
	   count(p.CustomerId) 'Number of Passengers'
from Bookings b
			   join Passengers p 
			   on b.ConfirmationNumber = p.ConfirmationNumber
group by b.FlightCode, b.ConfirmationNumber
having count(p.CustomerId) > 5

--Q3

select left(format(avg(p.Amount),'C'),10) 'Average Payment Amount'
from Payments p
where exists 
			(
				select *
				from bookings b
								join flights f
								on f.FlightCode = b.FlightCode 
								join airports a
								on a.AirportCode =  f.DepartureAirport 
				where a.IATA like 'Y%' and 
				b.PaymentConfirmationNumber = p.PaymentConfirmationNumber

		    )


--Q4

select *
from Payments

select f.FlightCode,
	   isnull(sum(p.Amount), 0) 'Total Payments'
from Flights f
				left join Bookings b
				on f.FlightCode = b.FlightCode
				left join Payments p
				on b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
group by f.FlightCode
having isnull(sum(p.Amount), 0) < 4404
order by [Total Payments] desc, f.FlightCode

 --Q5
 select *
 from Flights

  select *
 from Bookings

 select *
 from Airports

select f.[Date],
		count(distinct f.FlightCode) 'Number of Flights with No Passengers'
from Flights f
				join  Airports a 
				on f.DepartureAirport = a.AirportCode
				left join Bookings b
				on f.FlightCode = b.FlightCode
				left join Passengers p
				on b.ConfirmationNumber = p.ConfirmationNumber
where a.IATA = 'YEG'
	  and p.CustomerId is null
group by f.[Date]
order by f.[Date] 


--Q6

select  DATENAME(dw, Timestamp) 'Weekday',
        DAY(Timestamp) 'Day of Month',
		left(format(SUM(Amount),'C'),20)  'Earnings',
		COUNT(*) 'Number of Payments'
from payments 
where MONTH(Timestamp) = 8
      and year(Timestamp) = 2022      
group by Timestamp
order by 2 

--Q7

select a.Name
from Airlines a
where a.AirlineCode NOT IN  (
								select f.AirlineCode 
								from Flights f
							 )        

--Q8

select top 1 with ties a.[Name],
	   count(*) 'NumFlights'
from Airlines a
				join Flights f
				on a.AirlineCode = f.AirlineCode
where f.Date BETWEEN '2022-12-01' AND '2022-12-31'
group by a.[Name]
order by [NumFlights] desc
 
   
--Q9
use Lab2_FlightsOfFancy
go

select convert(varchar(10), f.Arrival, 108)  'Time',
          f.FlightNumber 'FlightNumber',
          'Arriving'  [Arriving or Departing]
from Flights f
                join Airports a
                on f.ArrivalAirport = a.AirportCode
where a.[Name] = 'Lester B. Pearson International Airport'
and f.[Date] = '2022-12-22'


union all



select    convert(varchar(10), f.Departure, 108)  'Time',
             f.FlightNumber 'FlightNumber',
            'Departing'  [Arriving or Departing]
from Flights f
                join Airports a
                on f.DepartureAirport = a.AirportCode       
where a.[Name] = 'Lester B. Pearson International Airport'
and f.[Date] = '2022-12-22'

order by [Time] 

 


--Q10

select PaymentType,
	  CONVERT(VARCHAR(30), Format(SUM(Amount), 'C'), 1)  'Sum',
	  CONVERT(VARCHAR(30), Format(AVG(Amount), 'C'), 1)  'Average'
from Payments
group by PaymentType
order by 1 desc

--Q11

use Lab2_FlightsOfFancy
go

select b.ConfirmationNumber,
       left(b.FlightCode, 12) 'Flight Code',
       p.Amount 'Amount Paid',
       count(pas.CustomerId) 'Number of Passengers'
from Bookings b
                join Payments p
                on b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
                join Passengers pas
                on b.ConfirmationNumber = pas.ConfirmationNumber
group by b.ConfirmationNumber, b.FlightCode, p.Amount
having count (pas.CustomerId) >= 3 
       and p.Amount between 800 and 3600
order by b.ConfirmationNumber, FlightCode desc

--Q12

use Lab2_FlightsOfFancy
go



declare @FromCity varchar(30) = 'Denver'
declare @ToCity varchar(30) = 'Vancouver'
declare @FlightNumber nvarchar(20) = 'ACA1023'
declare @DepartureDate date = '2022-12-24'
declare @TravelAgentCode int = 89460

select distinct c.CustomerID 'CustomerId',
       left(c.FirstName, 16) 'FirstName',
       left(c.LastName, 20) 'LastName',
       b.FlightCode 'Cancelled Flight Code',
       f.FlightCode 'Next Flight Code',
       f.Departure,
       f.DepartureAirport,
       f.ArrivalAirport,
       @TravelAgentCode 'Travel Agent'
    
from Bookings b
                join Flights f
                    on f.FlightCode = b.FlightCode
                 join Passengers ps
                    on b.ConfirmationNumber = ps.ConfirmationNumber
                join Customers c
                    on ps.CustomerID = c.CustomerID
                join Airports a
                    on  a.AirportCode = f.DepartureAirport
                join Airports a1
                    on a1.AirportCode = f.ArrivalAirport
            
where a.City = @FromCity
and a1.City  = @ToCity
order by c.CustomerId


--Q13

select f.FlightCode, f.FlightNumber, f.[Date], f.DepartureAirport, f.ArrivalAirport,
         f.Departure, f.Arrival, f.FlightDuration, f.Cancelled, f.IsFull, f.AirlineCode
from Flights f
where exists(
					select *
					from Bookings b
					join Passengers p
					on b.ConfirmationNumber = p.ConfirmationNumber
					where b.FlightCode = f.FlightCode 

				)
and not exists  (
					select *
					from Bookings b
					join Passengers p
					on b.ConfirmationNumber = p.ConfirmationNumber
					where b.FlightCode = f.FlightCode 
					and b.BookingCustomerId = p.CustomerId
				)
order by f.FlightCode

----------ALTERNATIVE----------------
SELECT 
    f.FlightCode,
    f.FlightNumber,
    f.[Date],
    f.DepartureAirport,
    f.ArrivalAirport,
    f.Departure,
    f.Arrival,
    f.FlightDuration,
    f.Cancelled,
    f.IsFull,
    f.AirlineCode
FROM Flights f
JOIN Bookings b
    ON f.FlightCode = b.FlightCode
JOIN Passengers p
    ON b.ConfirmationNumber = p.ConfirmationNumber
LEFT JOIN Bookings b2
    ON b2.FlightCode = f.FlightCode
LEFT JOIN Passengers p2
    ON p2.ConfirmationNumber = b2.ConfirmationNumber
   AND b2.BookingCustomerID = p2.CustomerID   -- self-booked passengers
GROUP BY 
    f.FlightCode,
    f.FlightNumber,
    f.[Date],
    f.DepartureAirport,
    f.ArrivalAirport,
    f.Departure,
    f.Arrival,
    f.FlightDuration,
    f.Cancelled,
    f.IsFull,
    f.AirlineCode
HAVING 
    COUNT(p.CustomerID) > 0        -- must have passengers
    AND COUNT(p2.CustomerID) = 0   -- NONE booked their own ticket
ORDER BY f.FlightCode;




