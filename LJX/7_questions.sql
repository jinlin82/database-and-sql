-- Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".


SELECT b.Name FROM Package a LEFT JOIN Client b ON a.Recipient = b.AccountNumber WHERE Weight = 1.5;

-- 7.2 What is the total weight of all the packages that he sent?

SELECT sum(Weight) FROM Package a LEFT JOIN Client b ON a.Sender = b.AccountNumber WHERE a.Sender = 2;
