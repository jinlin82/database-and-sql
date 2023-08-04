/* clear */
\! cls

/*显示所有表*/
\dt
SELECT * FROM pg_tables WHERE schemaname = 'public';


/*显示表的结构*/
\d film


/* 显示表数据条数*/
SELECT count(*) from film;

/* 查看有限条数据*/
SELECT * from film;
SELECT * from film LIMIT 5;

SELECT * from film LIMIT 5 OFFSET ((SELECT count(*) from film)-5);

/* 条件 */
SELECT * from film WHERE (length>=180 AND rental_rate>3);


/* 统计量 */
SELECT avg(length) FROM film;

/* group by */
SELECT rating as 评级, avg(length) as 平均值 FROM film GROUP by rating;

/* group by having*/
COPY
(
SELECT rating as 评级, avg(length) as 平均值 FROM film 
    GROUP by rating HAVING avg(length)>120
)
TO 'c:/temp/dat.csv' DELIMITER ',' CSV HEADER;

-- 注释

/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/

SELECT first_name || ' ' || last_name as full_name from customer;

/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/

SELECT first_name, last_name FROM customer ORDER BY first_name ASC, last_name DESC;

/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于
100的电影编号和名称*/

SELECT film_id, title FROM film WHERE (rental_duration<> 5 AND length <100) OR (rental_duration>5 AND length >100);


/*查询客户ID 2的客户租赁数据（两表内连接）*/

SELECT customer.last_name, customer.first_name, rental.* FROM rental 
  INNER JOIN customer ON rental.customer_id=customer.customer_id
    WHERE rental.customer_id=2;