-- LINK: The_computer_store
-- 1.1 Select the names of all the products in the store.
Select * from products;

SELECT name from products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name,price FROM products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name
FROM products
WHERE price<=200;
-- 1.4 Select all the products with a price between $60 and $120.
SELECT *
FROM products
WHERE price BETWEEN 60 and 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by-- 100).
SELECT name,price*100 as price_cents
FROM products;
-- 1.6 Compute the average price of all the products.
SELECT avg(price)
FROM products;
-- 1.7 Compute the average price of all products with manufacturer code equal to
-- 2.
SELECT avg(price)
FROM products
WHERE manufacturer=2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(price)
FROM products
WHERE price>=180;
-- 1.9 Select the name and price of all products with a price larger than or
-- equal to $180, and sort first by price (in descending order), and then by
-- name (in ascending order).
SELECT name,price
FROM products
WHERE price >=180
ORDER by price DESC ,name;
-- 1.10 Select all the data from the products, including all the data for each
-- product's manufacturer.
SELECT *
FROM products,manufacturers
WHERE products.manufacturer=manufacturers.code;
-- 1.11 Select the product name, price, and manufacturer name of all the
-- products.
SELECT products.name,price,manufacturers.name as manufacturer_name
FROM products,manufacturers
WHERE products.manufacturer=manufacturers.code;
-- 1.12 Select the average price of each manufacturer's products, showing only
-- the manufacturer's code.
SELECT avg(price),manufacturer
FROM products
group by manufacturer;
-- 1.13 Select the average price of each manufacturer's products, showing the
-- manufacturer's name.
SELECT avg,name
FROM manufacturers,
(SELECT avg(price),manufacturer
FROM products
group by manufacturer)as new
WHERE new.manufacturer=manufacturers.code;
-- 1.14 Select the names of manufacturer whose products have an average price
-- larger than or equal to $150.
SELECT name
FROM
(SELECT avg,name
FROM manufacturers,
(SELECT avg(price),manufacturer
FROM products
group by manufacturer)as new
WHERE new.manufacturer=manufacturers.code)as new1
WHERE new1.avg>=150
;
-- 1.15 Select the name and price of the cheapest product.
SELECT name,price
FROM products,(
    SELECT min(price)
    FROM products
)as new
WHERE price=new.min;
-- 1.16 Select the name of each manufacturer along with the name and price of
-- its most expensive product.
SELECT name,price
FROM products,(
    SELECT max(price)
    FROM products
)as new
WHERE price=new.max;
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products(name,price,manufacturer,code)
VALUES('Loudspeakers',70,2,999);
-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products
set name= 'Laser Printer'
WHERE code=8;
-- 1.19 Apply a 10% discount to all products.
SELECT * from products;
UPDATE products
set price=0.9*price;
SELECT * from products;
-- 1.20 Apply a 10% discount to all products with a price larger than or equal
-- to $120.
SELECT * from products;
UPDATE products
set price=0.9*price
WHERE price>=120;
SELECT * from products;