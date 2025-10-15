/**************************************************************************************************************************************************
          CMPE 2400 Lab 1 - CREATE
            || *** RUBRIC *** ||
 - 5    Conditional Drop Statements for all items
 - 5    Re-runnable script with no errors
 - 5    Database Creation and commented out
 - 4    USE statement
 - 33   The attached script will be run to test your work. There are 33 checks. You receive 1 mark for each check that matches the expected output.
 - 10   Verification of the data using the provided SQL statement (everything except the TripPlanId numbers should match exactly) – no part marks
 - 18`  Primary Keys and Foreign Keys (2 marks each)
****************************************************************************************************************************************************/

--Visual Inspection
--CONDITIONAL DROPS in correct order
--DROP/CREATE DB commented out
--USE STATEMENT

-- ==================================
-- Use master as another database 1st
-- ==================================

use master
go

-- =================================
-- Create / Drop DB (commented out)
-- =================================

-- drop database if exists dkinganjatou1_ets
-- go
-- create database dkinganjatou1_ets
-- go

use dkinganjatou1_ets
go

-- ================
-- Dropping tables
-- ================

-- TransitLines Table
drop table if exists TripLeg
drop table if exists TripPlans
drop table if exists Stations
drop table if exists TransitLines
go

-- ================
-- Creating tables
-- ================

-- TransitLines Table
create table TransitLines
(
    TransitLine     varchar(50) not null primary key,
    IntervalMins    int not null check(IntervalMins > 0)
)
go

-- Stations Table
create table Stations
(
    Station        varchar(50) not null primary key,
    StreetAddress  varchar(30) not null,
    City           varchar(30) not null default 'Edmonton',
    Province       char(2)     not null default 'AB',
    PostalCode     char(7)     null
        constraint CK_PostalCodePattern
            check (PostalCode is null or PostalCode like '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]')
)
go

-- TripPlans Table
create table TripPlans
(
    TripPlanId      int identity(1,1) not null primary key,
    PlanGenerated   datetime not null default getdate()
)
go

-- TripLeg Table
create table TripLeg
(
    TripPlanId      int not null
        constraint FK_TripPlanId references TripPlans(TripPlanId),
    TransitLine     varchar(50) not null
        constraint FK_TransitLine references TransitLines(TransitLine),
    StartStation    varchar(50) not null
        constraint FK_StartStation references Stations(Station),
    FinishStation   varchar(50) not null
        constraint FK_FinishStation references Stations(Station),
    StartDeparture  datetime not null,
    FinishArrival   datetime not null,
    Duration   as   datediff(mi,StartDeparture,FinishArrival),

    constraint PK_TripLeg primary key (TripPlanId, TransitLine)
)
go