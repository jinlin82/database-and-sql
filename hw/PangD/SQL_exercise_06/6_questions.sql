-- Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT * FROM scientists;
SELECT * FROM projects;
SELECT * FROM assignedto;
SELECT s.name,p.name,SUM(p.hours) FROM scientists s JOIN assignedto a ON s.ssn = a.scientist JOIN projects p ON a.project = p.code GROUP BY s.name,p.name ORDER BY p.name,s.name;
-- 6.2 Select the project names which are not assigned yet
SELECT p.name FROM projects p LEFT JOIN assignedto a ON p.code = a.project WHERE a.scientist IS NULL;
