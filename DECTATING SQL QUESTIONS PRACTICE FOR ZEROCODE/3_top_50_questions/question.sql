--Find the names and salaries of employees whose salary is greater than 50,000.
SELECT name, salary
FROM employees
WHERE salary > 50000;

--Find all the different salary values that exist in the employees table.
SELECT Distinct salary from employees

--or
SELECT salary
FROM employees
GROUP BY salary;

--Display the employees in descending order of salary, but return only the first 3 employees
Select salary,name FROM employees
order by salary desc
limit 3

--or
SELECT name, salary
FROM (
    SELECT name,
           salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn <= 3;


--Display the employees with salaries between 50,000 and 70,000, inclusive.
SELECT name, salary
FROM employees
WHERE salary BETWEEN 50000 AND 70000;

--
SELECT name, salary
FROM employees
WHERE salary>=50000 AND salary<=70000

--Find the names of all employees whose salary has not been provided.
SELECT name, salary
FROM employees
WHERE salary IS NULL

--or
SELECT name,salary 
FROM employees 
WHERE NOT exist(select salary FROM employees)

--Find the employees who belong to department 10 or department 30.
SELECT name, salary
FROM employees
WHERE department_id IN (10, 30);

--or
SELECT name, salary
FROM employees
WHERE department_id =10 or department_id=10

--Find the doctors whose consultation fee is greater than 1500 and display their names and 
--fees in descending order of consultation fee.
SELECT doctor_name, consultation_fee
FROM doctors
WHERE consultation_fee > 1500
ORDER BY consultation_fee DESC;


--Find the products whose category is either Electronics or Accessories.
SELECT product_name
FROM products
WHERE category IN ('Electronics', 'Accessories');

--or
SELECT product_name
FROM products
WHERE category =Electronics OR category = Accessories