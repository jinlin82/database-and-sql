-- LINK: The_computer_store
-- 1.1 Select the names of all the products in the store.
SELECT Name FROM Products;
-- 1.2 Select the names and the prices of all the products in the store.
SELECT Name,Price FROM Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT Name FROM Products WHERE Price<=200;
-- 1.4 Select all the products with a price between $60 and $120.
SELECT * FROM Products WHERE Price BETWEEN 60 AND 200;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by
-- 100).
SELECT Name,Price*100 AS Prici_in_cents FROM Products;
-- 1.6 Compute the average price of all the products.
SELECT AVG(Price) FROM Products;
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT * FROM Products;
SELECT AVG(Price) FROM Products WHERE manufacturer=2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(code) FROM Products WHERE Price >= 180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name,Price FROM Products WHERE Price >= 180 ORDER BY Price DESC,Name ASC;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM manufacturers;
SELECT * FROM Products p JOIN manufacturers m ON p.manufacturer = m.code;
-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT p.Name AS product_name,p.Price,m.name AS manu_name FROM Products p JOIN manufacturers m ON p.manufacturer = m.code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT m.code,avg(p.Price) FROM Products p JOIN manufacturers m ON p.manufacturer = m.code GROUP BY m.code;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT m.name,avg(p.Price) FROM Products p JOIN manufacturers m ON p.manufacturer = m.code GROUP BY m.code;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT m.name,AVG(p.Price) FROM Products p JOIN manufacturers m ON p.manufacturer = m.code GROUP BY m.code HAVING AVG(p.Price)>=150;
-- 1.15 Select the name and price of the cheapest product.
SELECT Name,Price FROM Products WHERE Price <= ALL(SELECT Price FROM products);
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT m.name,MAX(p.price) FROM products p JOIN manufacturers m ON p.manufacturer = m.code GROUP BY m.code;
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
SELECT * FROM products;
INSERT INTO Products  VALUES (11,'Loudspeakers',70,2);
-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET name = 'LaserPrinter'
WHERE code = 8;
SELECT * FROM products;
-- 1.19 Apply a 10% discount to all products.
UPDATE products
SET Price = Price*0.9;
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products
SET Price = price*0.9
WHERE price>=120;
