-- Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT  
        s.name AS scientist_name,
        p.name AS project_name,
        p.hours
FROM assignedto a JOIN scientists s ON s.ssn = a.scientist
                  JOIN projects p ON p.code = a.project
ORDER BY p.name,s.name;

-- 6.2 Select the project names which are not assigned yet
SELECT name
FROM projects
EXCEPT
SELECT p.name
FROM assignedto a
JOIN projects p ON p.code = a.project;