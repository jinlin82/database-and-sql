-- *********exercise2************
-- LINK : Employee_management
-- 2.1 Select the last name of all employees.

SELECT * from employees;
SELECT * from departments;

select LastName from Employees;

-- 2.2 Select the last name of all employees, without duplicates.
select distinct LastName from Employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM employees where lastname = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees where lastname = 'Smith' OR lastname = 'Doe';

-- 2.5 Select all the data of employees that work in department 14.
select * from employees WHERE department =14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from employees WHERE department =37 or department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
select * from employees WHERE lastname like 'S%';

-- 2.8 Select the sum of all the departments' budgets.
SELECT sum(budget) from departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT department,count(department) from employees group by department;

-- 2.10 Select all the data of employees, including each employee's department's data.
select * from(SELECT * from employees)as b left JOIN (SELECT*from departments)as a on a.code = b.department;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT a.name first_name,a.lastname, b.name,b.budget from employees a,departments b WHERE a.department = b.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT name,lastname from employees where department in (select code from departments WHERE budget >60000);

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT code, name from departments  where budget > (select avg(budget) from departments);

-- 2.14 Select the names of departments with more than two employees.
SELECT name from departments WHERE code in (SELECT department from employees GROUP by department HAVING count(*)>2);

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT name ,lastname from employees WHERE department in (SELECT code from departments order by budget LIMIT 1 OFFSET 1);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO departments VALUES(11,'Quality Assurance',40000);
INSERT INTO employees values(847219811,'Mary','Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.
UPDATE departments set budget = budget*0.9;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees set department = 14 where department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE from employees where department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE from employees WHERE department in (SELECT code from departments where budget >= 60000);

-- 2.21 Delete from the table all employees.
DELETE from employees;