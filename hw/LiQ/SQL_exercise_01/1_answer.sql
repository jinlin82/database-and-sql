-- 1.1 Select the names of all the products in the store.
SELECT name
FROM Products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name,price 
FROM products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name 
FROM products 
WHERE price <=200;

-- 1.4 Select all the products with a price between $60 and $120.
SELECT * 
FROM products 
WHERE price BETWEEN 60 AND 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name,price,price *100 AS new_price
FROM products;

-- 1.6 Compute the average price of all the products.
SELECT round(avg(price),2)
FROM products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT round(avg(price),2)
FROM products
WHERE manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(code)
FROM products
WHERE price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name,price
FROM products
WHERE price >= 180 
ORDER BY price desc,name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT p.*,m.name AS manu_name
FROM products p
JOIN manufacturers m ON p.manufacturer = m.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT p.name,p.price,m.name AS manu_name
FROM products p
JOIN manufacturers m ON p.manufacturer = m.code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT manufacturer,round(avg(price),2)
FROM products
GROUP BY manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT m.name,round(avg(price),2)
FROM products p
JOIN manufacturers m ON p.manufacturer = m.code
GROUP BY m.name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT m.name,round(avg(price),2)
FROM products p
JOIN manufacturers m ON p.manufacturer = m.code
GROUP BY m.name
HAVING avg(price)>150;

-- 1.15 Select the name and price of the cheapest product.
SELECT name,price
FROM products p1
WHERE price <= all(select price FROM products p2);

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT 
        m.name AS manufacturer_name,
        p1.name AS product_name,
        p1.price
FROM products p1
JOIN manufacturers m
    ON p1.manufacturer = m.code
WHERE price >= all(select price FROM products p2 
                    WHERE p1.manufacturer = p2.manufacturer);

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products
VALUES (11,'Loudspeakers',70,2);

SELECT * FROM products;

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products
SET name = 'Laser Printer'
WHERE code = 8;

-- 1.19 Apply a 10% discount to all products.
SELECT name,price*0.9 AS discount_price
FROM products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
SELECT 
        name,
        CASE when price>120 then price*0.9 else price end
FROM products

