--*********exercise7********
-- Planet_Express 
SELECT*from client;
SELECT*from shipment;
SELECT*from employee;
SELECT*from package;
SELECT*from has_clearance;

-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT client.name from client join package on client.accountnumber = package.recipient WHERE package.weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(p.weight) 
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.Name = 'Al Gores Head';