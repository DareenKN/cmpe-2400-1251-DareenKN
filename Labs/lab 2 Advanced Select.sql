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
