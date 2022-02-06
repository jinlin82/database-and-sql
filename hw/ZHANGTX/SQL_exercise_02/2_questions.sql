-- LINK : Employee_management
-- 2.1 Select the last name of all employees.

Select * from Employees;
Select * from departments;

SELECT lastname FROM employees;
-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT lastname FROM employees;
-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM employees
WHERE lastname='Smith';
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees
WHERE lastname='Smith' or  lastname='Doe';
-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM employees
WHERE department=14;
-- 2.6 Select all the data of employees that work in department 37 or department
-- 77.
SELECT * FROM employees
WHERE department=37 or department=77 ;
-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM employees
WHERE lastname like 'S%' ;
-- 2.8 Select the sum of all the departments' budgets.
SELECT sum(budget)
FROM departments;
-- 2.9 Select the number of employees in each department (you only need to show
-- the department code and the number of employees).
SELECT department,count(department) as number
from employees
GROUP by department;
-- 2.10 Select all the data of employees, including each employee's department's
-- data.
SELECT *
FROM employees , departments
WHERE employees.department=departments.code;
-- 2.11 Select the name and last name of each employee, along with the name and
-- budget of the employee's department.
SELECT employees.name,lastname,budget
FROM employees , departments
WHERE employees.department=departments.code;
-- 2.12 Select the name and last name of employees working for departments with
-- a budget greater than $60,000.
SELECT employees.name,lastname
FROM employees , departments
WHERE employees.department=departments.code AND budget>=60000;
-- 2.13 Select the departments with a budget larger than the average budget of
-- all the departments.
SELECT code
from departments,(SELECT avg (budget) FROM departments)as new
WHERE budget>=new.avg;
-- 2.14 Select the names of departments with more than two employees.
SELECT name
from employees,(SELECT department
from employees
group by department
HAVING count(department)>=2)as new
WHERE employees.department=new.department
-- 2.15 Very Important - Select the name and last name of employees working for
-- departments with second lowest budget.
SELECT name,lastname
from employees,(SELECT code FROM departments order by budget LIMIT 1 OFFSET 1 )as new
WHERE employees.department=new.code;

-- 2.16  Add a new department called "Quality Assurance", with a budget of
-- $40,000 and departmental code 11. 
INSERT into departments(code,name,budget)
VALUES(11, 'Quality Assurance',40000);
-- And Add an employee called "Mary Moore" in that department, with SSN
-- 847-21-9811.
INSERT into employees(name,lastname,ssn,department)
VALUES('Mary', 'Moore',847-21-9811,11);
-- 2.17 Reduce the budget of all departments by 10%.
UPDATE departments
set budget=0.9*budget;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT
-- department (code 14).
SELECT * from departments;
SELECT * from employees;

UPDATE employees
set department=14
WHERE department=77;
-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM employees
WHERE department=14;
-- 2.20 Delete from the table all employees who work in departments with a
-- budget greater than or equal to $60,000.
DELETE from employees
WHERE department in
(SELECT code from departments WHERE budget>=60000);
-- 2.21 Delete from the table all employees.
DELETE from employees;
