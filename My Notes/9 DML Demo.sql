use Master
go 

-- create database DMLDemo
-- go

use DMLDemo
go

drop table if exists Students
go

create table Students(
    slname varchar(15),
    sfname varchar (15),
    phone varchar(15),
    email varchar(30)
)

-- Multiple rows same time
insert into Students
    (slname,sfname,phone,email)
values
    ('Dareen', 'Kinga Njatou', '825-865-6022', 'kidareen@gmail.com')
