-- *************��һ���� ��ѯ***************
SELECT first_name FROM customer;
/*��ѯcustomer���е�����dd*/

SELECT DISTINCT city FROM city;
/*��ѯcity���еĳ������ƣ������ظ�ֵ��*/

SELECT first_name,last_name FROM customer ORDER BY first_name ASC;
/*��ѯcustomer���е����ֺ����ϣ�����������������*/
SELECT first_name,last_name FROM customer ORDER BY first_name ASC,last_name DESC;
/*��ѯcustomer���е����ֺ����ϣ�����������������,��������ͬʱ�����Ͻ�������*/
SELECT first_name || ' ' || last_name AS full_name FROM customer ORDER BY full_name;
/*����customer���е����ֺ����ϣ��Կո��������������Ϊ"full_name"*/


-- *************�ڶ����� ɸѡ***************
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron';
/*��ѯcustomer��������ΪAaron�����ֺ�����*/
SELECT email FROM customer WHERE store_id != 1;
/*��ѯcustomer����û��ȥ1�ŵ�Ĺ˿͵�����*/
SELECT customer_id,amount,payment_date FROM payment WHERE amount <= 1 OR amount >= 8;
/*��ѯ֧�����Ľ��С��1��Ԫ�����8��Ԫ�Ĺ˿ͱ�ţ�����Լ���������*/
SELECT film_id,title,rental_duration,length FROM film WHERE (rental_duration<>5 AND length <100) OR (rental_duration=5 AND length>100);
/*��ѯ��Ӱ������ʱ��������5���ҵ�Ӱʱ������100��������ʱ������5���ҵ�Ӱʱ������100�ĵ�Ӱ��ź�����*/

SELECT first_name,last_name,email FROM customer WHERE first_name IN ('Alan','Alex');
/*��ѯcustomer��������ΪAlan��Alex�����ֺ����Ϻ�����*/
SELECT customer_id FROM payment WHERE payment_date BETWEEN '2007-02-20' AND '2007-02-21';
/*��ѯpayment���и���������2007-02-20-2007-02-21֮��Ĺ˿ͱ��*/
SELECT district FROM address WHERE district LIKE 'Man%';
/*��ѯaddress������Man��ͷ�Ľ�������*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '%er%';
/*��ѯcustomer�������ֺ���"er"�����ֺ�����*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '_her%';
/*��ѯcustomer������������һ�ַ���ͷ���м�Ϊ"her"�����ֺ�����*/
SELECT first_name,last_name FROM customer WHERE first_name NOT LIKE 'Jen%';
/*��ѯcustomer�������ֲ���"Jen"��ͷ�����ֺ�����*/
SELECT first_name,last_name FROM customer WHERE first_name ILIKE 'BAR%';
/*��ѯcustomer����������"BAR"����"Bar"���ߡ�BaR"��ͷ�����ֺ����ϣ�ILIKE����������ִ�Сд��ֵ��*/

SELECT address_id,phone FROM address WHERE phone IS NULL;
/*��ѯaddress���е绰���벻Ϊ�յĽ�������*/

SELECT film_id,title,release_year FROM film ORDER BY film_id LIMIT 5;
/*��ѯfilm���а����������ǰ�岿��Ӱ*/
SELECT film_id,title,release_year FROM film ORDER BY film_id LIMIT 4 OFFSET 3;
/*��ѯfilm���дӵ�3��֮�󣨼���4�У���ʼ��4������*/

SELECT film_id,title FROM film ORDER BY title FETCH FIRST 5 ROW ONLY;
/*��ѯfilm���а����������ǰ�岿��Ӱ*/
SELECT film_id,title FROM film ORDER BY title OFFSET 3 ROWS FETCH FIRST 4 ROW ONLY; ;
/*��ѯfilm���дӵ�3��֮�󣨼���4�У���ʼ��4������*/


-- *************�������� ����***************
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a INNER JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2;
/*��ѯ�ͻ�ID 2�Ŀͻ��������ݣ����������ӣ�*/
SELECT a.customer_id,a.first_name customer_first_name,a.last_name customer_last_name,a.email,b.first_name staff_first_name,b.last_name staff_last_name,c.amount,c.payment_date
FROM payment c INNER JOIN customer a ON c.customer_id = a.customer_id
               INNER JOIN staff b ON c.staff_id = b.staff_id
WHERE a.customer_id = 2;
/*��ѯ�ͻ�ID 2�Ŀͻ��������ݣ����������ӣ�*/

