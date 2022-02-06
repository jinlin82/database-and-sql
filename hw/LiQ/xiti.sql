-- *************第一部分 查询***************

/*查询customer表中的名字id*/
SELECT customer_id
FROM customer;
/*查询city表中的城市名称（过滤重复值）*/
SELECT DISTINCT city
FROM city;

/*查询customer表中的名字和姓氏，按照名字升序排列*/
SELECT first_name,last_name
FROM customer
ORDER BY first_name ;
/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/
SELECT first_name,last_name
FROM customer
ORDER BY first_name,last_name DESC;
/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/
-- sql中的拼接符‘||’ 将两个字段拼接在一起
SELECT first_name || ' ' || last_name AS full_name
FROM customer;

-- *************第二部分 筛选***************

/*查询customer表中名字为Aaron的名字和姓氏*/
SELECT first_name,last_name
FROM customer
WHERE first_name = 'Aaron';

/*查询customer表中没有去1号店的顾客的邮箱*/
SELECT DISTINCT email
FROM customer
WHERE store_id != 1;

/*查询支付租金的金额小于1美元或大于8美元的顾客编号，金额以及付款日期*/
SELECT
    customer_id,
    amount,
    payment_date
FROM payment
WHERE amount NOT BETWEEN 1 AND 8;
-- WHERE amount < 1 or amount >8;

/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于100的电影编号和名称*/
SELECT
    film_id,
    title
FROM film
WHERE (rental_duration!=5 AND  length <100 ) or(rental_duration=5 AND length >100 );

/*查询customer表中名字为Alan或Alex的名字和姓氏和邮箱*/
SELECT
    first_name,
    last_name,
    email
FROM customer
WHERE first_name IN ('Alan','Alex');

/*查询payment表中付款日期在2007-02-20-2007-02-21之间的顾客编号*/
SELECT DISTINCT customer_id
FROM payment
WHERE payment_date BETWEEN '2007-02-20' AND '2007-02-21';

/*查询address表中以Man开头的街区名称*/
SELECT district
FROM address
WHERE district LIKE 'Man%';

SELECT district
FROM address
WHERE district ~ '^Man';
--postgresql中正则表达式需要使用关键字~,若不想区分大小写，则用~*

/*查询customer表中名字含有"er"的名字和姓氏*/
SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '%er%';

SELECT first_name,last_name
FROM customer
WHERE first_name ~ 'er';

/*查询customer表中名字以任一字符开头，中间为"her"的名字和姓氏*/
-- 名字中间含有‘her’的，说明‘her’不能为名字结尾？
SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '_%her%_';

/*查询customer表中名字不以"Jen"开头的名字和姓氏*/
SELECT first_name,last_name
FROM customer
WHERE first_name NOT LIKE 'Jen%';

/*查询customer表中名字以"BAR"或者"Bar"或者“BaR"开头的名字和姓氏*/
--（ILIKE运算符不区分大小写的值）
SELECT first_name,last_name
FROM customer
WHERE first_name LIKE 'BAR%' OR first_name LIKE 'Bar%' OR first_name LIKE 'BaR%';

SELECT first_name,last_name
FROM customer
WHERE first_name ILIKE 'BAR%';

/*查询address表中电话号码不为空的街区名称*/
SELECT district
FROM address
WHERE phone IS NOT NULL;

/*查询film表中按标题排序的前五部电影*/
SELECT title
FROM film
ORDER BY title
LIMIT 5;

/*查询film表中从第3行之后（即第4行）开始的4行数据*/
SELECT *
FROM film
LIMIT 4 offset 3;

-- *************第三部分 连接***************

/*查询客户ID 2的客户租赁数据（两表内连接）*/
SELECT r.*
FROM customer c
JOIN rental r
     ON c.customer_id = r.customer_id
WHERE c.customer_id = 2;

/*查询客户ID 2的客户租赁数据（三表内连接）*/


/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左外连接，以film为主表*/
SELECT f.*
FROM film f
LEFT JOIN inventory i
      ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;


