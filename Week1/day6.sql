CREATE TABLE Employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    experience INT
);

INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 75000, 'Hyderabad', 5),
(102, 'Anjali', 'HR', 45000, 'Chennai', 3),
(103, 'Kiran', 'IT', 82000, 'Bangalore', 6),
(104, 'Sneha', 'Finance', 67000, 'Hyderabad', 4),
(105, 'Aman', 'HR', 39000, 'Pune', 2),
(106, 'Ravi', 'Finance', 91000, 'Mumbai', 8),
(107, 'Divya', 'IT', 55000, 'Chennai', 3),
(108, 'Meena', 'Sales', 48000, 'Bangalore', 2),
(109, 'Arjun', 'Sales', 61000, 'Hyderabad', 5),
(110, 'Pooja', 'IT', 73000, 'Mumbai', 4),
(111, 'Vikas', 'HR', 52000, 'Pune', 3),
(112, 'Nisha', 'Finance', 88000, 'Bangalore', 7),
(113, 'Tarun', 'Sales', 46000, 'Chennai', 2),
(114, 'Kavya', 'IT', 97000, 'Hyderabad', 9),
(115, 'Manoj', 'Finance', 58000, 'Mumbai', 4);
--Questions
--SELECT
--Display all employee details.
SELECT * FROM Employees

--Display only employee names and salaries.
  SELECT 
    emp_name,
    salary
FROM Employees;


--Display employee names and departments.
SELECT 
    emp_name,
    department
FROM Employees;


--Display all employees from the IT department.
SELECT *
FROM Employees
WHERE department = 'IT';

--Display employee names and experience.
SELECT 
    emp_name,
    experience
FROM Employees;



--WHERE
--Find employees with salary greater than 70000.
SELECT *
FROM Employees
WHERE salary > 70000;
  
--Find employees working in Hyderabad.
SELECT *
FROM Employees
WHERE city = 'Hyderabad';


--Find employees with experience less than 4 years.
SELECT *
FROM Employees
WHERE experience < 4;

--Find employees from Finance department.
SELECT *
FROM Employees
WHERE department = 'Finance';

--Find employees whose salary is equal to 52000.
SELECT *
FROM Employees
WHERE salary = 52000;

--GROUP BY


--Find total salary department-wise.
SELECT 
    department,
    SUM(salary) AS total_salary
FROM Employees
GROUP BY department;


--Find average salary in each department.
SELECT 
    department,
    AVG(salary) AS avg_salary
FROM Employees
GROUP BY department;



--Count employees in each city.
SELECT 
    city,
    COUNT(*) AS employee_count
FROM Employees
GROUP BY city;



--Find maximum salary in each department.
SELECT 
    department,
    MAX(salary) AS max_salary
FROM Employees
GROUP BY department;


--Find minimum experience department-wise.
SELECT 
    department,
    MIN(experience) AS min_experience
FROM Employees
GROUP BY department;


--HAVING
--Find departments having more than 3 employees.
SELECT department FROM Employees
GROUP BY department
having COUNT(emp_id)>3

-- Find departments having average salary greater than 60000.

SELECT department
FROM Employees
GROUP BY department
HAVING AVG(salary) > 60000;


--Find cities having more than 2 employees.
SELECT city
FROM Employees
GROUP BY city
HAVING COUNT(*) > 2;


--Find departments where total salary is greater than 200000.
SELECT department FROM Employees
GROUP BY department
HAVING SUM(salary)>200000


--Find departments where maximum salary is above 90000.
  SELECT department FROM Employees
GROUP BY department
HAVING MAX(salary)>90000

  

--TOP
--Display top 5 highest paid employees.
SELECT emp_name,salary FROM Employees
Order BY salary DESC
limit 5

--Display top 3 employees with highest experience.
SELECT 
    emp_name,
    experience
FROM Employees
ORDER BY experience DESC
LIMIT 3;



--Display top 2 salaries from Finance department.


SELECT 
    emp_name,
    salary
FROM Employees
WHERE department = 'Finance'
ORDER BY salary DESC
LIMIT 2;


--Display top 4 employees from Hyderabad.
SELECT *
FROM Employees
WHERE city = 'Hyderabad'
LIMIT 4;

