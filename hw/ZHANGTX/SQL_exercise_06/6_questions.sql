-- Scientists

-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT * from scientists;
SELECT * from assignedto;
SELECT * from projects;

SELECT scientists.name as scientistsname,projects.name as proname,hours from scientists,assignedto,projects
WHERE scientists.ssn=assignedto.scientist
and projects.code=assignedto.project
order by proname,scientistsname;
-- 6.2 Select the project names which are not assigned yet
SELECT name
from projects
left OUTER JOIN assignedto
on assignedto.project=projects.code
WHERE project is null;

