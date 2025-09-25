-- Week 3 Day 3 19.09.2025
-- DDL PART + Data Types
-- Data Definition language
-- Metadata - data about data
-- describe the organization and structure of database
-- More function


-- Create database
-- Create statement
-- Syntax : create database NAME_OF_DATABASE
-- drop statement: delete database

-- Always switch to another database to drop current database
use master
go

-- drop statement should be conditional
-- to avoid error 
--drop database if exists harsimran_test_1251_demo01_A02
--go

-- create new database: like creating a shelf in library 
--create database harsimran_test_1251_demo01_A02
--go

-- Now we have shelf, I need books/ tables

-- use your new database, need to select shelf
use dkinganjatou1_test_1251_demo01_A02
go

-- Create new table
/*
create table table_name
(
	column1  datatype,
	column2  datatype,
	..
	.
	columnN datatype -- no comma after last column
)
*/
-- drop your table before creating it

drop table if exists Customer
go

create table customer
(                 --       seed, increament
	customerid int identity(1000, 1) primary key, -- not null, unique
					-- length
	firstname	varchar(30),  
	lastname	varchar(30),
	phone		char(12),  -- 780-xxx-xxxx
	[address]   varchar(50),
	postalcode  char(6)
)
go

/*
Data Types in SQL
strings
varchar - variable length string 
char    - fixed length string
*/

select *
from customer

-- TESTING part for data
-- insert data just for fun

insert into customer 
	( firstname, lastname, phone, address, postalcode)
values( 'Simran', 'Aulaka', '780-000-0000', '0000 0 st NW Edmonton', 'T6T0A0')

insert into customer 
	( firstname, lastname, phone, address, postalcode)
values( 'Harsimran', 'Aulaka', '780-000-0000', '0000 0 st NW Edmonton', 'T6T0A0')


select top 1 customerid
from customer
order by customerid desc

select *
from customer