--Display top 1 highest salary employee.
SELECT *
FROM Employees
ORDER BY salary DESC
LIMIT 1;

--DISTINCT
--Display distinct department names.
SELECT DISTINCT department
FROM Employees;

--Display distinct city names.
SELECT DISTINCT city
FROM Employees;

--Display distinct salary values.
SELECT DISTINCT salary
FROM Employees;


--Display distinct combinations of department and city.
SELECT DISTINCT
    department,
    city
FROM Employees;


--Display distinct experience values.
SELECT DISTINCT experience
FROM Employees;

--COMPARISON OPERATORS
--Find employees with salary >= 80000.
SELECT *
FROM Employees
WHERE salary >= 80000;

--Find employees with experience <= 3.
SELECT *
FROM Employees
WHERE experience <= 3;


--Find employees whose salary <> 45000.
SELECT *
FROM Employees
WHERE salary <> 45000;
--<> means not equal to.


--Find employees with salary < 50000.
SELECT *
FROM Employees
WHERE salary < 50000;


--Find employees with experience > 5.

SELECT *
FROM Employees
WHERE experience > 5;

--LOGICAL OPERATORS
--Find employees from IT department AND salary greater than 70000.
SELECT emp_name
FROM Employees
WHERE department = 'IT'
  AND salary > 70000;


--Find employees from Hyderabad OR Bangalore.
SELECT *
FROM Employees
WHERE city = 'Hyderabad'
   OR city = 'Bangalore';
--or
SELECT *
FROM Employees
WHERE city IN ('Hyderabad', 'Bangalore');


--Find employees from HR department AND experience less than 3.
SELECT *
FROM Employees
WHERE department = 'HR'
  AND experience < 3;


--Find employees with salary greater than 60000 OR experience greater than 6.
SELECT *
FROM Employees
WHERE salary > 60000
   OR experience > 6;


--Find employees NOT from Sales department.
SELECT *
FROM Employees
WHERE department <> 'Sales';

--IN AND NOT IN
--Find employees working in ('Hyderabad', 'Mumbai').
SELECT *
FROM Employees
WHERE city IN ('Hyderabad', 'Mumbai');


--Find employees whose department IN ('IT', 'Finance').
SELECT *
FROM Employees
WHERE department IN ('IT', 'Finance');


--Find employees whose city NOT IN ('Chennai', 'Pune').
SELECT *
FROM Employees
WHERE city NOT IN ('Chennai', 'Pune');

--Find employees whose salary IN (45000, 75000, 91000).
SELECT *
FROM Employees
WHERE salary IN (45000, 75000, 91000);

--Find employees whose department NOT IN ('HR', 'Sales').
SELECT *
FROM Employees
WHERE department NOT IN ('HR', 'Sales');

--BETWEEN
--Find employees with salary BETWEEN 50000 AND 80000.
SELECT *
FROM Employees
WHERE salary BETWEEN 50000 AND 80000;


--Find employees with experience BETWEEN 3 AND 6.
SELECT *
FROM Employees
WHERE experience BETWEEN 3 AND 6;


--Find employees whose emp_id BETWEEN 105 AND 112.
SELECT *
FROM Employees
WHERE emp_id BETWEEN 105 AND 112;

--or
SELECT *
FROM Employees
WHERE emp_id >= 105
  AND emp_id <= 112;

--Find employees with salary NOT BETWEEN 40000 AND 60000.
SELECT *
FROM Employees
WHERE salary NOT BETWEEN 40000 AND 60000;
--or
SELECT *
FROM Employees
WHERE salary < 40000
   OR salary > 60000;

--Find employees with experience BETWEEN 2 AND 4.
SELECT *
FROM Employees
WHERE experience BETWEEN 2 AND 4;

--LIKE OPERATOR
--Find employees whose names start with 'R'.
SELECT *
FROM Employees
WHERE emp_name LIKE 'R%';


--Find employees whose names end with 'a'.
SELECT *
FROM Employees
WHERE emp_name LIKE '%a';

--Find employees whose names contain 'v'.
SELECT *
FROM Employees
WHERE emp_name LIKE '%v%';

--Find employees whose city starts with 'B'.
SELECT *
FROM Employees
WHERE city LIKE 'B%';


--Find employees whose department ends with 's'.
SELECT *
FROM Employees
WHERE department LIKE '%s';
