-- Question 1
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Select the airport name & IATA code formatted as Name (IATA), city, country, and TimeZone of the airport. Show the city and country as one column titled "Serving City" with a comma between the city and the country. Only display results where the airport does not have “International” in its name and the IATA does not start with Y. Order the results by Country then City, both in alphabetical order. *Format the first two columns to the following widths: 60 for the first column and 30 for the second column*

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
        count(p.CustomerId) 'Number of Passengers'
from Bookings b
        join Passengers p
          on b.ConfirmationNumber = p.ConfirmationNumber
group by  b.FlightCode,
          b.ConfirmationNumber
having count(p.CustomerId) > 5


-- Question 3
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the average payment amount of all passengers whose departing Airport code [IATA] starts with Y. Format the result with a display length of 10 characters, and include an appropriately formatted column header.
*/

select  LEFT(FORMAT(AVG(p.Amount), 'C'), 10) "Average Payment Amount"
FROM payments p
where exists (
              select b.FlightCode
              from bookings b
                join flights f
                    on f.FlightCode = b.FlightCode
                join airports a
                    on a.AirportCode = f.DepartureAirport
              where b.PaymentConfirmationNumber = p.PaymentConfirmationNumber
              and a.IATA like 'Y%'
              )

              
-- Question 4

/*
This question assumes use of Lab2_FlightsOfFancy database.

Select all flight codes, and total of all payments by flight, having total payment amounts less than   4,803 dollars. Any flights with no payments must be listed as having payments of $0. Order the results by Total Payment (largest at the top) then by FlightCode (ascending order).

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

List all flight dates, and the number of flights on that date leaving YEG that do not have any passengers booked. Join syntax must be used – no subqueries. Order the results by ascending date.
*/
select  f.Date,
        count(distinct f.flightcode) "Number of Flights with No Passengers"
from flights f
  left join bookings b
    on f.flightcode = b.flightcode
  left join passengers p
    on b.ConfirmationNumber = p.ConfirmationNumber
  left join Airports a
    on f.departureAirport = a.AirportCode
where a.IATA = 'YEG'
  and p.CustomerId is null
group by f.Date
order by f.Date asc


-- Question 6

/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the amount of money that was made each day in the month of August 2022 (based on the timestamp in the Payments table). Show the day's number and weekday name, the total earning on that day, and the number of payments. List the days in chronological order.
*/

select
    datename(dw, timestamp) as weekday,
    day(timestamp) as "day of month",
    left(format(sum(amount), 'c'), 20) as earnings,
    count(*) as "number of payments"
from payments
where year(timestamp) = 2022
  and month(timestamp) = 8
group by
    datename(dw, timestamp),
    day(timestamp)
order by
    day(timestamp) asc;


 select DATENAME(dw, Timestamp) 'Weekday', DAY(Timestamp) 'Day of Month', left(format(SUM(Amount),'C'),20) 'Earnings', COUNT(*) 'Number of Payments' from payments where MONTH(Timestamp) = 8 and year(Timestamp) = 2022 group by Timestamp order by 2      


-- Question 7

/*
This question assumes use of Lab2_FlightsOfFancy database.

Rearrange the SQL Statement to find the name(s) of the airlines without any scheduled flights. (Use a subquery for your answer.)
*/
     
select a.name
from airlines a
where a.airlinecode not in (
    select f.airlinecode
    from flights f
);


 select a.Name from Airlines a where a.AirlineCode NOT IN ( select f.AirlineCode from Flights f )      

 -- Question 8
 /*
 This question assumes use of Lab2_FlightsOfFancy database. 

Select the name(s) of airline(s) with the most number of scheduled flights in December 2022. Use the first letter of each table as an alias.
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

Select the time and flight number for all flights going into and out of the 'Lester B. Pearson International Airport' on December 22, 2022. Ensure the time displayed is appropriate (the arrival time for flights entering Lester B. Pearson and departure time for flights leaving Lester B. Pearson). Include a column stating "Arriving" if it's an arrival or "Departing" if it's a departure. Sort the results by time in ascending order.

Choose the best set operator to use for this situation. Penalty applies if an inefficient choice is made. 

Format the Time column with a width of 10. Match the header names shown in the sample.

Paste your SQL statement below - this question will be graded manually by your instructor.
*/