SELECT a.film_id,a.title,b.inventory_id
FROM film a LEFT JOIN inventory b ON a.film_id = b.film_id;
/*film���е�ĳЩ���ڱ���û�ж�Ӧ����inventory����˿��ID��ֵΪNULL����ȡ�������������ӣ���filmΪ����*/
SELECT a.film_id,a.title,b.inventory_id
FROM film a LEFT JOIN inventory b ON a.film_id = b.film_id
WHERE b.film_id IS NULL;
/*film���е�ĳЩ���ڱ���û�ж�Ӧ����inventory����˿��ID��ֵΪNULL����ȡ�����������ӣ���filmΪ����*/

SELECT a.title,b.title,a.length
FROM film a INNER JOIN film b ON a.film_id <> b.film_id
AND a.length = b.length;
/*���Ҿ�����ͬ���ȵ����е�Ӱ�ԣ������ӣ�
�����Ӷ��ڱȽ�ͬһ���е�һ�����е�ֵ�����á�
Ҫ�γ������ӣ���ʹ�ò�ͬ�ı���ָ��ͬһ�������Σ����ñȽϣ�������ֵ��������������*/

SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2;
/*��ѯ�ͻ�ID 2�Ŀͻ��������ݣ����������ӣ�*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id 
WHERE a.customer_id = 2 AND (a.customer_id IS NULL OR b.customer_id IS NULL);
/*��ѯ�ͻ�ID 2�Ŀͻ��������ݣ���ȫ������,,������a,b�Ľ������֣�*/

CREATE TABLE T1 (label CHAR(1) PRIMARY KEY);
CREATE TABLE T2 (score INT PRIMARY KEY);
INSERT INTO T1 (label) VALUES ('A'),('B');
INSERT INTO T2 (score) VALUES (1),(2),(3);
SELECT * FROM T1 CROSS JOIN T2;
/*�ѿ��������������ӣ�2���Ӧ��ϣ�*/
SELECT * FROM T1, T2;
/*��ͬ��������ʽ*/


-- *************���Ĳ��� ����***************
SELECT customer_id,SUM (amount) FROM payment GROUP BY customer_id ORDER BY SUM (amount) DESC;
/*���˿ͱ�ŷ��飬�����ܽ������ܽ�������*/
SELECT customer_id,SUM (amount) FROM payment GROUP BY customer_id HAVING SUM (amount) > 200;
/*���˿ͱ�ŷ���,��ѯ�ܽ���200�Ĺ˿ͱ��*/


-- *************���岿�� ����***************
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron'
UNION
SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';
/*������UNION ALL�����ظ�ֵ��*/

SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron'
INTERSECT
SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';
/*����*/

SELECT film_id,title FROM film
EXCEPT
SELECT DISTINCT inventory.film_id,title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id
ORDER BY title;
/*�����ѯ���ڿ���е�ӰƬ��*/


-- *************�������� �Ӳ�ѯ*************
SELECT film,title,rental_rate FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) LIMIT 3;
/*��������ʸ���ƽ������ʵ�ǰ3����Ӱ*/

SELECT MAX(length) FROM film INNER JOIN film_category USING(film_id) GROUP BY category_id;
/*��ѯ����Ӱ����������е�Ӱ����󳤶�
��СֵΪ178*/
SELECT title,length FROM film 
WHERE length >= ANY(SELECT MAX(length) FROM film INNER JOIN film_category USING(film_id) GROUP BY category_id);
/*����ÿ����Ӱ����Ӳ�ѯ�ҵ���󳤶ȡ��ⲿ��ѯ�鿴������Щֵ��ȷ���ĸ���Ƭ�ĳ��ȴ��ڻ�����κν�Ƭ������󳤶ȡ�
ANY��ʾ���κ�һ������ͷ���TRUE����ʱ����178����
'SOME'�൱��'ANY'
'= ANY'�൱��'IN','<> ANY'��ͬ��'NOT IN'
USING�÷���ON table1.column_name = table2.column_name �ȼ��� USING(column_name)*/

SELECT ROUND(AVG (length),2) FROM film GROUP BY rating;
/*��ѯ����Ӱ������������е�Ӱ��ƽ������
���ֵΪ120.44*/
SELECT film_id,title,length FROM film
WHERE length > ALL (SELECT ROUND(AVG (length),2) FROM film GROUP BY rating)
ORDER BY length;
/*��ѯ�������г��ȴ����Ӳ�ѯ���ص�ƽ�������б������ֵ��ӰƬ
ALL��ʾȫ��������ŷ���TRUE,������ƽ�����ȵ����ֵ120.44�ſ�*/

