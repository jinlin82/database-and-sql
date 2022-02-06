-- Pieces_and_providers
-- 5.1 Select the name of all the pieces.
SELECT * FROM pieces;
SELECT * FROM provides;
SELECT name FROM pieces;
-- 5.2  Select all the providers' data.
SELECT * FROM providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT pr.piece,AVG(price) FROM pieces p JOIN provides pr ON p.code = pr.piece GROUP BY pr.piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT provider FROM provides WHERE piece = 1;
-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT p.name FROM pieces p JOIN provides pr ON p.code = pr.piece WHERE pr.provider = 'HAL';
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price

SELECT ps.piece,p.name,pr.name,ps.price FROM pieces p JOIN provides ps ON p.code = ps.piece JOIN providers pr ON ps.provider = pr.code WHERE (ps.piece,ps.price) IN (SELECT ps.piece,MAX(ps.price) FROM pieces p JOIN provides ps ON p.code = ps.piece JOIN providers pr ON ps.provider = pr.code GROUP BY ps.piece);

SELECT ps.piece,MAX(ps.price) FROM pieces p JOIN provides ps ON p.code = ps.piece JOIN providers pr ON ps.provider = pr.code GROUP BY ps.piece;
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides
VALUES(1,'TNBC',7);
SELECT * FROM provides;
-- 5.8 Increase all prices by one cent.
UPDATE provides
SET price = price+1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM provides WHERE piece = 4 AND provider = 'RBT';
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
    -- (the provider should still remain in the database).
DELETE FROM provides WHERE provider = 'RBT';
SELECT * FROM providers;