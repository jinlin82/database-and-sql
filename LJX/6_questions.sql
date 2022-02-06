-- Scientists
-- 6.1 List all the scientists' names, their projects' names,
    -- and the hours worked by that scientist on each project,
    -- in alphabetical order of project name, then scientist name.

SELECT * FROM scientists;
SELECT * FROM assignedto;
SELECT * FROM projects;

SELECT c.scientist_name,d.name as project_name FROM (SELECT a.name as scientist_name,a.ssn,b.project,b.scientist FROM scientists AS a LEFT JOIN assignedto AS b ON a.ssn=b.scientist) AS c LEFT JOIN projects AS d ON c.project=d.code;

SELECT a.name as scientist_name,a.ssn,b.project FROM scientists AS a LEFT JOIN assignedto AS b ON a.ssn=b.scientist;
-- 6.2 Select the project names which are not assigned yet
SELECT name from projects WHERE code NOT IN (SELECT project from assignedto);