SELECT first_name,last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id AND amount > 11 )
ORDER BY first_name,last_name;
/*����������һ�ʽ�����11�ĸ���Ŀͻ�
EXISTS������������Ӳ�ѯ���Ƿ������*/


-- *************���߲��� �޸�����*************
INSERT INTO table (column1, column2, ��)
VALUES (value1, value2, ��),(value1, value2, ��) ,...;
/*һ���������Ӷ���*/
INSERT INTO table(column1,column2,...)
SELECT column1,column2,..FROM another_table WHERE condition;
/*����������һ���������*/

UPDATE table
SET column1 = value1,column2 = value2 ,...
WHERE condition;
/*���ı����е�ֵ*/
UPDATE A
SET A.c1 = expresion FROM B WHERE A.c2 = B.c2;
/*������һ�����е�ֵ���±������*/

DELETE FROM table
WHERE condition;
/*�ӱ���ɾ������*/
DELETE FROM table
WHERE table.id = (SELECT id FROM another_table);
/*���������һ�����е�һ�������е�������ɾ������*/


-- *************�ڰ˲��� �����*************
CREATE TABLE role(
 role_id serial PRIMARY KEY,
 role_name VARCHAR (255) UNIQUE NOT NULL
);
/*������*/

SELECT film_id,title,rental_rate
INTO TABLE film_r
FROM film
WHERE rating = 'R' AND rental_duration = 5
ORDER BY title;
/*��film�Ļ����ϴ���һ����Ϊ���±�film_r�����а���R����film���5������������ڵ����е�Ӱ*/
SELECT * FROM film_r;
/*��֤��*/

ALTER TABLE table_name ADD COLUMN new_column_name TYPE;
/*������������*/
ALTER TABLE table_name DROP COLUMN column_name;
/*ɾ��������*/
ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
/*������������*/
ALTER TABLE assets ALTER COLUMN name TYPE VARCHAR;
/*��assets����name�е��������͸���ΪVARCHAR*/
ALTER TABLE table_name RENAME TO new_table_name;
/*��������*/
DROP TABLE IF EXISTS table_name;
/*ɾ����*/
CREATE TEMP TABLE temp_table(
   ...
);
/*������ʱ��*/
TRUNCATE TABLE table_name;
/*ɾ��������������*/


-- *************�ھŲ��� Լ��*************
CREATE TABLE TABLE (
 column_1 data_type PRIMARY KEY,
 column_2 data_type,
 ��
);
/*����Լ����ʽһ��������ʱ��������*/
CREATE TABLE TABLE (
 column_1 data_type,
 column_2 data_type,
 �� 
PRIMARY KEY (column_1, column_2)
);
/*����Լ����ʽ����������������л���������*/
ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);
/*����Լ����ʽ�����������б�ṹʱ��������*/
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;
/*ɾ������*/

CREATE TABLE person (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 email VARCHAR (50) UNIQUE
);
/*UNIQUEԼ����ʽһ�����UNIQUEԼ����ȷ���洢���л������е�ֵ������������Ψһ*/
CREATE TABLE table (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);
/*UNIQUEԼ����ʽ������c2��c3�е�ֵ���������������Ψһ�ġ���c2��c3��ֵ������Ψһ��*/

CREATE TABLE invoice(
  id serial PRIMARY KEY,
  product_id int NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);
/*NOT NULLԼ����ʽһ���ڴ����±�ʱ����PostgreSQL�ǿ�Լ����ӵ���*/
ALTER  TABLE table_name
ALTER COLUMN column_name SET NOT NULL;
/*NOT NULLԼ����ʽ������PostgreSQL�ǿ�Լ����ӵ����б����*/

CREATE TABLE employees (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 birth_date DATE CHECK (birth_date > '1900-01-01'),
 joined_date DATE CHECK (joined_date > birth_date),
 salary numeric CHECK(salary > 0)
);
/*CHECKԼ������Լ�����ݲ������ʽԼ�������е�ֵ
һ��CHECKԼ����һ��Լ����ʹ������ָ���Ƿ������е�ֵ���������ض���Ҫ�󡣵�CHECKԼ��ʹ�ò������ʽ�������µ���֮ǰ����ֵ�����ֵͨ����飬PostgreSQL�������в���������Щֵ��
���ȣ�birth_dateԱ���ĳ������ڣ����������01/01/1900�������֮ǰ���Բ����������01/01/1900�������յ�һ��������Ϣ��
��Σ��������ڣ�joined_date��������ڳ������ڣ�birth_date�����˼�齫��ֹ���������庬�������Ч���ڡ�
������нˮ���������*/


