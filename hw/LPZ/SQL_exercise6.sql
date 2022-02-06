---*********exercise6**************
SELECT * from projects;
select * from scientists;
SELECT * from assignedto;
-- Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT scientists.name sci_name,projects.name p_name,projects.hours from projects join assignedto on assignedto.project = projects.code join scientists on scientists.ssn = assignedto.scientist;


-- 6.2 Select the project names which are not assigned yet
SELECT name from projects where code  not in (select project from assignedto);