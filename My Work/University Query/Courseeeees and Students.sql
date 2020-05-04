## Lab - Module5, Relational Algebra
## Rehman Zafar

# 1. CREATE and USE Database Statements
create database lab5 ;
use lab5 ;

# 2. CREATE TABLE and ALTER TABLE commands
CREATE TABLE STUDENT (snumber integer, sname varchar (20) , class integer , major varchar (20));
DESCRIBE STUDENT ;
INSERT INTO STUDENT VALUES (17 , 'Smith ' , 1, 'CSS'),
(18 , 'Brown ' , 2, 'MIE'),
(19 , 'Alex ' , 2, 'MIE');

CREATE TABLE Course (course_name varchar (20), course_number varchar(20), credit_hours integer, department char (50) );
DESCRIBE Course;
INSERT INTO Course (course_name, course_number, credit_hours, department) values ('Data Structures' , 'CCPS305' , 4, 'CSS'),
('Data Organization' , 'CIND110' , 4, 'MIE'),
('Data Analytics' , 'CIND123' , 4, 'MIE');

CREATE TABLE SECTION (section_id varchar(20), course_number varchar (20) , Semester varchar(10), syear integer, instructor varchar (20));
DESCRIBE SECTION ;
INSERT INTO SECTION VALUES ('YJ5', 'CIND123' , 'Fall', 2016 , 'Sally'),
('KJ2', 'CCPS305' , 'Fall', 2018 , 'Harry'),
('YJ2', 'CIND110' , 'Winter', 2019 , 'Larry'),
('YJ3', 'CIND110' , 'Fall', 2018 , 'Sally'),
('KJ3', 'CIND110' , 'Winter', 2019 , 'Garry');

CREATE TABLE Grade_REPORT (student_number integer , section_id varchar(10) , grade varchar(2));
DESCRIBE Grade_REPORT;
INSERT INTO Grade_REPORT VALUES (17 , 'YJ2 ' , 'B'),
(18 , 'YJ3 ' , 'C'),
(17 , 'KJ3 ' , 'A'),
(19 , 'YJ3 ' , 'B');

############################################################################################
#1. Unary Relational Operations: SELECT
select distinct *
from SECTION
where sYear > 2016;

select distinct *
from SECTION
where sYear >= 2016 and sYear < 2019;

# 2. Unary Relational Operations: PROJECT
select distinct Section_id , Course_number
from SECTION
where sYear <> 2018;

select distinct Course_number
from SECTION ;

# 3. Unary Relational Operations: RENAME
select distinct Course_number as CNO , Course_name as CNOM
from COURSE Where Credit_hours = 4;

# 4. Operations from Set Theory
SELECT distinct Section_id FROM SECTION
UNION
SELECT distinct Section_id FROM Grade_REPORT ;

# Except
SELECT distinct Section_id FROM SECTION
where Section_id not in (SELECT distinct Section_id FROM Grade_REPORT);

# Intersect
SELECT distinct Section_id FROM SECTION
where Section_id in (SELECT distinct Section_id FROM Grade_REPORT);

# 5. The Cartesian Product (CROSS PRODUCT)
# Union
SELECT distinct STUDENT.sName , STUDENT.snumber , Grade_REPORT . Student_number
FROM STUDENT
CROSS JOIN
Grade_REPORT ;

# 6. Binary Relational Operations
# INNER JOIN
SELECT distinct *
FROM COURSE as C
INNER JOIN SECTION as S
ON S. Course_number = C. Course_number ;

#LEFT JOIN
SELECT distinct *
FROM COURSE as C
LEFT JOIN SECTION as S
ON S. Course_number = C. Course_number ;

# 7. Aggregate Functions and Grouping
# COUNT
SELECT Department , COUNT(Course_name) As Count_Courses
FROM COURSE
Group by Department ;
