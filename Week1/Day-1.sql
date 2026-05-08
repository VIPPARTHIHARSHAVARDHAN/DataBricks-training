
--table creation queries
-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);


-- Insert additional data into Department table (if needed)
-- No additional departments needed for this data set

-- Insert additional data into Employee table to test edge cases for joins and nested queries
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

-- Insert additional data into Project table to test edge cases for joins
INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department



--query questions


--1)Select all columns from the employee table
SELECT * FROM Employee;

--2)Select only the name and salary columns from the Employee table.
SELECT name,salary FROM Employee

--Select employees who are older than 30.
SELECT * FROM Employee
WHERE age>30;

    
--Select the names of all departments.
SELECT name FROM Department;
    
--Select employees who work in the IT department.
SELECT name FROM Employee
where department_id=1;

    
--Select employees whose names start with 'J'.
SELECT * FROM Employee
WHERE name LIKE 'J%';



--Select employees whose names end with 'e'.
SELECT * FROM Employee
WHERE name LIKE '%e';


--Select employees whose names contain 'a'.
SELECT * FROM Employee
WHERE name LIKE '%a%';


--Select employees whose names are exactly 9 characters long.
SELECT * FROM Employee
WHERE LENGTH(name)=9;


--Select employees whose names have 'o' as the second character.
SELECT * FROM Employee
WHERE name LIKE '_o%';


--Select employees hired in the year 2020.
SELECT * FROM Employee
WHERE YEAR(hire_date)=2020;


--Select employees hired in January of any year.
SELECT * FROM Employee
WHERE MONTH(hire_date)=1;



--Select employees hired before 2019.
SELECT * FROM Employee
WHERE YEAR(hire_date)<2019;


--Select employees hired on or after March 1, 2021.
SELECT * FROM Employee
WHERE hire_date >='2021-03-01';



--Select employees hired in the last 2 years.
SELECT * FROM Employee
WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR;


--Select the total salary of all employees.
SELECT SUM(salary) as total_salary from Employee; 



--Select the average salary of employees.
SELECT AVG(salary) as average_salary from Employee; 


--Select the minimum salary in the Employee table.
SELECT MIN(salary) as MINIMUM_salary from Employee;


--Select the number of employees in each department.
select department_id,count(emp_id) from Employee
GROUP BY department_id;


--Select the average salary of employees in each department.
select department_id,avg(salary) from Employee
GROUP BY department_id;


--Select the total salary for each department.
select department_id,SUM(salary) from Employee
GROUP BY department_id;



--Select the number of employees hired in each year.
select YEAR(hire_date),count(emp_id) from Employee
GROUP BY YEAR(hire_date)


--Select the highest salary in each department.
select department_id,MAX(salary) from Employee
Group by department_id


--Select the department with the highest average salary.

--Select departments with more than 2 employees.
--Select departments with an average salary greater than 55000.
--Select years with more than 1 employee hired.
--Select departments with a total salary expense less than 100000.
--Select departments with the maximum salary above 75000.

--Select all employees ordered by their salary in ascending order.
--Select all employees ordered by their age in descending order.
--Select all employees ordered by their hire date in ascending order.
--Select employees ordered by their department and then by their salary.
--Select departments ordered by the total salary of their employees.

--Select employee names along with their department names.
--Select project names along with the department names they belong to.
--Select employee names and their corresponding project names.
--Select all employees and their departments, including those without a department.
--Select all departments and their employees, including departments without employees.
--Select employees who are not assigned to any project.
--Select employees and the number of projects their department is working on.
--Select the departments that have no employees.
--Select employee names who share the same department with 'John Doe'.
--Select the department name with the highest average salary.

--Select the employee with the highest salary.
--Select employees whose salary is above the average salary.
--Select the second highest salary from the Employee table.
--Select the department with the most employees.
--Select employees who earn more than the average salary of their department.
--Select the nth highest salary (for example, 3rd highest).
--Select employees who are older than all employees in the HR department.
--Select departments where the average salary is greater than 55000.
--Select employees who work in a department with at least 2 projects.
--Select employees who were hired on the same date as 'Jane Smith'.

--Select the total salary of employees hired in the year 2020.
--Select the average salary of employees in each department, ordered by the average salary in descending order.
--Select departments with more than 1 employee and an average salary greater than 55000.
--Select employees hired in the last 2 years, ordered by their hire date.
--Select the total number of employees and the average salary for departments with more than 2 employees.
--Select the name and salary of employees whose salary is above the average salary of their department.
--Select the names of employees who are hired on the same date as the oldest employee in the company.
--Select the department names along with the total number of projects they are working on, ordered by the number of projects.
--Select the employee name with the highest salary in each department.
--Select the names and salaries of employees who are older than the average age of employees in their department.
