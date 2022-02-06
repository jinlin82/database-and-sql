-- Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT c.name,p.*
FROM package p
JOIN client c ON p.recipient = c.accountnumber
WHERE p.weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?
SELECT c.name,sum(weight)
FROM package p
JOIN client c ON p.sender = c.accountnumber
GROUP BY c.name
HAVING c.name = 'Al Gores Head';
