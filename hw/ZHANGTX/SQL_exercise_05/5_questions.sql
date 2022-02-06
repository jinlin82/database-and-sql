-- Pieces_and_providers

-- 5.1 Select the name of all the pieces. 
SELECT name from pieces;
-- 5.2  Select all the providers' data. 
SELECT * from providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the
-- average price).


SELECT piece,avg(price)
from provides
group by piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT name from providers
WHERE providers.code in(
SELECT provider
from provides
WHERE piece =1);
-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT * from providers;
SELECT * from provides;
SELECT * from pieces;

SELECT name from pieces
WHERE code in (
SELECT piece FROM provides WHERE provider='HAL');
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
SELECT * from providers;
SELECT * from provides;
SELECT * from pieces;

SELECT proname,piecename,price,max from(
SELECT pieces.code,providers.name as proname,pieces.name as piecename,price
from providers,provides,pieces
WHERE providers.code=provides.provider
AND pieces.code=provides.piece)as new1
,(
SELECT piece, max(price)
from provides
group by piece
)as new2
WHERE new1.code=new2.piece;

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies"
-- (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides(piece,provider,price)
VALUES(1,'TNBC',7);
-- 5.8 Increase all prices by one cent.
UPDATE provides
set price=price+1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT")
-- will not supply bolts (code 4).
SELECT * from providers;
SELECT * from provides;
SELECT * from pieces;

DELETE from provides
WHERE piece=4 AND provider='RBT';
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE from provides
WHERE provider='RBT';

