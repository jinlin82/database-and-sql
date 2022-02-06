--**********exercise5********
-- Pieces_and_providers
select* from pieces;
SELECT * from providers;
SELECT * from provides;

-- 5.1 Select the name of all the pieces. 
select name from pieces;

-- 5.2  Select all the providers' data. 
SELECT* from  providers;

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT avg(price),piece from provides group by piece order by piece;

-- 5.4  Obtain the names of all providers who supply piece 1.
select provider from provides where piece = 1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT name from pieces WHERE code in (SELECT piece from provides WHERE provider = 'HAL');

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
select* from pieces;
SELECT * from providers;
SELECT * from provides;

select  Pieces.Name piece_name, Providers.Name provider_name , Price from pieces  JOIN provides on pieces.code = provides.piece JOIN providers on provides.provider = providers.code WHERE price = (SELECT max(price) from provides WHERE provides.piece = pieces.code);

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides(Piece, Provider, Price) VALUES (1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
UPDATE Provides SET Price = Price + 1;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM Provides WHERE provider = 'RBT' AND Piece = 4;

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE FROM provides WHERE Provider = 'RBT';