-- *************��ʮ���� �������ʽ�������*************
SELECT SUM (CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END ) AS "Mass",
 SUM ( CASE WHEN rental_rate = 2.99 THEN 1 ELSE 0 END ) AS "Economic",
 SUM ( CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END ) AS "Luxury"
FROM film;
/*Ϊ��Ӱ����۸�Σ���������Ϊ0.99����Ϊ��ͨ������������1.99����Ϊ���ã������������4.99����Ϊ����*/

SELECT COALESCE (NULL, 2 , 1);
/*�����Ҽ��������ֱ���ҵ���һ����null����*/

SELECT CAST ('100' AS INTEGER);
/*���ַ�������ת��Ϊ����*/


-- *************��ʮһ���� ϰ��*************
/*1.�����к��С�oo������Ա���ݵĵ�Ӱ����������������
Al Garland���ݵĵ�Ӱ������������һ�죬
�����ա�Garland������Ա���ݵĵ�Ӱ�������ڼ����죬
չʾ������Ա�����֣���ȥ�������ں͵�ǰ���µ�������
������ڰ��µ������ڲ�֪����SELECT�����*/
SELECT c.last_name,b.rental_duration AS old_rental_duration,
(CASE WHEN last_name LIKE '%oo%' THEN b.rental_duration+3
     WHEN last_name = 'AI' AND first_name ='Garland' THEN b.rental_duration+1
     WHEN first_name ='Garland' AND last_name != 'AI' THEN b.rental_duration-2
     ELSE b.rental_duration 
     END ) AS new_rental_duration
FROM film_actor a INNER JOIN film b ON a.film_id=b.film_id
                  INNER JOIN actor c ON a.actor_id=c.actor_id 
WHERE c.last_name like '%oo%' or c.last_name='Garland';

/*2.չʾ����ʱ��Ϊ115���ӵ�125���ӵĵ�Ӱ���Ƽ�ʱ��,
��������ʱ������,��ͬʱ���ĵ�Ӱ���������򣬵�A��ͷ
�������к���c����һ����ĸ��r�ĵ�Ӱ����������У���
������Ϊ��һ���������������һ����*/
SELECT title,length FROM film
WHERE length BETWEEN 115 AND 125
/*ORDER BY CASE WHEN title LIKE 'A%' OR '%c_r%' THEN 1 ELSE 0 asc,length,title;
CASE WHEN һ������SELECT*/
/*ORDER BY title IN(SELECT title FROM film WHERE title LIKE 'A%' OR '%c_r%'),length,title;
����LIKE����ֱ����OR����*/
ORDER BY title IN(SELECT title FROM film WHERE title LIKE 'A%' OR title LIKE '%c_r%'),length,title;

/*3.չʾ��ͬ��������ĵ�Ӱ������������С�����˳������*/
SELECT language_id,COUNT(film_id)
FROM film
GROUP BY language_id
ORDER BY COUNT(film_id) asc;

/*4.չʾӢ�����Ӱ�ĵ�Ӱ���ͼ���Ӧ��Ŀ*/
SELECT language_id,COUNT(film_id)
FROM film
WHERE film.language_id='1'
GROUP BY language_id;

/*5.չʾ��֧����Ϊ��ÿ�����е�֧������*/
SELECT SUM(CASE WHEN a.amount>0 THEN 1 ELSE 0 END),d.city,e.country
FROM payment a JOIN staff b ON a.staff_id=b.staff_id
JOIN address c ON b.address_id=c.address_id
JOIN city d ON c.city_id=d.city_id
JOIN country e ON d.country_id=e.country_id
GROUP BY e.country,d.city;

/*6.�ҳ�ÿ�����Ұ���ĸ��������ĩλ�ĳ�������ߵ�֧�����*/
SELECT MAX(a.amount),d.city,e.country
FROM payment a JOIN staff b ON a.staff_id=b.staff_id
JOIN address c ON b.address_id=c.address_id
JOIN city d ON c.city_id=d.city_id
JOIN country e ON d.country_id=e.country_id
WHERE city<=ALL(SELECT city FROM country f WHERE e.country=f.country)
/*e.country=f.countryΪ��ȷ����ͬһ�����ڱȽ�*/
GROUP BY e.country,d.city;
