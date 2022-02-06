-- Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT * from package;
SELECT * from shipment;
SELECT * from employee;
SELECT * from has_clearance;
SELECT * from planet;
SELECT * from client;
SELECT name
from client,package
WHERE recipient=accountnumber
AND weight=1.5;
-- 7.2 What is the total weight of all the packages that he sent?
SELECT sum(weight)
from client,package
WHERE recipient=accountnumber
AND sender in(
    SELECT sender
from client,package
WHERE recipient=accountnumber
AND weight=1.5
);