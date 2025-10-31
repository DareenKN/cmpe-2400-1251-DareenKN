-- Week 09 Day 03 31.10.2025
-- Joins

-- JOINS
-- INNER JOINS
-- OUTER JOIN[LEFT, RIGHT]
-- CROSS JOIN

/*
    A join in SQL is used to combine data from to or more tables 
    based on a RELATED column between them.
    PK, FK -- Usually it is PK and FK columns,
    but it could be other columns as well as provided these are of the same
    data type and same values
*/

use dkinganjatou1_Northwind
go

-- INNER join
-- ANSI Standard
select * from Products
select * from Categories

-- inner join
select *
from Products p
    inner join Categories c -- Keyword inner is optional
    on p.CategoryID = c.CategoryID -- Joining condition

-- Specific column
select  p.ProductID,
        p.ProductName,
        c.CategoryName
from Products p
    inner join Categories c -- Keyword inner is optional
    on p.CategoryID = c.CategoryID -- Joining condition

-- Let's combine 3 table
select *
from Products p
    inner join Categories c -- Keyword inner is optional -- second
        on p.CategoryID = c.CategoryID -- Joining condition
    inner join [Order Details] od
        on od.ProductID = p.ProductID
-- SQL SERVER