-- LINK: The_computer_store
-- 1.1 Select the names of all the products in the store.
Select name from Products;
-- 1.2 Select the names and the prices of all the products in the store.
Select name,price from Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
Select name,price from Products WHERE price <=200;
-- 1.4 Select all the products with a price between $60 and $120.
Select * from Products WHERE price BETWEEN 60 AND 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by
-- 100).
Select name,price*100 as price_cents from Products;

-- 1.6 Compute the average price of all the products.
SELECT avg(price) FROM products;

SELECT * from products;
-- 1.7 Compute the average price of all products with manufacturer code equal to
-- 2.
SELECT avg(price) FROM products WHERE manufacturer =2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(*) from products WHERE price>=180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
Select name,price from Products WHERE price>=180 order by price DESC,name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM products a LEFT JOIN manufacturers b ON a.manufacturer=b.code;
-- 1.11 Select the product name, price, and manufacturer name of all the
-- products.
SELECT a.name as produce_name,a.price,b.name as manufacturer_name FROM products a LEFT JOIN manufacturers b ON a.manufacturer=b.code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT avg(price),manufacturer from products GROUP BY manufacturer order by manufacturer;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT avg(a.price),b.name as manufacturer_name from products a LEFT JOIN manufacturers b ON a.manufacturer=b.code GROUP BY b.name;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT avg(a.price),b.name as manufacturer_name from products a LEFT JOIN manufacturers b ON a.manufacturer=b.code GROUP BY b.name HAVING avg(a.price)>=150;
-- 1.15 Select the name and price of the cheapest product.
SELECT * from products WHERE price in (select min(price) from products);
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT max(a.price),b.name as manufacturer_name from products a LEFT JOIN manufacturers b ON a.manufacturer=b.code GROUP BY b.name;

SELECT a.price,a.name,b.manufacturer from products a LEFT JOIN max_1 b ON a.price=b.max AND a.manufacturer=b.manufacturer;


SELECT max(price),manufacturer INTO max_1 from products GROUP BY manufacturer;
SELECT * from max_1;
SELECT * from products;
SELECT name,price,manufacturer from products a WHERE a.price in (SELECT max(price) from products GROUP BY manufacturer);


SELECT a.price,a.name,b.manufacturer FROM products a INNER JOIN (SELECT max(price) from products GROUP BY manufacturer) ON a.film_id <> b.film_id
AND a.length = b.length;


SELECT name,price,manufacturer from products a WHERE a.price = (SELECT max(price) from products GROUP BY manufacturer) and a.manufacturer in (SELECT max(price),manufacturer from products GROUP BY manufacturer);

SELECT * from products a LEFT JOIN manufacturers b ON a.manufacturer=b.code GROUP BY b.name;

SELECT products.name,max(price) as max_price,manufacturers.name FROM products LEFT JOIN manufacturers ON products.manufacturer=manufacturers.code GROUP BY products.manufacturer ORDER BY max_price DESC;
s
SELECT * from products;
SELECT * from manufacturers;
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(11,'Loudspeakers',70,2);
-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products SET name = 'Laser Printer' WHERE code =8;
-- 1.19 Apply a 10% discount to all products.
SELECT 0.9*price from 
-- 1.20 Apply a 10% discount to all products with a price larger than or equal
-- to $120.
UPDATE products SET price=price*0.9 WHERE price >=120;
