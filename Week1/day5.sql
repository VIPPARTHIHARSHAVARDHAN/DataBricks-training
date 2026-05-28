-- SQL Window Functions and CTE Assignment
-- Compatible with PostgreSQL

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    manager_id INT NULL,
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insert Employees
INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', NULL, 70000, '2020-01-15'),
(2, 'Bob Smith', 'Sales', 1, 65000, '2021-03-20'),
(3, 'Charlie Brown', 'IT', NULL, 90000, '2019-07-01'),
(4, 'Diana Prince', 'IT', 3, 95000, '2018-11-11'),
(5, 'Ethan Hunt', 'HR', NULL, 60000, '2022-02-10'),
(6, 'Fiona Green', 'HR', 5, 58000, '2023-05-12'),
(7, 'George Miller', 'Finance', NULL, 85000, '2017-09-18'),
(8, 'Hannah Lee', 'Finance', 7, 82000, '2021-08-30');

-- Insert Customers
INSERT INTO customers VALUES
(1, 'Acme Corp', 'New York'),
(2, 'Tech Solutions', 'Chicago'),
(3, 'Global Retail', 'Dallas'),
(4, 'Blue Sky Ltd', 'Seattle'),
(5, 'NextGen Systems', 'Boston');

-- Insert Orders
INSERT INTO orders VALUES
(101, 1, 1, '2024-01-10', 500),
(102, 2, 2, '2024-01-11', 700),
(103, 1, 1, '2024-01-15', 1200),
(104, 3, 3, '2024-01-18', 300),
(105, 4, 4, '2024-01-20', 900),
(106, 5, 2, '2024-01-25', 1500),
(107, 2, 1, '2024-02-01', 650),
(108, 1, 3, '2024-02-05', 1100),
(109, 3, 4, '2024-02-10', 400),
(110, 4, 2, '2024-02-15', 950),
(111, 5, 1, '2024-02-20', 2000),
(112, 1, 4, '2024-02-25', 750);

-- Notes:
-- Multiple departments for PARTITION BY exercises.
-- Salary variations for ranking exercises.
-- Multiple customer orders for LAG/LEAD analysis.
-- Manager hierarchy included for recursive CTE practice.

--QUESTIONS
-- 1. Use ROW_NUMBER() to assign a row number to employees ordered by salary descending.
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- 2. Use RANK() to rank employees by salary.
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    Rank() OVER (ORDER BY salary DESC) AS rank
FROM employees;


-- 3. Use DENSE_RANK() to rank employees by salary.
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    DENSE_Rank() OVER (ORDER BY salary DESC) AS rank
FROM employees;


-- 4. Find the top 3 highest-paid employees using a window function.
SELECT * FROM(SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    Rank() OVER (ORDER BY salary DESC) AS emp_rank
FROM employees)
WHERE rank<=3
--or
SELECT * FROM(SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    row_number() OVER (ORDER BY salary DESC) AS rn
FROM employees)
WHERE rn<=3



-- 5. Rank employees within each department using PARTITION BY.
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    Rank() OVER (partition BY department 
                 order by salary  DESC) as dept_rank
FROM employees




-- 6. Display the highest salary in each department using a window function.
SELECT * FROM(SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    Rank() OVER (partition BY department 
                 order by salary  DESC) as dept_rank
FROM employees)
WHERE dept_rank=1

--0r


SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) AS highest_salary
FROM employees;





-- 7. Calculate the running total of order amounts ordered by order_date.
SELECT 
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
    ) AS running_total
FROM orders;


-- 8. Calculate the cumulative sales amount for each employee.
-- 8. Calculate the cumulative sales amount for each employee.

SELECT 
    employee_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY employee_id
        ORDER BY order_date
    ) AS cumulative_sales
FROM orders;


-- 9. Use LAG() to show the previous order amount for each customer.

SELECT 
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders;

-- 10. Use LEAD() to show the next order amount for each customer.

SELECT 
    customer_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount
FROM orders;


-- 11. Find the difference between the current order amount and previous order amount.
SELECT 
    customer_id,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS amount_difference
FROM orders;


-- 12. Calculate a moving average of the last 3 orders.

SELECT 
    order_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average
FROM orders;


-- 13. Use NTILE(4) to divide employees into salary quartiles.

SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    NTILE(4) OVER (
        ORDER BY salary DESC
    ) AS salary_quartile