select 
    format(f.arrivaltime, 'hh:mm:ss') as time,
    f.flightnumber,
    'arriving' as "arriving or departing"
from flights f
where f.arrivalairport = 'lester b. pearson international airport'
  and f.flightdate = '2022-12-22'

union all

select 
    format(f.departuretime, 'hh:mm:ss') as time,
    f.flightnumber,
    'departing' as "arriving or departing"
from flights f
where f.departureairport = 'lester b. pearson international airport'
  and f.flightdate = '2022-12-22'

order by time asc;

-- Question 10
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Rearrange the SQL Statement to select the sum and average payment amount for each payment type. Include payment type, sum, average amount in the select list which should be sorted in descending order according payment type. Make sure all columns have valid names. Any dollar amounts shall be formatted as currency to a length of 30.
*/

select
    paymenttype,
    convert(varchar(30), format(sum(amount), 'c'), 1) as "sum",
    convert(varchar(30), format(avg(amount), 'c'), 1) as "average"
from payments
group by paymenttype
order by paymenttype desc;


-- Question 11
/*
This question assumes use of Lab2_FlightsOfFancy database. 

Return the ConfirmationNumber, Flight Code [First 12 characters only], Amount Paid, and number of passengers for bookings with 3 or more passengers. No subqueries may be used in your solution. Order your results by ConfirmationNumber [ascending order] then by Flight Code [Make sure to use Alias for sorting] in descending. Only include records whose payment amount is between 830 and 3,720. 

Paste your SQL statement below - this question will be graded manually by your instructor.
*/
select
    b.confirmationnumber,
    left(f.flightcode, 12) as "flight code",
    p.amount as "amount paid",
    count(pas.customerid) as "number of passengers"
from bookings b
join flights f
    on b.flightcode = f.flightcode
join payments p
    on b.paymentconfirmationnumber = p.paymentconfirmationnumber
join passengers pas
    on b.confirmationnumber = pas.confirmationnumber
group by 
    b.confirmationnumber,
    f.flightcode,
    p.amount
having count(pas.customerid) >= 3
   and p.amount between 830 and 3720
order by 
    b.confirmationnumber asc,
    "flight code" desc;



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

CustomerId
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

declare @fromcity varchar(50) = 'denver';
declare @tocity varchar(50) = 'vancouver';
declare @flightnumber varchar(50) = 'aca1023';
declare @departuredate date = '2022-12-24';
declare @travelagentcode int = 89597;

select
    pas.customerid,
    left(pas.firstname, 11) as firstname,
    left(pas.lastname, 13) as lastname,
    f.flightcode as "cancelled flight code",
    nf.flightcode as "next flight code",
    nf.departuretime as departure,
    nf.departureairport as departureairport,
    nf.arrivalairport as arrivalairport,
    @travelagentcode as "travel agent"
from passengers pas
join bookings b
    on pas.confirmationnumber = b.confirmationnumber
join flights f
    on b.flightcode = f.flightcode
join flights nf
    on nf.airlinecode = f.airlinecode
    and nf.departureairport = f.departureairport
    and nf.arrivalairport = f.arrivalairport
    and nf.departuredate > f.departuredate
where f.flightcode = @flightnumber
  and f.departureairport in (
        select airportcode from airports where city = @fromcity
    )
  and f.arrivalairport in (
        select airportcode from airports where city = @tocity
    )
order by pas.customerid;



-- Question 13
/*
This question assumes use of Lab2_FlightsOfFancy database. 

List all columns for flights that only have passengers that did not book their own tickets. Results are sorted by FlightCode.
*/

select f.*
from flights f
join bookings b
    on f.flightcode = b.flightcode
group by 
    f.flightcode,
    f.flightnumber,
    f.date,
    f.departureairport,
    f.departuretime,
    f.arrivalairport,
    f.arrivaltime,
    f.flightduration,
    f.cancelled,
    f.isfull,
    f.airlinecode
having count(case when b.customerid = b.bookedby then 1 end) = 0
order by f.flightcode;
