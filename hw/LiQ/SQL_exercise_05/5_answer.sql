-- Pieces_and_providers
-- 5.1 Select the name of all the pieces.
SELECT name
FROM pieces;

-- 5.2  Select all the providers' data.
SELECT * FROM providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT piece,round(avg(price),2)
FROM provides
GROUP BY piece;

-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT pr.name
FROM provides p
LEFT JOIN providers pr ON p.provider = pr.code
WHERE p.piece = 1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT pi.name
FROM provides p
LEFT JOIN pieces pi ON p.piece = pi.code
WHERE p.provider = 'HAL';

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
SELECT
        pi.name AS price_name,
        pr.name AS provider_name,
        price
FROM provides p JOIN providers pr ON pr.code = p.provider
                JOIN pieces pi ON pi.code = p.piece
WHERE price >= all(select price FROM provides p1 WHERE p.piece = p1.piece);

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides
values(1,'TNBC',7);

-- 5.8 Increase all prices by one cent.
UPDATE provides
SET price = price +1;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
SELECT * FROM provides;
DELETE FROM provides
WHERE piece = 4 AND provider = 'RBT';

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE FROM provides
WHERE provider = 'RBT';