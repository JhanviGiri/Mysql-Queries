CREATE DATABASE college_db;
USE college_db;

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50),
    fee INT
);

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    course_id INT,
    marks INT,
    admission_year INT,
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

INSERT INTO course (course_id, course_name, instructor, fee)
VALUES
(101, 'Java', 'Rahul Sharma', 15000),
(102, 'Python', 'Priya Singh', 14000),
(103, 'SQL', 'Amit Verma', 12000),
(104, 'Machine Learning', 'Neha Gupta', 20000),
(105, 'Web Development', 'Rohit Jain', 16000);


INSERT INTO student
(student_id, student_name, age, city, course_id, marks, admission_year)
VALUES
(1, 'Aarav', 21, 'Indore', 101, 85, 2025),
(2, 'Priya', 22, 'Bhopal', 102, 92, 2025),
(3, 'Rahul', 20, 'Indore', 103, 78, 2024),
(4, 'Sneha', 23, 'Ujjain', 104, 88, 2025),
(5, 'Karan', 21, 'Bhopal', 101, 72, 2024),
(6, 'Anjali', 22, 'Indore', 102, 95, 2024),
(7, 'Vikas', 20, 'Dewas', 103, 67, 2025),
(8, 'Neha', 23, 'Ujjain', 104, 91, 2024);

select * from student;

select * from course;

-- JOINS
-- Query - 1
select course.course_id, course.course_name, student.student_name
from course
inner join student
on course.course_id = student.course_id;

-- SubQueries
-- Query - 6
select student_name,marks from student
where marks > 
(select avg(marks) from student);

-- Query - 7
select student_name,marks from student 
where marks = 
(select max(marks) from student);

-- Query - 8
select student_name, marks from student 
where marks > 
(select avg(marks) from student where course_id = 101);

-- Query - 9
 select count(city) as "Number of student in cities" 
from student group by city;

-- Query - 10
select student_name, city, marks from student 
where marks >
(select avg(marks) from student where city = 'Indore');

-- Query - 11
with AvgMarks as (
select course_id,  avg(marks) as avgMarks
from student 
group by course_id 
)
select * from AvgMarks;

-- Query - 12
with MaxMarks as (
select student_name, course_id, marks
from student 
where marks >= 80
)
select * from MaxMarks;

-- Query - 13
with AvgMarks as (
select city,  avg(marks) as avgMarks
from student 
group by city 
)
select * from AvgMarks;

-- Query - 14
with StudentCount as (
select course_id,  count(student_id) as studentCount
from student 
group by course_id 
)
select * from StudentCount;

-- Query -  15
-- Assign a unique row number to every student based on their marks from highest to lowest.
select student_id, student_name, marks, 
row_number() 
over (order by marks desc) 
as MarksOrder
from student;

-- Query - 16
select student_name, marks,
row_number()
over ( order by marks desc)
as ranks
from student;

-- Query - 17
select student_name, course_id, marks, 
row_number()
over ( partition by course_id 
order by marks desc)
as course_ranks
from student;

-- Query - 18
select student_name, course_id, marks,
avg (marks)
over ( partition by course_id)
as course_average
from student;

-- Query - 19
create index idx_city on student (city);
show index from student;

-- Query - 20 
create index idx_marks on student(marks);
show index from student;

-- Query - 21
create index idx_courseId_marks on student(course_id, marks);
show index from student;

-- Query - 22
select substring(student_name,1,3) from student;

-- Query - 23
select distinct city, Length(city) from student;

-- Query - 24
select course_id, count(*)
from student 
group by course_id
having count(course_id) > 1;

-- Query - 25
-- 2nd Max Marks and student name
-- METHOD - 1 
select student_name, marks 
from student
order by marks desc
limit 1
offset 1;

-- METHOD -2 
select max(marks) 
from student 
where marks < 
(select max(marks) from student);
