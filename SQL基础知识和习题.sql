-- *************第一部分 查询***************
SELECT first_name FROM customer;
/*查询customer表中的名字dd*/

SELECT DISTINCT city FROM city;
/*查询city表中的城市名称（过滤重复值）*/

SELECT first_name,last_name FROM customer ORDER BY first_name ASC;
/*查询customer表中的名字和姓氏，按照名字升序排列*/
SELECT first_name,last_name FROM customer ORDER BY first_name ASC,last_name DESC;
/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/
SELECT first_name || ' ' || last_name AS full_name FROM customer ORDER BY full_name;
/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/


-- *************第二部分 筛选***************
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron';
/*查询customer表中名字为Aaron的名字和姓氏*/
SELECT email FROM customer WHERE store_id != 1;
/*查询customer表中没有去1号店的顾客的邮箱*/
SELECT customer_id,amount,payment_date FROM payment WHERE amount <= 1 OR amount >= 8;
/*查询支付租金的金额小于1美元或大于8美元的顾客编号，金额以及付款日期*/
SELECT film_id,title,rental_duration,length FROM film WHERE (rental_duration<>5 AND length <100) OR (rental_duration=5 AND length>100);
/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于100的电影编号和名称*/

SELECT first_name,last_name,email FROM customer WHERE first_name IN ('Alan','Alex');
/*查询customer表中名字为Alan或Alex的名字和姓氏和邮箱*/
SELECT customer_id FROM payment WHERE payment_date BETWEEN '2007-02-20' AND '2007-02-21';
/*查询payment表中付款日期在2007-02-20-2007-02-21之间的顾客编号*/
SELECT district FROM address WHERE district LIKE 'Man%';
/*查询address表中以Man开头的街区名称*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '%er%';
/*查询customer表中名字含有"er"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '_her%';
/*查询customer表中名字以任一字符开头，中间为"her"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name NOT LIKE 'Jen%';
/*查询customer表中名字不以"Jen"开头的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name ILIKE 'BAR%';
/*查询customer表中名字以"BAR"或者"Bar"或者“BaR"开头的名字和姓氏（ILIKE运算符不区分大小写的值）*/

SELECT address_id,phone FROM address WHERE phone IS NULL;
/*查询address表中电话号码不为空的街区名称*/

SELECT film_id,title,release_year FROM film ORDER BY film_id LIMIT 5;
/*查询film表中按标题排序的前五部电影*/
SELECT film_id,title,release_year FROM film ORDER BY film_id LIMIT 4 OFFSET 3;
/*查询film表中从第3行之后（即第4行）开始的4行数据*/

SELECT film_id,title FROM film ORDER BY title FETCH FIRST 5 ROW ONLY;
/*查询film表中按标题排序的前五部电影*/
SELECT film_id,title FROM film ORDER BY title OFFSET 3 ROWS FETCH FIRST 4 ROW ONLY; ;
/*查询film表中从第3行之后（即第4行）开始的4行数据*/


-- *************第三部分 连接***************
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a INNER JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2;
/*查询客户ID 2的客户租赁数据（两表内连接）*/
SELECT a.customer_id,a.first_name customer_first_name,a.last_name customer_last_name,a.email,b.first_name staff_first_name,b.last_name staff_last_name,c.amount,c.payment_date
FROM payment c INNER JOIN customer a ON c.customer_id = a.customer_id
               INNER JOIN staff b ON c.staff_id = b.staff_id
WHERE a.customer_id = 2;
/*查询客户ID 2的客户租赁数据（三表内连接）*/

SELECT a.film_id,a.title,b.inventory_id
FROM film a LEFT JOIN inventory b ON a.film_id = b.film_id;
/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左外连接，以film为主表*/
SELECT a.film_id,a.title,b.inventory_id
FROM film a LEFT JOIN inventory b ON a.film_id = b.film_id
WHERE b.film_id IS NULL;
/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左连接，以film为主表*/

SELECT a.title,b.title,a.length
FROM film a INNER JOIN film b ON a.film_id <> b.film_id
AND a.length = b.length;
/*查找具有相同长度的所有电影对（自连接）
自联接对于比较同一表中的一列行中的值很有用。
要形成自连接，请使用不同的别名指定同一个表两次，设置比较，并消除值等于自身的情况。*/

SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2;
/*查询客户ID 2的客户租赁数据（完整外连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id 
WHERE a.customer_id = 2 AND (a.customer_id IS NULL OR b.customer_id IS NULL);
/*查询客户ID 2的客户租赁数据（完全外连接,,不包括a,b的交集部分）*/

CREATE TABLE T1 (label CHAR(1) PRIMARY KEY);
CREATE TABLE T2 (score INT PRIMARY KEY);
INSERT INTO T1 (label) VALUES ('A'),('B');
INSERT INTO T2 (score) VALUES (1),(2),(3);
SELECT * FROM T1 CROSS JOIN T2;
/*笛卡尔积（交叉连接，2表对应组合）*/
SELECT * FROM T1, T2;
/*等同于以上形式*/


