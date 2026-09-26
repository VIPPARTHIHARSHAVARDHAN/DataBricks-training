--"Write a SQL query to find the names and salaries of all employees whose salary is greater than 50,000."
Select name,salary From employees
where salary >50,000;


--"Write a SQL query to find the total number of employees in each department."
select department,count(*) as employee_count From employees
group by department



--"Write a SQL query to find the departments that have more than 5 employees."
Select department,count(*) as employee_count From employees
group by department
 having employee_count>5 



--"Write a SQL query to display all employees whose salary is between 30,000 and 60,000."
SELECT * From employees
where salary >=30000 and salary <=60000
or 
where salary between 30000 and 60000

--"Write a SQL query to display the names of employees who do not have a salary value."
SELECT name From employees
where salary is NULL

--"Write a SQL query to display the names of employees whose department is either IT, HR, or Sales."
SELECT name From employees
where department in ('IT','HR','Sales')


--"Write a SQL query to display the names and salaries of employees whose salary is not between 30,000 and 60,000."
select name,salary FROM employees
where salary not between 30000 and 60000
or 
where salary >60000 or salary <30000

--"Write a SQL query to display the names and salaries of all employees, with the employees having the highest salary appearing first.
select name, salary From employees
order by salary desc

--"Write a SQL query to display the different departments available in the employees table, without displaying the same department more than once."
Select Distinct  department From employees


--"Write a SQL query to display the top 5 employees with the highest salaries."
SELECT name,salary From employees
order by salary DESC 
limit 5

--"Write a SQL query to find the second-highest salary from the employees table."
Select DISTINCT salary From employees
order by salary desc
limit 1 offset 1

--or
SELECT name, salary FROM(

Select name,salary,
DENSE_RANK  over (order by salary desc) as rnk
From employees

) t
where rnk=2


--or 
Select MAX(salary) as second_highest
From employees
where salary<(select MAX(salary) From employees)


--or 
SELECT salary
FROM (
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 2
) t
ORDER BY salary
LIMIT 1;

--"Write a SQL query to find the average salary for each department, and display only those 
--departments where the average salary is greater than 50,000."
SELECT department,AVG(salary) as average_salry from employees
group by department
having avg(salary)>50000

--or
SELECT department, average_salary
FROM (
    SELECT department,
           AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
) t
WHERE average_salary > 50000;

--or
WITH department_salary AS (
    SELECT department,
           AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
)
SELECT department, average_salary
FROM department_salary
WHERE average_salary > 50000;


--Write a SQL query to find the highest salary in each department."
SELECT MAX(salary),department FROM employees
group by department

--or
SELECT department, salary
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e2.department = e.department
);



--"Write a SQL query to find the number of employees in each department,
-- but do not include departments where the number of employees is less than 3."
SELECT department,count(employee_id) as no_of_employees FROM employees
GROUP BY department 
having count(employee_id)>=3

--"Write a SQL query to find the total salary paid by each department."
SELECT department,SUM(salary) as total_salary FROM employee
GROUP BY department


--"Write a SQL query to find the lowest salary in each department."
SELECT department,salary FROM employees e
where salary=
(select Min(salary) as min_salary
FROM employees e1
where e.department=e1.department
)

--or
SELECT department,MIN(salary) from employees
group by department

--or 
SELECT department, salary
FROM (
    SELECT department,
           salary,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary ASC
           ) AS rn
    FROM employees
) t
WHERE rn = 1;


--"Write a SQL query to display the names of 
--employees whose names start with the letter 'A'."
select name FROM employee
where name LIKE 'A%';

--"Write a SQL query to display the names
-- of employees whose names end with the letter 'n'."
select name FROM employee
where name LIKE '%n';
--"Write a SQL query to display the names of employees 
--whose names contain the letter 'a' anywhere in the name."
select name FROM employee
where name LIKE '%a%';


--"Write a SQL query to display the employee name and salary, 
--and create a new column called salary_category. If the salary is greater 
--than or equal to 50,000, classify the employee as 'High'; otherwise,
 --classify the employee as 'Low'."

 SELECT name,salary,
 CASE 
 When salary >=50000 THEN 'High' ELSE 'Low'
 END as salary_category
 FROM employee


--Q24. Write a SQL query to display the employee names and their salaries.
-- If the salary is NULL, display 0 instead of NULL.


select name,COALESCE(salary,0) as salary FROM employee;

--or 
select name,IFNULL(salary,0) as salary FROM employee;

--or
select name,
CASE
WHEN salary IS NULL THEN 0 ELSE salary 
END AS salary
 FROM employee;


--Write a SQL query to increase the salary by 10% for 
--all employees who belong to the IT department.
UPDATE employees
SET salary=salary+((salary*10)/100)
where department='IT'


--
