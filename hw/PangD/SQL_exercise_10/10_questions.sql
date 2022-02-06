-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT * FROM address;
SELECT * FROM people;

SELECT p.id,MAX(p.name) AS name,MIN(a.address) AS address FROM address a RIGHT JOIN people p ON a.id = p.id GROUP BY p.id;


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address
-- information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT p.id,MAX(p.name) AS name,MAX(a.address) AS address FROM address a RIGHT JOIN people p ON a.id = p.id GROUP BY p.id;