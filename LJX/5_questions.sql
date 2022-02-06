-- Pieces_and_providers
-- 5.1 Select the name of all the pieces.
Select name from pieces;
SELECT * from pieces;
-- 5.2  Select all the providers' data.
SELECT * FROM providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT avg(price) from provides GROUP BY piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT name FROM providers WHERE code in (SELECT provider FROM provides WHERE piece =1);
-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT name FROM pieces WHERE code in (SELECT piece FROM provides WHERE provider ='HAL');
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- 先选最大的价格，然后就是把三个表连接起来，之后再用where筛选piece、price筛选记录行
-- ---------------------------------------------
SELECT piece,max(price) as max_price FROM provides GROUP BY piece;
SELECT * FROM provides AS a LEFT JOIN pieces AS b ON a.piece=b.code;
-------连续用了几个左外连接
SELECT e.price,e.piece_name,e.provider_name FROM (SELECT piece,max(price) as max_price FROM provides GROUP BY piece) AS f LEFT JOIN (SELECT d.name AS provider_name,c.name AS piece_name,c.price,c.piece FROM (SELECT * FROM provides AS a LEFT JOIN pieces AS b ON a.piece=b.code) as c LEFT JOIN providers AS d on c.provider=d.code) AS e ON f.piece=e.piece AND f.max_price=e.price;
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'TNBC',7);
-- 5.8 Increase all prices by one cent.
UPDATE provides SET price=price+1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
SELECT * from provides;
DELETE FROM provides WHERE piece=4 AND provider='RBT';
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE FROM provides WHERE provider='RBT';