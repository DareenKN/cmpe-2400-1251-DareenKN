-- Question 1
/*
This question assumes use of ClassTrak database.

Rearrange the SQL Statement to retrieve a complete list of any instructors and/or students who are part of classes where the Class_Id is 60, 94 or NULL.
*/

use dkinganjatou1_ClassTrak
go

select cast(i.first_name + ' ' + i.last_name as varchar(30)) 'Instructor',
    cast(s.first_name + ' ' + s.last_name as varchar(30)) 'Student',
    c.class_id
from Instructors i
    full join classes c
    on c.instructor_id = i.instructor_id
    full join class_to_student cs
    on cs.class_id = c.class_id
    full join students s
    on s.student_id = cs.student_id
where c.class_id in (94, 60)
    or c.class_id is null

-- Questions 2
/*
This question assumes use of PublishersDatabase database.

Re

arrange the SQL Statement to retrieve all Stores who have no discounts.
*/

use Publishers
go

select s.stor_name 'Store Name'
from discounts d right outer join stores s on d.stor_id = s.stor_id
where d.stor_id is null

-- Question 3
/*
This question assumes use of NorthwindTraders database.

Rearrange the SQL Statement to return Supplier information and all the Supplier's products for any Supplier who currently has any product with ZERO quantity in stock.

Display the Supplier's CompanyName and City, each Product's ProductID and ProductName, and the ProductID of the Supplier's product that has no quantity. No subqueries are used - only joins.

Order your results by ProductID within CompanyName

[Hint: Self-join required]
*/

use NorthwindTraders
go

select  s.CompanyName, 
        s.City, 
        p2d.ProductID, 
        p2d.ProductName, 
        p2f.ProductID 'Product with No Qty' 
from Suppliers s
    join products p2d 
        on s.SupplierID = p2d.SupplierID 
    join products p2f 
        on s.SupplierID = p2f.SupplierID 
where p2f.UnitsInStock = 0 
order by s.CompanyName, p2d.ProductID 

-- Question4
/*
This question assumes use of ClassTrak database.

Provide the select statement that will return the Assignment Type Description and Assignment Description (formatted as shown), the calculated average (score/max score), and number of marked assignments. Only include results for class id 88, and for those assignment types with a calculated average greater than 57. Sort the results by the first column.
*/
use dkinganjatou1_ClassTrak
go

select  r.ass_desc + '(' + at.ass_type_desc + ')'  'Desc(Type)',
    round(avg(re.score / r.max_score * 100), 2) 'Avg',
    count(re.student_id) 'Num Marked'
from Assignment_type at
    right outer join Requirements  r 
        on r.ass_type_id = at.ass_type_id
    left outer join Results re
        on re.req_id = r.req_id
group by at.ass_type_desc, r.ass_desc, r.class_id
having  r.class_id = 88 and round(avg(re.score / r.max_score * 100), 2) > 57 
order by 1

select distinct class_id
FROM Requirements
WHERE class_id = 88

select distinct class_id
FROM Results

-- Question 5
/*
This question assumes use of NorthwindTraders database. 

Return a list of all Suppliers. Include the number of types of products each supplier sells and the Units in Stock each supplier has on hand across all their products. Also provide the Average Unit Price of their products - any product without a Unit Price must be counted as 0. Ensure that this information is displayed correctly even for Suppliers with no products. Limit your results to Suppliers whose average unit price (including nulls as 0's) is less than $20.00. Your results should match the sample below, including the displayed 0's. Remember that Coalesce can be used to change a NULL to a 0. Format the Average Unit Price as currency to a maximum of 20 characters.
*/
use NorthwindTraders
go 

select s.CompanyName 'Supplier',
    count(distinct p.ProductName) 'Number of Product Types',
    coalesce(sum(p.UnitsInStock), 0) 'Total Units',
    left(format(coalesce(avg(coalesce(p.UnitPrice, 0)), 0), 'C', 'en-US'), 20) 'Average Unit Price'
from Suppliers s
    left join Products p
        on s.SupplierID = p.SupplierID
group by s.CompanyName
having coalesce(avg(coalesce(p.UnitPrice, 0)), 0) < 20
order by s.CompanyName
