-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person).
--     i.e., the joined table should have the same number of rows as table
--     PEOPLE
SELECT * FROM people;
SELECT * FROM address;


SELECT people.id,people.name,address.address from people join address on people.id=address.id WHERE address.address in (SELECT max(address) from address group by address.id);
-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person.
    -- i.e., the joined table should have the same number of rows as table PEOPLE
SELECT people.id,people.name,address.address from people join address on people.id = address.id WHERE address.updatedate in (SELECT max(updatedate) from address group by address.id);