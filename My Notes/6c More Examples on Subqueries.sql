-- Week 09 Day 03 31.10.2025
-- Subquery

-- Find all the products that belong to the same category as the most
-- expensive product
-- Hint: Which products share a category with the highest-priced product

use dkinganjatou1_Northwind
go

-- Find the maximum unit price
select max(UnitPrice)
from Products
-- Alternative way
select top 1 UnitPrice
from Products
order by UnitPrice desc

-- Need to find the category of the product
-- where unitprice is 263.50

select CategoryID
from Products
where UnitPrice = 263.50

-- Combine the two queries
select p.CategoryID
from Products p
where p.UnitPrice = (
                        select max(p1.UnitPrice)
                        from Products p1
                    )

-- Find all the products that belong to categoryID of 1
select *
from Products
where CategoryID = 1

-- Combining all the queries together
select *
from Products p2
where p2.CategoryID =   (
                            select p.CategoryID
                            from Products p
                            where p.UnitPrice = (
                                                    select max(p1.UnitPrice)
                                                    from Products p1
                                                )
                        )

use dkinganjatou1_Northwind
go
-- Find employees who handled orders of the single costlier product
-- HINT: Which employee(s) processed the orders that contained the product
-- with the highest unit price

select *
from products

select *
from [order Details] od

select *
from Employees e

-- Find the max unit price
select p.ProductID
from Products p
where p.UnitPrice = (
                        select max(p1.UnitPrice)
                        from Products p1
                    )

-- Find the orderID which have ProductID = 38
select od.OrderID
from [order Details] od
where od.ProductID =    (
                            select p.ProductID
                            from Products p
                            where p.UnitPrice = (
                                                    select max(p1.UnitPrice)
                                                    from Products p1
                                                )
                        )

-- Find the employeesID related to those orders
select o.EmployeeID
from [orders] o
where o.OrderID in  (
                        select od.OrderID
                        from [order Details] od
                        where od.ProductID =    (
                                                    select p.ProductID
                                                    from Products p
                                                    where p.UnitPrice = (
                                                                            select max(p1.UnitPrice)
                                                                            from Products p1
                                                                        )
                                                )
                    )

-- Select all the information for the concerned employees
select *
from Employees e
where e.EmployeeID in(
                      select o.EmployeeID
                      from [orders] o
                      where o.OrderID in  (
                                            select od.OrderID
                                            from [order Details] od
                                            where od.ProductID =    (
                                                                      select p.ProductID
                                                                      from Products p
                                                                      where p.UnitPrice = (
                                                                                            select max(p1.UnitPrice)
                                                                                            from Products p1
                                                                                          )
                                                                    )
                                          )
                      )