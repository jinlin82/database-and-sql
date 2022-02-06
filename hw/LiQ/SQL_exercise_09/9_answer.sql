-- 将csv文件导入到表cran_logs中
COPY cran_logs
FROM
'C:\Users\Yisha\Desktop\sql_exercise\sql-exercise1-10\SQL_exercise_09\cran_logs_2015-01-01.csv' DELIMITER ',' CSV HEADER;

-- 9.1 give the total number of recordings in this table
SELECT * FROM cran_logs;

-- 9.2 the number of packages listed in this table?
SELECT count(package)
FROM (SELECT DISTINCT package
    FROM cran_logs) a;

-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT count(*)
FROM cran_logs
WHERE package = 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
SELECT count(*)
FROM cran_logs
WHERE country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT package,count(*)
FROM cran_logs
GROUP BY package
ORDER BY count(*) DESC;

-- 9.6 Give the package ranking (based ON how many times it was downloaded)
-- during 9AM to 11AM

SELECT package,count(*)
FROM cran_logs
WHERE time >= '9:00:00' AND time <= '11:00:00'
GROUP BY package
ORDER BY count(*) DESC;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT count(*)
FROM cran_logs
WHERE country IN ('CN','JP','SG');

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
SELECT country,count(*)
FROM cran_logs
GROUP BY country
HAVING count(*) >(SELECT count(*)
                FROM cran_logs
                WHERE country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages
select avg(length)
from (select distinct package,length(package)
        FROM cran_logs) a;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
-- 下载量排名第二的包
select package,count(*)
from cran_logs
group by package
order BY count(*) desc
limit 1 OFFSET 1;
-- 应用于下载次数不同的情况

-- 9.11 Print the name of the package whose download count is bigger than 1000.
select package,count(*)
from cran_logs
group by package
having count(*)>1000;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
select r_os,count(*) as num
from cran_logs
where r_os != 'NA'
GROUP BY r_os
ORDER BY num DESC