use master 
go

--drop database if exists practicdb_simran
--go
--create database practicdb_simran
--go

use dkinganjatou1_ERD
go

--===============================
-- Drop tables
drop table if exists Passengers
drop table if exists bookings
drop table if exists flights
drop table if exists Airports
drop table if exists Airlines
drop table if exists payments
go

create table Airlines
(
	AirlineCode char(3) 
		Constraint PK_Airlines_Airlinecode  
			Primary key		not null,
	[Name]	varchar(85)     not null
)
go

create table Airports
(
	AirportCode		int
		Constraint PK_Airports_AirportCode
			primary key  identity (1000, 1) not null,
	[Name]				varchar(85)	not null,
	City				varchar(35)	not null,
	Country				varchar(35)	not null,
	IATA				char(3)		null,
	ICAO				char(3)		null,
	Latitude			decimal		not null,
	Longitute			decimal		not null,
	Altitude			int			not null,
	Timezone			smallint	not null,
	TzDatabaseTimeZone	varchar(50) not null
)
go

create table Payments
(
	PaymentConfimationNumber	varchar(40)
		constraint PK_Payments_PaymentNumber 
			primary key			not null,
	Timespamp		datetime	not null
		constraint DF_Payments_Timestamp
		  	default getdate(),
	Amount			money		not null
		constraint CK_Payments_Amount
			check (Amount > 0),
	PaymentType		varchar(10)	not null
)
go
create table Flights
(
	FlightCode	varchar(18)
		constraint PK_Flights_FlightCode
			primary key				not null,
	Flightnumber	varchar(18)		not null,
	[Date]			date			not null,
	DepartureAirport int			
		constraint FK_Flights_Departure 
		foreign key references Airports(AirportCode),
	Departure		time			not null,
	ArrivalAirport	int			
		constraint FK_Flights_Arrival 
		foreign key references Airports(AirportCode),
	Arrival			time			not null,
	FlightDuration	time			not null,
	Cancelled		char(1)			null,
	isFull			char(1)			not null
	constraint DF_Flights_isfull
		  default 'N',
	Airlinecode		char(3)
		constraint FK_Flights_AirlineCode
		foreign key references Airlines(AirlineCode),
   constraint CK_Flights_Departure_Arrival_Airport
		check (DepartureAirport <> ArrivalAirport)
)
go
create table Bookings
(
	ConfirmationNumber	char(11)
		constraint PK_Bookings_ConfirmationNumber
		primary key			not null,
	FlightCode		varchar(18)
		constraint FK_Bookings_Flights
			foreign key references Flights(FlightCode) not null,
	PaymentConfirmationNumber	varchar(40)
		constraint FK_Bookings_Payments
			foreign key references Payments(PaymentConfimationNumber) null,
    
	FirstName			varchar(40)		not null,
	MiddleName			varchar(40)		null,
	LastName			varchar(40)		not null,
	PhoneNumber			char(14)		not null
	 constraint CK_Bookings_phonenumber
	   Check (phonenumber like
			'[0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
	   ),
	AlternatePhoneNumber char(14)		null
	  constraint CK_Bookings_alternatephonenumber
	   Check (AlternatePhoneNumber like
			'[0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
	   ),
	EmailAddress		varchar(50)		not null,
	StreetAddress		varchar(50)		not null,
	City				varchar(40)		not null,
	Region				varchar(25)		null,
	Country				varchar(35)		not null
)
go

create table Passengers
(
	ConfirmationNumber	char(11)	
		constraint FK_passengers_bookings
			foreign key references Bookings(ConfirmationNumber) not null,
    CustomerID		int				not null,
	FirstName		varchar(40)		not null,
	MiddleName		varchar(40)		null,
	LastName		varchar(40)		not null,
	DateOfBirth		Date			null,
	PhoneNumber		char(14)		null
		constraint CK_Passengers_phonenumber
			Check (PhoneNumber like
					'[0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
			),
	
	-- table level PK	
	constraint PK_Passengers_ConfirmationNumber_CustomerID
	primary key (ConfirmationNumber,CustomerID)
)
go

-- Alter table statement
alter table Passengers
	add AgeGroup varchar(8) not null
go

alter table Passengers
	add	constraint DF_Passengers_AgeGroup 
		default ('Adult') for AgeGroup,
		constraint CH_Passengers_AgeGroup check (AgeGroup in ('Adult', 'Child', 'Senior'))
go


alter table Flights
	add constraint DF_Flights_Cancelled
		default ('N') for Cancelled
go
