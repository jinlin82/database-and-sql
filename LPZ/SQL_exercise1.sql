--********exercise1*********

-- LINK: The_computer_store
-- 1.1 Select the names of all the products in the store.
SELECT Name FROM Products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT Name,Price FROM products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT Name,Price FROM products 
WHERE Price <=200;

-- 1.4 Select all the products with a price between $60 and $120.
SELECT Name,price From products
WHERE price BETWEEN 60 AND 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by
-- 100).
SELECT name,price*100 AS price_cents FROM products;

-- 1.6 Compute the average price of all the products.
SELECT avg(price) FROM products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT avg(price) FROM products
WHERE manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(price) FROM products
WHERE price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name,price FROM products
WHERE price>=180
ORDER BY price DESC,name;


-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT a.*,b.name m_name FROM products AS a,manufacturers AS b
WHERE a.manufacturer = b.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT a.name,a.price,b.name FROM products AS a,manufacturers AS b
WHERE a.manufacturer = b.code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT manufacturer,avg(price) from products GROUP BY manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT avg(a.price),b.name FROM products AS a,manufacturers AS b WHERE a.manufacturer = b.code group by b.name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT avg(a.price),b.name FROM products AS a,manufacturers AS b WHERE a.manufacturer = b.code group by b.name HAVING avg(a.price)>=150;

-- 1.15 Select the name and price of the cheapest product.
SELECT name,price from products where price = (SELECT min(price) from products);

SELECT name,price from products order by price LIMIT 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select e.max,e.name p_name,e.m_name from 
((SELECT max(a.price),b.name m_name from manufacturers b,products a WHERE a.manufacturer = b.code GROUP BY b.name)
as c LEFT JOIN
(SELECT a.*,b.name m_name1 FROM products AS a,manufacturers AS b WHERE a.manufacturer = b.code) 
as d
on (c.max = d.price and c.m_name = d.m_name1)) as e;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT into products VALUES(11,'Loudspeakers',70,2);
select * from products;

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products set name = 'Laser Printer' where code = 8;
select * from products;

-- 1.19 Apply a 10% discount to all products.
UPDATE products set price = price*0.9;
select * from products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products set price = price*0.9 WHERE price >=120;
select * from products;