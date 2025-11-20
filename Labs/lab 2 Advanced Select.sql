-- Question 1
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Select the airport name & IATA code formatted as Name (IATA), City, country, and TimeZone of the airport. Show the City and country as one column titled "Serving City" with a comma between the City and the country. Only display results where the airport does not have “International” in its name and the IATA does not start with Y. Order the results by Country then City, both in alphabetical order. *Format the first two columns to the following widths: 60 for the first column and 30 for the second column*

If you choose to use a table alias, you must use a
*/

use Lab2_FlightsOfFancy
go

select  left([Name] + ' (' + IATA + ')', 60) 'Airport',
        left(City + ', '+ Country, 30) 'Serving City',
        TimeZone
from Airports
where   [Name] not like '%International%'
        and IATA not like 'Y%'
order by Country, City

-- Question 2
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Select the flight code, confirmation number and number of passengers where there are at least 5 passengers on a booking.

Use the first letter of each needed table as the table alias, and use that alias whenever a column is specified.
*/
select  b.FlightCode,
        b.ConfirmationNumber,
        count(p.CustomerID) 'Number of Passengers'
from Bookings b
        join Passengers p
          on b.ConfirmationNumber = p.ConfirmationNumber
group by  b.FlightCode,
          b.ConfirmationNumber
having count(p.CustomerID) > 5


-- Question 3
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the average payment amount of all passengers whose departing Airport code [IATA] starts with Y. Format the result with a display length of 10 characters, and include an appropriately formatted column header.
*/

select  LEFT(FORMAT(AVG(p.Amount), 'C'), 10) "Average Payment Amount"
FROM payments p
where exists (
              select b.FlightCode
              from Bookings b
                join Flights f
                    on f.FlightCode = b.FlightCode
                join Airports a
                    on a.AirportCode = f.DepartureAirport
              where b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
              and a.IATA like 'Y%'
              )

              
-- Question 4

/*
This question assumes use of Lab2_FlightsOfFancy database.

Select all flight codes, and total of all payments by flight, having total payment amounts less than   4,803 dollars. Any Flights with no payments must be listed as having payments of $0. Order the results by Total Payment (largest at the top) then by FlightCode (ascending order).

Use the first letter of each table as the alias.
*/

select  f.FlightCode,
        isnull(sum(p.amount), 0) "Total Payments"
from Flights f
  left join Bookings b
      on f.FlightCode = b.FlightCode
  left join Payments p
      on b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
group by f.FlightCode
having isnull(sum(p.amount), 0) < 4803
order by 2 desc, 1 asc

-- Question 5

/*
This question assumes use of Lab2_FlightsOfFancy database. 

List all flight Dates, and the number of Flights on that Date leaving YEG that do not have any passengers booked. Join syntax must be used – no subqueries. Order the results by ascending Date.
*/
select  f.Date,
        count(distinct f.FlightCode) "Number of Flights with No Passengers"
from Flights f
  left join Bookings b
    on f.FlightCode = b.FlightCode
  left join passengers p
    on b.ConfirmationNumber = p.ConfirmationNumber
  left join Airports a
    on f.DepartureAirport = a.AirportCode
where a.IATA = 'YEG'
  and p.CustomerID is null
group by f.Date
order by f.Date asc


-- Question 6

/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the amount of money that was made each day in the month of August 2022 (based on the timestamp in the Payments table). Show the day's number and weekday name, the total earning on that day, and the number of payments. List the days in chronological order.
*/

select
    Datename(dw, timestamp) as weekday,
    day(timestamp) as "day of month",
    left(format(sum(amount), 'c'), 20) as earnings,
    count(*) as "number of payments"
from payments
where year(timestamp) = 2022
  and month(timestamp) = 8
group by
    Datename(dw, timestamp),
    day(timestamp)
order by
    day(timestamp) asc;


 select DateNAME(dw, Timestamp) 'Weekday', DAY(Timestamp) 'Day of Month', left(format(SUM(Amount),'C'),20) 'Earnings', COUNT(*) 'Number of Payments' from payments where MONTH(Timestamp) = 8 and year(Timestamp) = 2022 group by Timestamp order by 2      


-- Question 7

/*
This question assumes use of Lab2_FlightsOfFancy database.

Rearrange the SQL Statement to find the name(s) of the airlines without any scheduled Flights. (Use a subquery for your answer.)
*/
     
select a.name
from airlines a
where a.airlinecode not in (
    select f.airlinecode
    from Flights f
);


 select a.Name from Airlines a where a.AirlineCode NOT IN ( select f.AirlineCode from Flights f )      

 -- Question 8
 /*
 This question assumes use of Lab2_FlightsOfFancy database. 

Select the name(s) of airline(s) with the most number of scheduled Flights in December 2022. Use the first letter of each table as an alias.
 */

 select top 1
    a.Name,
    count(f.FlightCode) as "NumFlights"
from Airlines a
join Flights f
    on a.AirlineCode = f.AirlineCode
where f.Date between '2022-12-01' and '2022-12-31'
group by a.Name
order by count(f.FlightCode) desc;

-- Question 9
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Select the time and flight number for all Flights going into and out of the 'Lester B. Pearson International Airport' on December 22, 2022. Ensure the time displayed is appropriate (the arrival time for Flights entering Lester B. Pearson and departure time for Flights leaving Lester B. Pearson). Include a column stating "Arriving" if it's an arrival or "Departing" if it's a departure. Sort the results by time in ascending order.

Choose the best set operator to use for this situation. Penalty applies if an inefficient choice is made. 

Format the Time column with a width of 10. Match the header names shown in the sample.

Paste your SQL statement below - this question will be graded manually by your instructor.
*/