/*查找具有相同长度的所有电影对（自连接）
自联接对于比较同一表中的一列行中的值很有用。
要形成自连接，请使用不同的别名指定同一个表两次，设置比较，并消除值等于自身的情况。*/
SELECT f1.film_id,f2.film_id,f1.length
FROM film f1
JOIN film f2
     ON f1.film_id != f2.film_id AND f1.length = f2.length;

/*查询客户ID 2的客户租赁数据（完整外连接）*/
SELECT c.*,r.*
FROM customer c
FULL JOIN rental r
     ON c.customer_id = r.customer_id
WHERE c.customer_id = 2;

/*查询客户ID 2的客户租赁数据（完全外连接,,不包括a,b的交集部分）*/
SELECT c.*,r.*
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
WHERE c.customer_id = 2;

/*笛卡尔积（交叉连接，2表对应组合）*/
SELECT c.*,r.*
FROM customer c
cross JOIN rental r
WHERE c.customer_id = 2;

/*等同于以上形式*/
SELECT c.*,r.*
FROM customer c,rental r;

-- *************第四部分 分组***************

/*按顾客编号分组，计算总金额，并按总金额降序排列*/
SELECT customer_id,SUM(amount) AS sum_amount 
FROM payment
GROUP BY customer_id
ORDER BY sum_amount DESC;

/*按顾客编号分组,查询总金额超过200的顾客编号*/
SELECT customer_id,sum(amount) AS sum_amount
FROM payment
GROUP BY customer_id
    HAVING  sum(amount)>200;
-- 此处筛选语句用having,不用where,having语句作用于组，筛选出满足条件的组；where作用于基本的表和视图

-- *************第五部分 集合***************

/*并集（UNION ALL包括重复值）*/
-- union
SELECT first_name,last_name
FROM customer
WHERE first_name = 'Aaron'
UNION
SELECT first_name,last_name
FROM customer
WHERE first_name = 'Rene';

/*交集*/
-- intersect
SELECT first_name,last_name
FROM customer
WHERE first_name = 'Aaron'
intersect
SELECT first_name,last_name
FROM customer
WHERE first_name = 'Rene';

/*差集（查询不在库存中的影片）*/
-- except
SELECT film_id
FROM film
except
SELECT  DISTINCT f.film_id
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id;


-- *************第六部分 子查询*************

/*查找租金率高于平均租金率的前3部电影*/
-- 计算平均租金率
SELECT avg(rental_rate)
FROM film;

--租金率高于平均租金率的电影
SELECT film_id
FROM film
WHERE rental_rate>(SELECT avg(rental_rate)
                    FROM  film);

--查找租金率高于平均租金率的前3部电影
SELECT film_id,title,rental_rate
FROM film
WHERE rental_rate>(SELECT avg(rental_rate)
                    FROM film)
ORDER BY rental_rate DESC
LIMIT 3;

/*查询按电影类别分组的所有电影的最大长度
最小值为178*/
SELECT a.category_id,c.name category,a.max_length
FROM 
(SELECT category_id,max(length) max_length
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
GROUP BY category_id) a
JOIN category c
    ON a.category_id = c.category_id;

/*查询按电影评级分组的所有电影的平均长度
最大值为120.44*/
SELECT rating,round(avg(length),2)  avg_length
FROM film
GROUP BY rating;

/*查询返回所有长度大于子查询返回的平均长度列表中最大值的影片
ALL表示全部都满足才返回TRUE,即大于平均长度的最大值120.44才可*/
SELECT film_id,title,length
FROM film
WHERE length > (SELECT avg(length) avg_length
                FROM film
                GROUP BY rating
                ORDER BY avg_length DESC
                LIMIT 1);

SELECT film_id,title,length
FROM film
WHERE length > all(SELECT avg(length) FROM film GROUP BY rating);

/*查找至少有一笔金额大于11的付款的客户
EXISTS运算符来测试子查询中是否存在行*/

SELECT first_name,last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id AND amount > 11 )  
ORDER BY first_name,last_name;

