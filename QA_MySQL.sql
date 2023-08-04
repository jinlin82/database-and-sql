SHOW databases;

USE sakila;

SHOW tables;



SELECT * FROM actor;

-- 选择有限条记录

SELECT * FROM actor LIMIT 10;
SELECT * FROM actor LIMIT 10, 10;

-- 选择不重复记录
SELECT DISTINCT first_name FROM actor;


-- 保存为csv
SELECT * FROM film
INTO outfile 'c:/temp/res3.csv'
FIELDS TERMINATED BY ',';

SHOW VARIABLES LIKE "secure_file_priv";

SELECT @@global.secure_file_priv;



show variables LIKE "local_infile";


-- 单独使用函数
SELECT sin(3);
SELECT CONCAT("SQL ", "Tutorial ", "is ", "fun!") AS ConcatenatedString;