select 
    left(format(f.Arrival, 'hh:mm:ss'), 10) "Time",
    f.FlightNumber,
    'Arriving' "Arriving or Departing"
from Flights f
where f.ArrivalAirport in (
                            select a.AirportCode from Airports a
                            where a.Name = 'Lester B. Pearson International Airport'
                          )
  and f.Date = '2022-12-22'

union all

select 
    left(format(f.Arrival, 'HH:mm:ss'), 10) "Time",
    f.FlightNumber,
    'Departing' "Arriving or Departing"
from Flights f
where f.DepartureAirport in (
                              select a.AirportCode from Airports a
                              where a.Name = 'Lester B. Pearson International Airport'
                            )
  and f.Date = '2022-12-22'

order by [Time] asc

select * from Flights
select * from Airports a
where a.Name = 'Lester B. Pearson International Airport'

-- Question 10
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the sum and average payment amount for each payment type. Include payment type, sum, average amount in the select list which should be sorted in descending order according payment type. Make sure all columns have valid names. Any dollar amounts shall be formatted as currency to a length of 30.
*/

select 
    PaymentType , 
    convert(varchar(30), Format(Sum(Amount),'C'),1) 'Sum', 
    convert(varchar(30), Format(AVG(Amount),'C'),1) 'Average' 
from Payments 
group by PaymentType 
order by 1 desc 


-- Question 11
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Return the ConfirmationNumber, Flight Code [First 12 characters only], Amount Paid, and number of passengers for Bookings with 3 or more passengers. No subqueries may be used in your solution. Order your results by ConfirmationNumber [ascending order] then by Flight Code [Make sure to use Alias for sorting] in descending. Only include records whose payment amount is between 830 and 3,720. 

Paste your SQL statement below - this question will be graded manually by your instructor.
*/
select
    b.ConfirmationNumber,
    left(f.FlightCode, 12) "Flight Code",
    p.Amount "Amount Paid",
    count(pas.CustomerID) "Number of Passengers"
from Bookings b
join Flights f
    on b.FlightCode = f.FlightCode
join Payments p
    on b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
join Passengers pas
    on b.ConfirmationNumber = pas.ConfirmationNumber
group by 
    b.ConfirmationNumber,
    f.FlightCode,
    p.Amount
having count(pas.CustomerID) >= 3
   and p.Amount between 830 and 3720
order by 
    b.ConfirmationNumber asc,
    "Flight Code" desc



-- Question 12
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Unfortunately, flight number ACA1023 from Denver to Vancouver on 24 Dec 2022 is now cancelled due to a storm. Write a query that will return a list of all its passengers as if they have been rebooked on the next Air Canada flight to Vancouver.

Declare variables for the following data. These are the only hardcoded values that are permitted in your solution:

FromCity = Denver
ToCity = Vancouver
FlightNumber = ACA1023
DepartureDate = 2022-12-24

TravelAgentCode = 89597

Only return these columns:

CustomerID
FirstName (formatted to include a maximum of 11 characters)
LastName (formatted to include a maximum of 13 characters)
FlightCode of cancelled flight
FlightCode of replacement (next) flight
Departure time of next flight
Departure Airport 
Arrival Airport
Travel Agent 

Paste your SQL statement below - this question will be graded manually by your instructor.
*/

declare @FromCity varchar(50) = 'Denver';
declare @ToCity varchar(50) = 'Vancouver';
declare @FlightNumber varchar(50) = 'ACA1023';
declare @DepartureDate Date = '2022-12-24';
declare @TravelAgentCode int = 89597;

select
    distinct c.CustomerId,
    left(c.FirstName, 11) "FirstName",
    left(c.LastName, 13) "LastName",
    f.FlightCode "Cancelled Flight Code",
    nf.FlightCode "Next Flight Code",
    nf.Departure,
    nf.DepartureAirport,
    nf.ArrivalAirport,
    @TravelAgentCode "Travel Agent"
from Customers c
    join Passengers pas
        on pas.CustomerID = c.CustomerID
    join Bookings b
        on pas.ConfirmationNumber = b.ConfirmationNumber
    join Flights f
        on b.FlightCode = f.FlightCode
    join Flights nf
        on nf.AirlineCode = f.AirlineCode
        and nf.DepartureAirport = f.DepartureAirport
        and nf.ArrivalAirport = f.ArrivalAirport
        and nf.Departure = (
                              select min(f2.Departure)
                              from Flights f2
                              where f2.AirlineCode = f.AirlineCode
                              and f2.DepartureAirport = f.DepartureAirport
                              and f2.ArrivalAirport = f.ArrivalAirport
                              and f2.Departure > f.Departure
                            )
where f.FlightNumber = @FlightNumber
  and f.DepartureAirport in (
                              select AirportCode 
                              from Airports 
                              where City = @FromCity
                            )
  and f.ArrivalAirport in (
                            select AirportCode 
                            from Airports 
                            where City = @ToCity
                          )
order by c.CustomerId


select * from Flights
select * from Airports

-- Question 13
/*
This question assumes use of Lab2_FlightsOfFancy database. 

List all columns for Flights that only have passengers that did not book their own tickets. Results are sorted by FlightCode.
*/


select f.*
from Flights f
where exists  (
                -- Flight has at least one passenger
                select 1
                from Bookings b
                join Passengers p
                    on p.ConfirmationNumber = b.ConfirmationNumber
                where b.FlightCode = f.FlightCode
              )
and not exists(
                -- There is NO passenger whose CustomerId is the same
                -- as the BookingCustomerId (i.e. no self-bookers)
                select 1
                from Bookings b
                join Passengers p
                    on p.ConfirmationNumber = b.ConfirmationNumber
                  and p.CustomerId = b.BookingCustomerId
                where b.FlightCode = f.FlightCode
              )
order by f.FlightCode
