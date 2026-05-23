--tables query

-- SQL Joins Assignment Starter File
-- Compatible with PostgreSQL

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS instructors;

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100),
    department VARCHAR(100)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_id INT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert instructors
INSERT INTO instructors VALUES
(1, 'Sarah Connor', 'Databases'),
(2, 'Michael Scott', 'Programming'),
(3, 'Tony Stark', 'Cloud Computing'),
(4, 'Bruce Wayne', 'Cyber Security');

-- Insert students
INSERT INTO students VALUES
(1, 'Alice Johnson', 'alice@email.com'),
(2, 'Bob Smith', 'bob@email.com'),
(3, 'Charlie Brown', 'charlie@email.com'),
(4, 'Diana Prince', 'diana@email.com'),
(5, 'Ethan Hunt', 'ethan@email.com'),
(6, 'Fiona Green', 'fiona@email.com');

-- Insert courses
INSERT INTO courses VALUES
(101, 'SQL Basics', 1),
(102, 'Python Fundamentals', 2),
(103, 'Data Analytics', NULL),
(104, 'Cloud Computing', 3),
(105, 'Machine Learning', NULL),
(106, 'Cyber Security', 4);

-- Insert enrollments
INSERT INTO enrollments VALUES
(1, 1, 101, '2024-01-10'),
(2, 1, 102, '2024-01-12'),
(3, 2, 101, '2024-01-15'),
(4, 3, 104, '2024-01-20'),
(5, 4, 106, '2024-01-25');

-- Notes:
-- Student 5 and 6 are not enrolled in any course.
-- Courses 103 and 105 have no instructor assigned.
-- Courses 103 and 105 also have no enrollments.
-- Instructor 4 teaches one course.

--Assignment Questions
--1. Display all students and the courses they are enrolled in. Include students who are not enrolled in any course.
SELECT student_name,course_name FROM students
LEFT JOIN enrollments on students.student_id=enrollments.student_id
LEFT JOIN courses on courses.course_id=enrollments.course_id


--2. Find all courses that currently have no students enrolled.
SELECT course_name FROM students
right join enrollments on students.student_id=enrollments.student_id
right join courses on courses.course_id=enrollments.course_id
where student_name IS  NULL

--or
SELECT course_name
FROM courses
LEFT JOIN enrollments
ON courses.course_id = enrollments.course_id
WHERE enrollments.course_id IS NULL;


--3. Display all instructors and the courses they teach, including instructors who are not assigned to any course.
SELECT instructor_name,course_name FROM instructors
left join courses on instructors.instructor_id=courses.instructor_id

--4. Find all courses that do not have an instructor assigned.
SELECT instructor_name,course_name FROM instructors
right join courses on instructors.instructor_id=courses.instructor_id
WHERE instructor_name is NULL
--or
SELECT course_name
FROM courses
WHERE instructor_id IS NULL;

--5. Display all students and enrollment information using a RIGHT JOIN.
SELECT student_name,enrollment_id,course_id,enrollment_date FROM enrollments
Right join students on students.student_id=enrollments.student_id

--6. Find students who are not enrolled in any course.
Select student_name From students 
LEFT join enrollments on students.student_id=enrollments.student_id
WHERE course_id is NULL


--7. Use a FULL OUTER JOIN to display all students and enrollments, including unmatched rows from both tables.
  --full outer jion works only in postgreeSQL
SELECT students.student_name,
       enrollments.enrollment_id,
       enrollments.course_id,
       enrollments.enrollment_date
FROM students
LEFT JOIN enrollments
ON students.student_id = enrollments.student_id

UNION

SELECT students.student_name,
       enrollments.enrollment_id,
       enrollments.course_id,
       enrollments.enrollment_date
FROM students
RIGHT JOIN enrollments
ON students.student_id = enrollments.student_id;


--8. Find all courses that have never appeared in the enrollments table.
SELECT course_name FRom courses 
LEFT JOIN enrollments on enrollments.course_id=courses.course_id
WHERE enrollment_id is NULL


--9. Display all instructors and courses using a FULL OUTER JOIN and identify unmatched rows.
Select instructor_name,course_id,course_name From instructors
Left join courses on instructors.instructor_id=courses.instructor_id
UNION
Select instructor_name,course_id,course_name From instructors
Right join courses on instructors.instructor_id=courses.instructor_id


--10. Create a report showing: student name, course name, and instructor name. Include rows even if course or instructor information is missing.
SELECT student_name,course_name,instructor_name FROM students
LEFT JOIN enrollments on students.student_id=enrollments.student_id
LEFT JOIN courses on courses.course_id=enrollments.course_id
LEFT join instructors on instructors.instructor_id=courses.instructor_id


--Bonus Challenge:
--Write a query that lists every student and every course, even if there is no enrollment relationship between them.
SELECT student_name,
       course_name
FROM students
CROSS JOIN courses;