-- *************第七部分 修改数据*************

/*一次向表中添加多行*/
INSERT INTO table(column1,column2,……)
values(values1,values2,……),(values1,values2,……),……;

/*插入来自另一个表的数据*/
INSERT INTO table(column1,column2,...)
SELECT column1,column2,..from another_table WHERE codition;

insert into 

/*更改表中列的值*/
UPDATE TABLE
SET column1 = value1,column2 = value2,...
WHERE codition;

/*根据另一个表中的值更新表的数据*/
UPDATE A
SET A.c1 = expresion FROM B WHERE A.c2 = B.c2;

/*从表中删除数据*/
DELETE FROM TABLE
WHERE condition;

/*检查引用另一个表中的一个或多个列的条件来删除数据*/
DELETE FROM TABLE
WHERE table.id = (SELECT id FROM another_table);

-- *************第八部分 管理表*************
/*创建表*/
CREATE TABLE role(
 role_id serial PRIMARY KEY,
 role_name VARCHAR (255) UNIQUE NOT NULL
);

/*在film的基础上创建一个名为的新表film_r，其中包含R距离film表格5天的评级和租期的所有电影*/
SELECT film_id,title,rental_rate
INTO TABLE film_r
FROM film
WHERE rating = 'R' AND rental_duration = 5
ORDER BY title;

/*验证表*/
SELECT * FROM film_r;

/*向表中添加新列*/
ALTER TABLE table_name ADD COLUMN new_column_name TYPE;
/*删除现有列*/
ALTER TABLE table_name DROP COLUMN column_name;
/*重命名现有列*/
ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
/*将assets表中name列的数据类型更改为VARCHAR*/
ALTER TABLE assets ALTER COLUMN name TYPE VARCHAR;
/*重命名表*/
ALTER TABLE table_name RENAME TO new_table_name;
/*删除表*/
DROP TABLE IF EXISTS table_name;
/*创建临时表*/
CREATE TEMP TABLE temp_table(                 
   ...
);
/*删除表中所有数据*/
TRUNCATE TABLE table_name;



-- *************第九部分 约束*************
/*主键约束方式一：创建表时定义主键*/
CREATE TABLE TABLE (
 column_1 data_type PRIMARY KEY,
 column_2 data_type,
 …
);

/*主键约束方式二：如果主键由两列或更多列组成*/
CREATE TABLE TABLE (
 column_1 data_type,
 column_2 data_type,
 … 
PRIMARY KEY (column_1, column_2)
);

/*主键约束方式三：更改现有表结构时定义主键*/
ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);
/*删除主键*/
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;

/*UNIQUE约束方式一：添加UNIQUE约束，确保存储在列或列组中的值在整个表中是唯一*/
CREATE TABLE person (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 email VARCHAR (50) UNIQUE
);
/*UNIQUE约束方式二：列c2和c3中的值组合在整个表中是唯一的。列c2或c3的值不必是唯一的*/
CREATE TABLE TABLE (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);

/*NOT NULL约束方式一：在创建新表时，将PostgreSQL非空约束添加到列*/
CREATE TABLE invoice(
  id serial PRIMARY KEY,
  product_id int NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);
/*NOT NULL约束方式二：将PostgreSQL非空约束添加到现有表的列*/
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;

/*CHECK约束，该约束根据布尔表达式约束表中列的值
一个CHECK约束是一种约束，使您可以指定是否在列中的值必须满足特定的要求。的CHECK约束使用布尔表达式插入或更新到列之前评估值。如果值通过检查，PostgreSQL将在列中插入或更新这些值。
首先，birth_date员工的出生日期（）必须大于01/01/1900。如果您之前尝试插入出生日期01/01/1900，您将收到一条错误消息。
其次，联合日期（joined_date）必须大于出生日期（birth_date）。此检查将阻止根据其语义含义更新无效日期。
第三，薪水必须大于零*/
CREATE TABLE employees (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 birth_date DATE CHECK (birth_date > '1900-01-01'),
 joined_date DATE CHECK (joined_date > birth_date),
 salary numeric CHECK(salary > 0)
);



