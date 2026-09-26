--Write a SQL query to display the employee name, department, and salary by 
--joining the employees table with the departments table.
select e.name,d.department,e.salary FROM employees e
JOIN departments d on d.department_id=e.department_id

--Write a SQL query to display all employees, 
--including employees who do not belong to any departmen

select * FROM employees e
Left JOIN departments d on d.department_id=e.department_id



--Write a SQL query to display all departments, 
--including departments that currently have no employees.
select * FROM employees e
RIGHT JOIN departments d on d.department_id=e.department_id

--Write a SQL query to display the names of 
--employees who are not assigned to any department.
select * FROM employees e
Left JOIN departments d on d.department_id=e.department_id
WHERE d.department_id IS NULL


--Display each department and the number of employees working in that department, 
--including departments with zero employees.
SELECT department,COUNT(emp_id) as no_of_employees FROM department d
LEFT JOIN employees e on  e.department_id=d.department_id
GROUP BY d.department_id

--Display the departments that have more employees than the
-- average number of employees across all departments.
SELECT d.department,
       COUNT(e.emp_id) AS emp_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department
HAVING COUNT(e.emp_id) > (
    SELECT AVG(emp_count)
    FROM (
        SELECT department_id,
               COUNT(emp_id) AS emp_count
        FROM employees
        GROUP BY department_id
    ) t
);



--or
SELECT department, emp_count
FROM (
    SELECT department,
           emp_count,
           AVG(emp_count) OVER () AS avg_count
    FROM (
        SELECT d.department,
               COUNT(e.emp_id) AS emp_count
        FROM departments d
        LEFT JOIN employees e
            ON d.department_id = e.department_id
        GROUP BY d.department_id, d.department
    ) t1
) t2
WHERE emp_count > avg_count;


--Write a SQL query to find the employee(s) who have the second-highest salary 
--in each department.
select * FROM
(select name,salary,
DENSE_RANK() over(partition by d.department order by salary DESC ) as rnk
FROM employees e JoiN departments d on d.department_id=e.department_id) t
where rnk=2

--or without window functions
SELECT e.name,
       d.department,
       e.salary
FROM employees e
JOIN departments d
    ON d.department_id = e.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary < (
          SELECT MAX(e3.salary)
          FROM employees e3
          WHERE e3.department_id = e.department_id
      )
);



--Write a SQL query to find employees whose salary is greater 
--than the average salary of their own department.
select name,salary FROM employees e 
JOIN department d on e.department_id=d.department_id 
where salary>(

SELECT AVG(salary) as dept_avg_salary FROM employees e1
where e.department_id=e1.department_id

)

--or using window function
SELECT * FROM(
SELECT e.name,e.salary,
AVG(salary) over (partition by d.department) as dept_average_salary
 FROM employee e JOIN departments d on e.department_id = d.department_id
 )
 where salary>dept_average_salary


 --Department with the highest average salary, 
 --including all departments tied for the highest average.
 SELECT d.department,
       AVG(e.salary) AS highest_average_salary
FROM departments d
JOIN employees e
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department
HAVING AVG(e.salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT AVG(salary) AS avg_salary
        FROM employees e1
        GROUP BY e1.department_id
    ) t
);

--using window functions
SELECT department, avg_salary
FROM (
    SELECT d.department,
           AVG(e.salary) AS avg_salary,
           DENSE_RANK() OVER (
               ORDER BY AVG(e.salary) DESC
           ) AS rnk
    FROM departments d
    JOIN employees e
        ON d.department_id = e.department_id
    GROUP BY d.department_id, d.department
) t
WHERE rnk = 1;

--Find all employees who belong to the IT department, while still displaying 
--employees who don't belong to any department.
SELECT e.name,d.department FROM departments d 
RIGHT join employees e on e.department_id=d.department_id
WHERE d.department='IT' or d.department is NULL


--Find each department and the number of 
--distinct salaries paid in that department.
SELECT d.department,count(distinct e.salary) FROM employees e
JOIN departments d on d.department_id=e.department_id
GROUP BY d.department_id

--Display the employee name, department name, and location name for every employee.
select e.name,d.department,l.location FROM employees e
JOIN departments d on e.department_id=d.department_id
JOIN location l on l.location_id=d.location_id


--Display each employee's name along with their manager's name.
SELECT e.name AS employee_name,m.name as manager_name
FROM employees e JOIN employees m on e.manager_id=m.emp_id

--Find the employees whose salary is greater than their manager's salary.
SELECT e.name
FROM employees e JOIN employees m on e.manager_id=m.emp_id
where e.salary>m.salary

--Find all departments that have NO employees assigned to them.
select d.department from departments d 
left join employees e on e.department_id=d.department_id
where emp_id is NULL

--using not exist
SELECT d.department from department d 
where not exists
 (select 1 from 
 employees e where e.department_id=d.department_id)

--Find all departments that have at least one employee assigned to them.
SELECT DISTINCT d.department
FROM departments d
JOIN employees e
    ON e.department_id = d.department_id
WHERE e.emp_id IS NOT NULL;

--or
--using exist
SELECT d.department from department d
where exists 
(select 1 from employees e 
where e.department_id=d.department_id)



--Find the departments where the total salary of all 
--employees in that department is greater than ₹5,00,000.
select d.department,sum(salary) as department_salary FROM employees e
join  departments d on d.department_id=e.department_id
group by department
having sum(salary)>500000

--using window functions
SELECT DISTINCT department, department_salary
FROM (
    SELECT d.department,
           SUM(e.salary) OVER (
               PARTITION BY e.department_id
           ) AS department_salary
    FROM employees e
    JOIN departments d
        ON d.department_id = e.department_id
) t
WHERE department_salary > 500000;











