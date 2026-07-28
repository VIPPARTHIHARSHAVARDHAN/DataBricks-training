
--1)Display employees with row numbers based on highest salary.
SELECT EmployeeName,
Salary,
ROW_NUMBER() OVER(order by Salary DESC) as row_num
FROM Employees;

--2)Assign row numbers department-wise based on salary.
SELECT EmployeeName,
       DepartmentID,
       Salary,
       ROW_NUMBER() OVER (
           PARTITION BY DepartmentID
           ORDER BY Salary DESC
       ) AS row_num
FROM Employees;

--3)Find the highest-paid employee in each department.
SELECT EmployeeName,
       DepartmentID,
       Salary FROM(SELECT EmployeeName,
                          DepartmentID,
                          Salary,
                          RANK() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY Salary DESC
                           ) AS rnk
                    FROM Employees) t
WHERE rnk=1

--using CTE
WITH Ranked_employees AS(
                          SELECT EmployeeName,
                          DepartmentID,
                          Salary,
                          RANK() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY Salary DESC
                           ) AS rnk             
                          FROM Employees)

SELECT EmployeeName,
       DepartmentID,
       Salary FROM Ranked_employees
where rnk=1
  
--4)Find the second highest-paid employee from every department.
SELECT EmployeeName,
       DepartmentID,
       Salary FROM(SELECT EmployeeName,
                          DepartmentID,
                          Salary,
                          DENSE_RANK() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY Salary DESC
                           ) AS rnk
                    FROM Employees) t
WHERE rnk=2
--using CTE
WITH Ranked_employees AS(
                          SELECT EmployeeName,
                          DepartmentID,
                          Salary,
                          DENSE_RANK() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY Salary DESC
                           ) AS rnk             
                          FROM Employees)

SELECT EmployeeName,
       DepartmentID,
       Salary FROM Ranked_employees
where rnk=2

--5)Find the latest joined employee from every department.
SELECT EmployeeName,
       DepartmentID,
       JoiningDate FROM(SELECT EmployeeName,
                          DepartmentID,
                          JoiningDate,
                          ROW_NUMBER() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY JoiningDate DESC
                           ) AS row_num
                    FROM Employees) t
WHERE row_num=1

--using cte
WITH Latest_Employees AS (
    SELECT EmployeeName,
           DepartmentID,
           JoiningDate,
           ROW_NUMBER() OVER (
               PARTITION BY DepartmentID
               ORDER BY JoiningDate DESC
           ) AS row_num
    FROM Employees
)

SELECT EmployeeName,
       DepartmentID,
       JoiningDate
FROM Latest_Employees
WHERE row_num = 1;

--6)Find the oldest employee in each department.
SELECT EmployeeName,
       DepartmentID,
       JoiningDate FROM(SELECT EmployeeName,
                          DepartmentID,
                          JoiningDate,
                          ROW_NUMBER() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY JoiningDate asc
                           ) AS row_num
                    FROM Employees) t
WHERE row_num=1

--using CTE
WITH Oldest_Employees AS (
    SELECT EmployeeName,
           DepartmentID,
           JoiningDate,
           ROW_NUMBER() OVER (
               PARTITION BY DepartmentID
               ORDER BY JoiningDate asc
           ) AS row_num
    FROM Employees
)

SELECT EmployeeName,
       DepartmentID,
       JoiningDate
FROM Oldest_Employees
WHERE row_num = 1;

--7)Display top 3 highest-paid employees from every department.
SELECT EmployeeName,
       DepartmentID,
       Salary FROM(SELECT EmployeeName,
                          DepartmentID,
                          Salary,
                          DENSE_RANK() OVER (
                          PARTITION BY DepartmentID
                          ORDER BY Salary DESC
                           ) AS rnk
                    FROM Employees) t
WHERE rnk between 1 and 3

--using CTE
WITH Top3_Employees AS (
    SELECT EmployeeName,
           DepartmentID,
           Salary,
           DENSE_RANK() OVER (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)

SELECT EmployeeName,
       DepartmentID,
       Salary
FROM Top3_Employees
WHERE rnk BETWEEN 1 AND 3;

--8)Display employees with row numbers based on joining date.
SELECT EmployeeName,JoiningDate ,
ROW_NUMBER() OVER(ORDER BY JoiningDate ) as row_num FROM Employees

--9)Rank employees based on salary.
SELECT EmployeeName,Salary ,
RANK() OVER(ORDER BY Salary DESC ) as rnk FROM Employees

--10)Rank employees department-wise.
SELECT EmployeeName,Salary ,DepartmentId,
RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC ) as rnk FROM Employees

--11)Find employees having Rank = 1.

SELECT EmployeeName,
       Salary
FROM (
    SELECT EmployeeName,
           Salary,
           RANK() OVER (
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
) t
WHERE rnk = 1;
--Using CTE
WITH Ranked_Employees AS (
    SELECT EmployeeName,
           Salary,
           RANK() OVER (
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)

SELECT EmployeeName,
       Salary
FROM Ranked_Employees
WHERE rnk = 1;

--12)Find Top 5 salaries using Rank.
SELECT EmployeeName,
       Salary
FROM (
    SELECT EmployeeName,
           Salary,
           RANK() OVER (
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
) t
WHERE rnk between 1 and 5

  --cte
  WITH Ranked_Employees AS (
    SELECT EmployeeName,
           Salary,
           RANK() OVER (
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)

SELECT EmployeeName,
       Salary
FROM Ranked_Employees
WHERE rnk BETWEEN 1 AND 5;

--13)Display employees having Rank less than 3 department-wise.
SELECT EmployeeName,
       Salary,
       DepartmentID
FROM (
    SELECT EmployeeName,
           Salary,
           DepartmentID,
           RANK() OVER (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
) t
WHERE rnk <3;

--USING CTE
WITH Ranked_Employees AS (
    SELECT EmployeeName,
           Salary,
           DepartmentID,
           RANK() OVER (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)

SELECT EmployeeName,
       Salary,
       DepartmentID
FROM Ranked_Employees
WHERE rnk < 3;


--14)Explain the gap created by Rank().
SELECT EmployeeName,
       Salary,
       RANK() OVER (ORDER BY Salary DESC) AS rnk
FROM Employees;

-- RANK() assigns the same rank to rows with equal values.
-- If multiple rows share the same rank, the next rank is skipped.
-- This creates gaps in the ranking sequence.
-- Example: Ranks 1, 2, 2, 4 (Rank 3 is skipped).

--15)Assign Dense Rank based on salary.
SELECT EmployeeName,
       Salary,
       DENSE_RANK() OVER (
           ORDER BY Salary DESC
       ) AS dense_rnk
FROM Employees;