-- *************第十部分 条件表达式和运算符*************
/*为电影分配价格段：如果租金率为0.99，则为普通；如果租金率是1.99，则为经济；如果出租率是4.99，则为豪华*/
SELECT SUM (CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END ) AS "Mass",
 SUM ( CASE WHEN rental_rate = 2.99 THEN 1 ELSE 0 END ) AS "Economic",
 SUM ( CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END ) AS "Luxury"
FROM film;

/*从左到右计算参数，直到找到第一个非null参数*/
SELECT COALESCE (NULL, 2 , 1);

/*将字符串常量转换为整数*/
SELECT CAST ('100' AS INTEGER);



-- *************第十一部分 习题*************
/*1.将姓中含有“oo”的演员参演的电影的租赁期增加三天
Al Garland参演的电影的租赁期增加一天，
其他姓“Garland”的演员参演的电影的租赁期减两天，
展示所有演员的名字，过去的租赁期和当前最新的租赁期
问题出在把新的租赁期不知道往SELECT里面放*/
SELECT 
        a.first_name,
        a.last_name,
        f.rental_duration AS old_rental_duration,
        (CASE when last_name LIKE '%oo%' then f.rental_duration+3
              when first_name = 'Al' AND last_name = 'Garland' then f.rental_duration+1
              when first_name !='Al' AND last_name = 'Garland' then f.rental_duration-2
              else f.rental_duration
              end) AS new_rental_duration
FROM film f INNER JOIN film_actor fa ON f.film_id = fa.film_id
            INNER JOIN actor  a ON fa.actor_id = a.actor_id;

/*2.展示播放时长为115分钟到125分钟的电影名称及时长,
并按播放时长排序,相同时长的电影按名字排序，但A开头
和名字中含有c（另一个字母）r的电影必须最后排列，即
该条件为第一满足的条件，即第一排序*/

-- 在根据满足某些条件进行排序时，要用升序才能将符合条件的值排在最后面，用降序把符合条件的值排在最前面
SELECT title,length
FROM film
WHERE length BETWEEN 115 AND 125
ORDER BY title IN (SELECT title FROM film WHERE title LIKE 'A%' OR title LIKE '%c_r%')asc, length asc,title asc;

/*3.展示不同语言种类的电影数量，并按从小到大的顺序排列*/
select language_id,count(film_id)
from film
group by language_id
order BY count(film_id) asc;


/*4.展示英语类电影的电影类型及相应数目*/
select f.language_id,count(film_id)
from film f
join language l on  f.language_id = l.language_id
where l.name = 'English'
GROUP BY f.language_id;

/*5.展示有支付行为的每个城市的支付笔数*/
SELECT co.country,ci.city,sum(case when p.amount>0 then 1 else 0 end) AS sum_payment
FROM payment p JOIN customer c ON p.customer_id = c.customer_id
               JOIN address a ON a.address_id = c.address_id
               JOIN city ci ON ci.city_id = a.city_id
               JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country,ci.city;

/*6.找出每个国家按字母排序是排末位的城市中最高的支付金额*/
SELECT co.country,ci1.city,max(p.amount)
FROM payment p JOIN customer c ON p.customer_id = c.customer_id
               JOIN address a ON c.address_id = a.address_id
               JOIN city ci1 ON a.city_id = ci1.city_id
               JOIN country co ON co.country_id = ci1.country_id
WHERE city >= all(select city FROM city ci2 WHERE ci1.country_id = ci2.country_id)
GROUP BY co.country,ci1.city;

-- 列出国家名，和每个国家按字母排序中是排末位的城市
SELECT country_id,city 
FROM city a
WHERE city >=all(select city FROM city b WHERE a.country_id = b.country_id);

SELECT co.country,ci1.city
FROM city ci1
JOIN country co ON ci1.country_id = co.country_id
WHERE city >= all(select city FROM city ci2 WHERE ci1.country_id = ci2.country_id);

