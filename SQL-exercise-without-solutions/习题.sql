-- *************第一部分 查询***************

/*查询customer表中的名字dd*/

/*查询city表中的城市名称（过滤重复值）*/

/*查询customer表中的名字和姓氏，按照名字升序排列*/

/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/

/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/


-- *************第二部分 筛选***************

/*查询customer表中名字为Aaron的名字和姓氏*/

/*查询customer表中没有去1号店的顾客的邮箱*/

/*查询支付租金的金额小于1美元或大于8美元的顾客编号，金额以及付款日期*/

/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于100的电影编号和名称*/


/*查询customer表中名字为Alan或Alex的名字和姓氏和邮箱*/

/*查询payment表中付款日期在2007-02-20-2007-02-21之间的顾客编号*/

/*查询address表中以Man开头的街区名称*/

/*查询customer表中名字含有"er"的名字和姓氏*/

/*查询customer表中名字以任一字符开头，中间为"her"的名字和姓氏*/

/*查询customer表中名字不以"Jen"开头的名字和姓氏*/

/*查询customer表中名字以"BAR"或者"Bar"或者“BaR"开头的名字和姓氏（ILIKE运算符不区分大小写的值）*/

/*查询address表中电话号码不为空的街区名称*/

/*查询film表中按标题排序的前五部电影*/

/*查询film表中从第3行之后（即第4行）开始的4行数据*/


/*查询film表中按标题排序的前五部电影*/

/*查询film表中从第3行之后（即第4行）开始的4行数据*/


-- *************第三部分 连接***************

/*查询客户ID 2的客户租赁数据（两表内连接）*/

/*查询客户ID 2的客户租赁数据（三表内连接）*/


/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左外连接，以film为主表*/

/*film表中的某些行在表中没有对应的行inventory，因此库存ID的值为NULL，提取出来（左连接，以film为主表*/


/*查找具有相同长度的所有电影对（自连接）
自联接对于比较同一表中的一列行中的值很有用。
要形成自连接，请使用不同的别名指定同一个表两次，设置比较，并消除值等于自身的情况。*/

/*查询客户ID 2的客户租赁数据（完整外连接）*/

/*查询客户ID 2的客户租赁数据（完全外连接,,不包括a,b的交集部分）*/


/*笛卡尔积（交叉连接，2表对应组合）*/

/*等同于以上形式*/


-- *************第四部分 分组***************

/*按顾客编号分组，计算总金额，并按总金额降序排列*/

/*按顾客编号分组,查询总金额超过200的顾客编号*/


-- *************第五部分 集合***************

/*并集（UNION ALL包括重复值）*/


/*交集*/


/*差集（查询不在库存中的影片）*/


-- *************第六部分 子查询*************

/*查找租金率高于平均租金率的前3部电影*/


/*查询按电影类别分组的所有电影的最大长度
最小值为178*/


/*查询按电影评级分组的所有电影的平均长度
最大值为120.44*/

/*查询返回所有长度大于子查询返回的平均长度列表中最大值的影片
ALL表示全部都满足才返回TRUE,即大于平均长度的最大值120.44才可*/


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


/*2.展示播放时长为115分钟到125分钟的电影名称及时长,
并按播放时长排序,相同时长的电影按名字排序，但A开头
和名字中含有c（另一个字母）r的电影必须最后排列，即
该条件为第一满足的条件，即第一排序*/


/*3.展示不同语言种类的电影数量，并按从小到大的顺序排列*/


/*4.展示英语类电影的电影类型及相应数目*/


/*5.展示有支付行为的每个城市的支付笔数*/


/*6.找出每个国家按字母排序是排末位的城市中最高的支付金额*/

/*补充练习题，表为film
/*1.展示播放时长为115分钟到125分钟的电影名称及时长,
并按播放时长排序,相同时长的电影按名字排序，但A开头
和名字中含有c（另一个字母）r的电影必须最后排列，即
该条件为第一满足的条件*/


--2.展示不同语言种类的电影数量，并按从小到大的顺序排列


--3.展示英语类电影的电影类型及相应数目


--4.寻找姓“Garland”的演员


/*5.将姓中含有“oo”的演员参演的电影的租赁期增加三天
Al Garland参演的电影的租赁期增加一天，
其他姓“Garland”的演员参演的电影的租赁期减两天，
展示所有演员的名字，过去的租赁期和当前最新的租赁期*/

/*6.找出每个国家按字母排序是排末位的城市中最高的支付金额，
最后的展示格式为国家、城市、支付金额*/


/*7.展示有支付的每个城市的支付的笔数*/
