-- LINK : Employee_management
-- 2.1 Select the last name of all employees.
SELECT * from employees;
Select lastname from Employees;
-- 2.2 Select the last name of all employees, without duplicates.
Select DISTINCT lastname from Employees;
-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * from Employees where lastname = 'Smith';
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * from Employees where lastname in ('Smith','Doe');
-- 2.5 Select all the data of employees that work in department 14.
SELECT * from Employees where department =14;
-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * from Employees where department in (37,77);
-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * from Employees where lastname LIKE 'S%';
-- 2.8 Select the sum of all the departments' budgets.
SELECT sum(budget) from departments;
-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT count(*),department from Employees GROUP BY department;
-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT * from Employees a LEFT JOIN departments b on a.department = b.code;
-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT a.name,a.lastname,b.budget,b.name FROM employees a left join departments b on a.department =b.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT a.name,a.lastname,b.budget,b.name FROM employees a left join departments b on a.department =b.code WHERE b.budget>60000;
-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT * from departments WHERE budget>(SELECT avg(budget) from departments);
-- 2.14 Select the names of departments with more than two employees 用了个临时表来，是不是可以嵌套连接？.
SELECT count(*),b.code into linshi_1 FROM employees a left join departments b on a.department =b.code  GROUP BY b.code HAVING count(*)>2;
SELECT departments.name FROM linshi_1 left JOIN departments on linshi_1.code=departments.code;
-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT a.name,a.lastname FROM employees a left join departments b on a.department =b.code WHERE b.budget=(SELECT budget from departments ORDER BY budget ASC OFFSET 1 ROWS FETCH FIRST 1 ROWS ONLY);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11.
INSERT INTO Departments(Code,Name,Budget) VALUES(11,'Quality Assurance',40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('847219811','Mary','Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.
UPDATE departments SET budget=budget*0.9;
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees SET department = 14 WHERE department=77;
-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM employees WHERE department=14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE a FROM employees a LEFT JOIN departments b ON a.department=b.code WHERE b.budget>=60000;

DELETE employees FROM employees LEFT JOIN departments ON employees.department=departments.code WHERE departments.budget>=60000;

DELETE FROM employees WHERE NOT EXISTS(SELECT 1 FROM departments b WHERE employees.department=b.code) AND b.budget>=60000;

SELECT 1 FROM departments b WHERE employees.department=b.code;
-- 2.21 Delete from the table all employees.

DELETE FROM employees;