-- *************第四部分 分组***************
SELECT customer_id,SUM (amount) FROM payment GROUP BY customer_id ORDER BY SUM (amount) DESC;
/*按顾客编号分组，计算总金额，并按总金额降序排列*/
SELECT customer_id,SUM (amount) FROM payment GROUP BY customer_id HAVING SUM (amount) > 200;
/*按顾客编号分组,查询总金额超过200的顾客编号*/


-- *************第五部分 集合***************
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron'
UNION
SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';
/*并集（UNION ALL包括重复值）*/

SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron'
INTERSECT
SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';
/*交集*/

SELECT film_id,title FROM film
EXCEPT
SELECT DISTINCT inventory.film_id,title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id
ORDER BY title;
/*差集（查询不在库存中的影片）*/


-- *************第六部分 子查询*************
SELECT film,title,rental_rate FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) LIMIT 3;
/*查找租金率高于平均租金率的前3部电影*/

SELECT MAX(length) FROM film INNER JOIN film_category USING(film_id) GROUP BY category_id;
/*查询按电影类别分组的所有电影的最大长度
最小值为178*/
SELECT title,length FROM film 
WHERE length >= ANY(SELECT MAX(length) FROM film INNER JOIN film_category USING(film_id) GROUP BY category_id);
/*对于每个电影类别，子查询找到最大长度。外部查询查看所有这些值并确定哪个胶片的长度大于或等于任何胶片类别的最大长度。
ANY表示有任何一个满足就返回TRUE，此时大于178即可
'SOME'相当于'ANY'
'= ANY'相当于'IN','<> ANY'不同于'NOT IN'
USING用法：ON table1.column_name = table2.column_name 等价于 USING(column_name)*/

SELECT ROUND(AVG (length),2) FROM film GROUP BY rating;
/*查询按电影评级分组的所有电影的平均长度
最大值为120.44*/
SELECT film_id,title,length FROM film
WHERE length > ALL (SELECT ROUND(AVG (length),2) FROM film GROUP BY rating)
ORDER BY length;
/*查询返回所有长度大于子查询返回的平均长度列表中最大值的影片
ALL表示全部都满足才返回TRUE,即大于平均长度的最大值120.44才可*/

SELECT first_name,last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id AND amount > 11 )
ORDER BY first_name,last_name;
/*查找至少有一笔金额大于11的付款的客户
EXISTS运算符来测试子查询中是否存在行*/


-- *************第七部分 修改数据*************
INSERT INTO table (column1, column2, …)
VALUES (value1, value2, …),(value1, value2, …) ,...;
/*一次向表中添加多行*/
INSERT INTO table(column1,column2,...)
SELECT column1,column2,..FROM another_table WHERE condition;
/*插入来自另一个表的数据*/

UPDATE table
SET column1 = value1,column2 = value2 ,...
WHERE condition;
/*更改表中列的值*/
UPDATE A
SET A.c1 = expresion FROM B WHERE A.c2 = B.c2;
/*根据另一个表中的值更新表的数据*/

DELETE FROM table
WHERE condition;
/*从表中删除数据*/
DELETE FROM table
WHERE table.id = (SELECT id FROM another_table);
/*检查引用另一个表中的一个或多个列的条件来删除数据*/


-- *************第八部分 管理表*************
CREATE TABLE role(
 role_id serial PRIMARY KEY,
 role_name VARCHAR (255) UNIQUE NOT NULL
);
/*创建表*/

SELECT film_id,title,rental_rate
INTO TABLE film_r
FROM film
WHERE rating = 'R' AND rental_duration = 5
ORDER BY title;
/*在film的基础上创建一个名为的新表film_r，其中包含R距离film表格5天的评级和租期的所有电影*/
SELECT * FROM film_r;
/*验证表*/

ALTER TABLE table_name ADD COLUMN new_column_name TYPE;
/*向表中添加新列*/
ALTER TABLE table_name DROP COLUMN column_name;
/*删除现有列*/
ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
/*重命名现有列*/
ALTER TABLE assets ALTER COLUMN name TYPE VARCHAR;
/*将assets表中name列的数据类型更改为VARCHAR*/
ALTER TABLE table_name RENAME TO new_table_name;
/*重命名表*/
DROP TABLE IF EXISTS table_name;
/*删除表*/
CREATE TEMP TABLE temp_table(
   ...
);
/*创建临时表*/
TRUNCATE TABLE table_name;
/*删除表中所有数据*/


-- *************第九部分 约束*************
CREATE TABLE TABLE (
 column_1 data_type PRIMARY KEY,
 column_2 data_type,
 …
);
/*主键约束方式一：创建表时定义主键*/
CREATE TABLE TABLE (
 column_1 data_type,
 column_2 data_type,
 … 
PRIMARY KEY (column_1, column_2)
);
/*主键约束方式二：如果主键由两列或更多列组成*/
ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);
/*主键约束方式三：更改现有表结构时定义主键*/
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;
/*删除主键*/

CREATE TABLE person (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 email VARCHAR (50) UNIQUE
);
/*UNIQUE约束方式一：添加UNIQUE约束，确保存储在列或列组中的值在整个表中是唯一*/
CREATE TABLE table (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);
/*UNIQUE约束方式二：列c2和c3中的值组合在整个表中是唯一的。列c2或c3的值不必是唯一的*/

