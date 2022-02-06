-- Planet_Express
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT * FROM Employee;
SELECT * FROM has_Clearance;
SELECT * FROM shipment;
SELECT * FROM package;
SELECT * FROM client;

SELECT c.name as name_of_rec FROM client c JOIN package p ON p.recipient = c.accountnumber WHERE p.weight = 1.5;
-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(p.weight) FROM package p JOIN client c ON p.sender = c.accountnumber WHERE c.name = 'Al Gore''s Head';

SELECT p.weight,c.name,p.sender FROM package p JOIN client c ON p.sender = c.accountnumber WHERE c.name = 'Al Gore''s Head';