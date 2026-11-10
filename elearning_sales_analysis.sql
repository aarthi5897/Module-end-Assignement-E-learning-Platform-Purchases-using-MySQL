create database elearning_sales;
use elearning_sales;
show databases;
create table learners (
     learner_id INT primary key,
     full_name varchar(100),
     country varchar(60)
);

create table courses (
     course_id int primary key,
     course_name varchar(120),
     category varchar(60),
     unit_price decimal(10,2)
 );
 
 create table purchases (
      purchase_id int primary key,
      learner_id int,
      course_id int,
      quantity int,
      purchase_date date,
      
      foreign key (learner_id)
      references learners(learner_id),
      
      foreign key (course_id)
      references courses(course_id)
 );
 
 insert into learners values
 (1, 'Asha Kumar', 'India'),
 (2, 'Ben Carter', 'USA'),
 (3, 'Chen Wei', 'Singapore'),
 (4, 'Divya Raj', 'India'),
 (5, 'Elena Smith', 'UK');
 
 insert into courses values
 (101, 'SQL Basics', 'Data Analytics', 499.00),
 (102, 'Excel Mastery', 'Data Analytics', 399.00),
 (103, 'Python Programming', 'Programming', 799.00),
 (104, 'Digital Marketing', 'Marketing', 599.00),
 (105, 'UI/UX Design', 'Design', 699.00);
 
insert into purchases values
(1001, 1, 101, 2, '2026-01-05'),
(1002, 1, 102, 1, '2026-01-12'),
(1003, 2, 103, 1, '2026-02-03'),
(1004, 2, 104, 2, '2026-02-10'),
(1005, 3, 101, 1, '2026-02-18'),
(1006, 3, 103, 1, '2026-03-01'),
(1007, 4, 104, 1, '2026-03-08'),
(1008, 5, 102, 3, '2026-03-15');

show tables;

select * from learners;
select * from courses;
select * from purchases;

select 
   l.full_name as learner_name,
   c.course_name,
   c.category,
   p.quantity,
   format(p.quantity * c.unit_price, 2)
   as total_amount,
   p.purchase_date
   
from purchases p
inner join learners l
on p.learner_id = l.learner_id
inner join courses c
on p.course_id = c.course_id;

select 
    l.full_name as learner_name,
    c.course_name,
    p.quantity,
    p.purchase_date
   
from learners l

left join purchases p
on l.learner_id = p.learner_id
left join courses c
on p.course_id = c.course_id;

select 
    c.course_name,
    c.category,
    p.quantity,
    p.purchase_date
from purchases p 
right join courses c
on p.course_id = c.course_id;

SELECT
    l.full_name AS learner_name,
    l.country,
    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0),
        2
    ) AS total_spent

FROM learners l

LEFT JOIN purchases p
ON l.learner_id = p.learner_id

LEFT JOIN courses c
ON p.course_id = c.course_id

GROUP BY l.learner_id, l.full_name, l.country

ORDER BY SUM(p.quantity * c.unit_price) DESC;

SELECT
    c.course_name,
    SUM(p.quantity) AS total_quantity_sold

FROM courses c

INNER JOIN purchases p
ON c.course_id = p.course_id

GROUP BY c.course_id, c.course_name

ORDER BY total_quantity_sold DESC

LIMIT 3;SELECT
    c.course_name,
    SUM(p.quantity) AS total_quantity_sold

FROM courses c

INNER JOIN purchases p
ON c.course_id = p.course_id

GROUP BY c.course_id, c.course_name

ORDER BY total_quantity_sold DESC

LIMIT 3;

SELECT
    c.category,

    FORMAT(
        SUM(p.quantity * c.unit_price), 2
    ) AS total_revenue,

    COUNT(DISTINCT p.learner_id)
    AS unique_learners

FROM courses c

LEFT JOIN purchases p
ON c.course_id = p.course_id

GROUP BY c.category

ORDER BY SUM(p.quantity * c.unit_price) DESC;

SELECT
    l.full_name AS learner_name,

    COUNT(DISTINCT c.category)
    AS categories_purchased

FROM learners l

INNER JOIN purchases p
ON l.learner_id = p.learner_id

INNER JOIN courses c
ON p.course_id = c.course_id

GROUP BY l.learner_id, l.full_name

HAVING COUNT(DISTINCT c.category) > 1;

SELECT
    c.course_id,
    c.course_name,
    c.category

FROM courses c

LEFT JOIN purchases p
ON c.course_id = p.course_id

WHERE p.purchase_id IS NULL;


       
    


 