CREATE TABLE invoice(
  id serial PRIMARY KEY,
  product_id int NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);
/*NOT NULL约束方式一：在创建新表时，将PostgreSQL非空约束添加到列*/
ALTER  TABLE table_name
ALTER COLUMN column_name SET NOT NULL;
/*NOT NULL约束方式二：将PostgreSQL非空约束添加到现有表的列*/

CREATE TABLE employees (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 birth_date DATE CHECK (birth_date > '1900-01-01'),
 joined_date DATE CHECK (joined_date > birth_date),
 salary numeric CHECK(salary > 0)
);
/*CHECK约束，该约束根据布尔表达式约束表中列的值
一个CHECK约束是一种约束，使您可以指定是否在列中的值必须满足特定的要求。的CHECK约束使用布尔表达式插入或更新到列之前评估值。如果值通过检查，PostgreSQL将在列中插入或更新这些值。
首先，birth_date员工的出生日期（）必须大于01/01/1900。如果您之前尝试插入出生日期01/01/1900，您将收到一条错误消息。
其次，联合日期（joined_date）必须大于出生日期（birth_date）。此检查将阻止根据其语义含义更新无效日期。
第三，薪水必须大于零*/


-- *************第十部分 条件表达式和运算符*************
SELECT SUM (CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END ) AS "Mass",
 SUM ( CASE WHEN rental_rate = 2.99 THEN 1 ELSE 0 END ) AS "Economic",
 SUM ( CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END ) AS "Luxury"
FROM film;
/*为电影分配价格段：如果租金率为0.99，则为普通；如果租金率是1.99，则为经济；如果出租率是4.99，则为豪华*/

SELECT COALESCE (NULL, 2 , 1);
/*从左到右计算参数，直到找到第一个非null参数*/

SELECT CAST ('100' AS INTEGER);
/*将字符串常量转换为整数*/


-- *************第十一部分 习题*************
/*1.将姓中含有“oo”的演员参演的电影的租赁期增加三天
Al Garland参演的电影的租赁期增加一天，
其他姓“Garland”的演员参演的电影的租赁期减两天，
展示所有演员的名字，过去的租赁期和当前最新的租赁期
问题出在把新的租赁期不知道往SELECT里面放*/
SELECT c.last_name,b.rental_duration AS old_rental_duration,
(CASE WHEN last_name LIKE '%oo%' THEN b.rental_duration+3
     WHEN last_name = 'AI' AND first_name ='Garland' THEN b.rental_duration+1
     WHEN first_name ='Garland' AND last_name != 'AI' THEN b.rental_duration-2
     ELSE b.rental_duration 
     END ) AS new_rental_duration
FROM film_actor a INNER JOIN film b ON a.film_id=b.film_id
                  INNER JOIN actor c ON a.actor_id=c.actor_id 
WHERE c.last_name like '%oo%' or c.last_name='Garland';

/*2.展示播放时长为115分钟到125分钟的电影名称及时长,
并按播放时长排序,相同时长的电影按名字排序，但A开头
和名字中含有c（另一个字母）r的电影必须最后排列，即
该条件为第一满足的条件，即第一排序*/
SELECT title,length FROM film
WHERE length BETWEEN 115 AND 125
/*ORDER BY CASE WHEN title LIKE 'A%' OR '%c_r%' THEN 1 ELSE 0 asc,length,title;
CASE WHEN 一般用于SELECT*/
/*ORDER BY title IN(SELECT title FROM film WHERE title LIKE 'A%' OR '%c_r%'),length,title;
两个LIKE不可直接用OR连接*/
ORDER BY title IN(SELECT title FROM film WHERE title LIKE 'A%' OR title LIKE '%c_r%'),length,title;

/*3.展示不同语言种类的电影数量，并按从小到大的顺序排列*/
SELECT language_id,COUNT(film_id)
FROM film
GROUP BY language_id
ORDER BY COUNT(film_id) asc;

/*4.展示英语类电影的电影类型及相应数目*/
SELECT language_id,COUNT(film_id)
FROM film
WHERE film.language_id='1'
GROUP BY language_id;

/*5.展示有支付行为的每个城市的支付笔数*/
SELECT SUM(CASE WHEN a.amount>0 THEN 1 ELSE 0 END),d.city,e.country
FROM payment a JOIN staff b ON a.staff_id=b.staff_id
JOIN address c ON b.address_id=c.address_id
JOIN city d ON c.city_id=d.city_id
JOIN country e ON d.country_id=e.country_id
GROUP BY e.country,d.city;

/*6.找出每个国家按字母排序是排末位的城市中最高的支付金额*/
SELECT MAX(a.amount),d.city,e.country
FROM payment a JOIN staff b ON a.staff_id=b.staff_id
JOIN address c ON b.address_id=c.address_id
JOIN city d ON c.city_id=d.city_id
JOIN country e ON d.country_id=e.country_id
WHERE city<=ALL(SELECT city FROM country f WHERE e.country=f.country)
/*e.country=f.country为了确保在同一国家内比较*/
GROUP BY e.country,d.city;
