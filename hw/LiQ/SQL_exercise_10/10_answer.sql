-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT p.*,a.updatedate
FROM people p
LEFT JOIN address a ON p.id = a.id
WHERE a.updatedate >= all(SELECT updatedate FROM address a1 WHERE a.id = a1.id);
-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person.
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT p.*,a.updatedate
FROM people p
LEFT JOIN address a ON p.id = a.id
WHERE a.updatedate >= all(SELECT updatedate FROM address a1 WHERE a.id = a1.id);