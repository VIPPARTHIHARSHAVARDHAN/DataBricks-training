--table creation
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    department_block_number INT
);
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(30),
    address VARCHAR(40),
    city VARCHAR(30),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(30),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);
CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(30),
    subject_code VARCHAR(10),
    staff_id INT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);
CREATE TABLE Mark (
    value INT,
    subject_id INT,
    student_id INT,
    PRIMARY KEY (subject_id, student_id),
    FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id),
    FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
);


--Questions
--Write a query to display list of students name and their department name who are all from 'Coimbatore'. Sort the result based on students name
SELECT s.student_name,
       d.department_name
FROM Student s
JOIN Department d
ON s.department_id = d.department_id
WHERE s.city = 'Coimbatore'
ORDER BY s.student_name;

--Insert the following records into the department table

--| Department_id | Department_name | department_block_number |
--| 1 | CSE | 3 |
--| 2 | IT | 3 |
--| 3 | SE | 3 |

INSERT INTO Department (department_id, department_name, department_block_number)
VALUES
(1, 'CSE', 3),
(2, 'IT', 3),
(3, 'SE', 3);

--Write a query to display the names of the departments in block number 3. Sort the records in ascending order.
SELECT department_name
FROM Department
WHERE department_block_number = 3
ORDER BY department_name ASC;

--Write a query to display address details by concatenating address and city of students . Give an alias as Address and sort the result based on the concatenated column in descending order

--> Example: 

--    Address - Toms Town

--    City - Bangalore

--> Output:

 --   Toms Town, Bangalore

SELECT CONCAT(address, ', ', city) AS Address
FROM Student
ORDER BY Address DESC;





