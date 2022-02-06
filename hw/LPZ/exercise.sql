-- *************第一部分 查询***************

/*查询customer表中的名字dd*/
SELECT first_name FROM customer;

/*查询city表中的城市名称（过滤重复值）*/
SELECT DISTINCT city FROM city;

/*查询customer表中的名字和姓氏，按照名字升序排列*/
SELECT first_name,last_name FROM customer ORDER BY first_name;

/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/
SELECT first_name,last_name FROM customer ORDER BY first_name,last_name DESC;

/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/
SELECT RTRIM(first_name) || ' ' || last_name AS full_name FROM customer ORDER BY full_name;


-- *************第二部分 筛选***************

/*查询customer表中名字为Aaron的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron';

/*查询customer表中没有去1号店的顾客的邮箱*/
SELECT email FROM customer WHERE store_id != 1;

/*查询支付租金的金额小于1美元或大于8美元的顾客编号，金额以及付款日期*/
SELECT customer_id,amount,payment_date FROM payment WHERE amount < 1 OR amount > 8 ORDER BY amount;

/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于100的电影编号和名称*/
SELECT film_id,title,rental_duration,length FROM film WHERE (rental_duration !=5 AND length <100) OR (rental_duration = 5 AND length >100);

/*查询customer表中名字为Alan或Alex的名字和姓氏和邮箱*/
SELECT first_name,last_name,email FROM customer WHERE first_name = 'Alan' OR first_name = 'Alex';

/*查询payment表中付款日期在2007-02-20-2007-02-21之间的顾客编号*/
SELECT customer_id,payment_date FROM payment WHERE payment_date BETWEEN '2007-02-20' AND '2007-02-21'; 

/*查询address表中以Man开头的街区名称*/
SELECT district FROM address WHERE district LIKE 'Man%';

/*查询customer表中名字含有"er"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name  LIKE '%er%' ;

/*查询customer表中名字以任一字符开头，中间为"her"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name Like '_her%';

/*查询customer表中名字不以"Jen"开头的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name NOT LIKE 'Jen%';

/*查询customer表中名字以"BAR"或者"Bar"或者“BaR"开头的名字和姓氏（ILIKE运算符不区分大小写的值）*/
SELECT first_name,last_name FROM customer WHERE first_name ILIKE 'Bar%';

/*查询address表中电话号码不为空的街区名称*/
SELECT district,phone FROM address WHERE phone IS NOT NULL;

/*查询film表中按标题排序的前五部电影*/
SELECT title FROM film ORDER BY title LIMIT 5;

/*查询film表中从第3行之后（即第4行）开始的4行数据*/
SELECT * FROM film ORDER BY film_id LIMIT 4 OFFSET 3;


-- *************第三部分 连接***************

/*查询客户ID 2的客户租赁数据（两表内连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date  FROM customer a INNER JOIN payment b ON a.customer_id=b.customer_id WHERE a.customer_id = 2;

/*查询客户ID 2的客户租赁数据（三表内连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a INNER JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2;
/*查询客户ID 2的客户租赁数据（两表内连接）*/
SELECT a.customer_id,a.first_name customer_first_name,a.last_name customer_last_name,a.email,b.staff_id,b.first_name staff_first_name,b.last_name staff_last_name,c.amount,c.payment_date
FROM customer a INNER JOIN payment c ON a.customer_id = c.customer_id
INNER JOIN staff b ON b.staff_id = c.staff_id 
WHERE a.customer_id = 2;

/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左外连接，以film为主表*/
SELECT a.film_id,a.title,b.inventory_id FROM film a LEFT JOIN inventory b ON a.film_id = b.film_id WHERE b.film_id IS NULL;

/*查找具有相同长度的所有电影对（自连接）
自联接对于比较同一表中的一列行中的值很有用。
要形成自连接，请使用不同的别名指定同一个表两次，设置比较，并消除值等于自身的情况。*/
SELECT a.title,b.title,a.length
FROM film a INNER JOIN film b ON a.film_id = b.film_id
AND a.length = b.length;

/*查询客户ID 2的客户租赁数据（完整外连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id 
WHERE a.customer_id = 2 AND (a.customer_id IS NULL OR b.customer_id IS NULL);

/*查询客户ID 2的客户租赁数据（完全外连接,,不包括a,b的交集部分）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b ON a.customer_id = b.customer_id WHERE a.customer_id = 2 AND (a.customer_id IS NULL OR b.customer_id IS NULL);

/*笛卡尔积（交叉连接，2表对应组合）*/

/*等同于以上形式*/


-- *************第四部分 分组***************

/*按顾客编号分组，计算总金额，并按总金额降序排列*/
SELECT sum(amount) from payment group by customer_id ORDER BY SUM (amount) DESC;

/*按顾客编号分组,查询总金额超过200的顾客编号*/
SELECT sum(amount) from payment group by customer_id having sum(amount)>200 ORDER BY SUM (amount) DESC;

-- *************第五部分 集合***************

/*并集（UNION ALL包括重复值）*/
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron' UNION SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';

/*交集*/
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron'INTERSECT SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';

/*差集（查询不在库存中的影片）*/
SELECT film.film_id,film.title FROM film EXCEPT select DISTINCT inventory.film_id,film.title FROM inventory INNER JOIN film ON film.film_id = inventory.film_id order by title;

-- *************第六部分 子查询*************

/*查找租金率高于平均租金率的前3部电影*/
select title,film_id from film where rental_rate > (SELECT avg(rental_rate) from film) order by rental_rate LIMIT 3; 

/*查询按电影类别分组的所有电影的最大长度
最小值为178*/
SELECT max(length),name from film INNER JOIN film_category USING(film_id) INNER JOIN category USING(category_id) GROUP BY category_id;


/*查询按电影评级分组的所有电影的平均长度
最大值为120.44*/
SELECT ROUND(AVG (length),2),rating FROM film GROUP BY rating order by ROUND(AVG (length),2);

/*查询返回所有长度大于子查询返回的平均长度列表中最大值的影片
ALL表示全部都满足才返回TRUE,即大于平均长度的最大值120.44才可*/
SELECT title,film_id,length,film.rating from film where film.length > all(SELECT ROUND(AVG (length),2) FROM film GROUP BY rating) order by rating,length;

/*查找至少有一笔金额大于11的付款的客户
EXISTS运算符来测试子查询中是否存在行*/
SELECT first_name,last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id AND amount > 11 )
ORDER BY first_name,last_name;