FROM employees;


-- 14. Find the first order placed by each customer using ROW_NUMBER().
SELECT *
FROM (
    SELECT 
        customer_id,
        order_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
) AS first_orders
WHERE rn = 1;


-- 15. Find the latest order placed by each customer.

SELECT *
FROM (
    SELECT 
        order_id,
        customer_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
) AS latest_orders
WHERE rn = 1;

-- 16. Display employee salaries along with department average salary.

SELECT 
    employee_name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS dept_avg_salary
FROM employees;


-- 17. Find employees earning above their department average salary.

SELECT *
FROM (
    SELECT 
        employee_name,
        department,
        salary,
        AVG(salary) OVER (
            PARTITION BY department
        ) AS dp_avg_salary
    FROM employees
) AS emp_avg
WHERE salary > dp_avg_salary;


-- 18. Use SUM() OVER(PARTITION BY department) to calculate department payroll.
SELECT 
        employee_name,
        department,
        salary,
        SUM(salary) OVER (
            PARTITION BY department
        ) AS payroll_salary
    FROM employees

-- 19. Find the percentage contribution of each employee salary within their department.

SELECT 
    employee_name,
    department,
    salary,
    (
        salary /
        SUM(salary) OVER (
            PARTITION BY department
        ) * 100
    ) AS percentage_contribution
FROM employees;


-- 20. Use COUNT() OVER() to show total number of employees alongside each row.

SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    COUNT(employee_id) OVER () AS total_employees
FROM employees;


-- 21. Create a CTE to calculate total sales per employee.
WITH employee_sales AS (
    SELECT 
        employee_id,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales;


-- 22. Use a CTE to find employees whose sales exceed the company average.
WITH employee_sales AS (
    SELECT 
        employee_id,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM employee_sales
);


-- 23. Create multiple CTEs to calculate customer total spending and rankings.

WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
),

customer_ranking AS (
    SELECT 
        customer_id,
        total_spending,
        RANK() OVER (
            ORDER BY total_spending DESC
        ) AS spending_rank
    FROM customer_spending
)

SELECT *
FROM customer_ranking;


-- 24. Write a recursive CTE to generate numbers from 1 to 10.

WITH RECURSIVE numbers AS (
    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 10
)

SELECT *
FROM numbers;


-- 25. Use a recursive CTE to display employee hierarchy data.
WITH RECURSIVE employee_hierarchy AS (

    SELECT 
        employee_id,
        employee_name,
        manager_id,
        department
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.department
    FROM employees e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.employee_id
)

SELECT *
FROM employee_hierarchy;


-- 26. Create a CTE that filters orders above the average order amount.
WITH avg_orders AS (
    SELECT AVG(total_amount) AS avg_order_amount
    FROM orders
)

SELECT *
FROM orders
WHERE total_amount > (
    SELECT avg_order_amount
    FROM avg_orders
);


-- 27. Use a CTE and window function together to rank customers by total spending.
WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
),

customer_ranking AS (
    SELECT 
        customer_id,
        total_spending,
        RANK() OVER (
            ORDER BY total_spending DESC
        ) AS spending_rank
    FROM customer_spending
)

SELECT *
FROM customer_ranking;


-- 28. Find the second-highest salary in each department.

SELECT *
FROM (
    SELECT 
        employee_id,
        employee_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
) AS ranked_employees
WHERE salary_rank = 2;


-- 29. Display the difference between each employee salary and the department maximum salary.
SELECT 
    employee_id,
    employee_name,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) - salary AS salary_difference
FROM employees;


-- 30. Combine CTEs and window functions to find the top-performing employee in each department based on total sales.
WITH employee_sales AS (
    SELECT 
        e.employee_id,
        e.employee_name,
        e.department,
        SUM(o.total_amount) AS total_sales
    FROM employees e
    JOIN orders o
    ON e.employee_id = o.employee_id
    GROUP BY 
        e.employee_id,
        e.employee_name,
        e.department
),

ranked_employees AS (
    SELECT 
        employee_id,
        employee_name,
        department,
        total_sales,
        RANK() OVER (
            PARTITION BY department
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM employee_sales
)

SELECT *
FROM ranked_employees
WHERE sales_rank = 1;

-- Bonus Challenge:
-- Create a report showing monthly sales trends using:
-- CTEs
-- Running totals
-- LAG()
-- Percentage growth calculations
