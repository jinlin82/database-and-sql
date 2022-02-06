-- 9.1 give the total number of recordings in this table
SELECT * FROM cran_logs LIMIT 5;
SELECT count(1) FROM cran_logs;
-- 9.2 the number of packages listed in this table?
 SELECT count(1) FROM (SELECT DISTINCT package FROM cran_logs) AS a;
-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT count(1) from cran_logs WHERE package ='Rcpp';
-- 9.4 How many recordings are from China ("CN")?
SELECT count(1) from cran_logs WHERE country ='CN';
-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT package,count(1) from cran_logs GROUP BY package ORDER BY count(1) DESC;
-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
SELECT a.package,count(b.)

SELECT package,count(1) from cran_logs GROUP BY package LIMIT 5;

SELECT a.package FROM SELECT a.package,count(1) from cran_logs GROUP BY package AS a LEFT JOIN (SELECT b.package as package_ from cran_logs WHERE time BETWEEN '09:00:00' AND '11:00:00' AS b) ON a.package=b.package_;

SELECT package,count(1) from cran_logs GROUP BY package WHERE time BETWEEN '09:00:00' AND '11:00:00' LIMIT 5;
-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore
-- ("SG")?
SELECT count(1) from cran_logs WHERE country in ('CN','JP','SG');
-- 9.8 Print the countries whose downloaded are more than the downloads from
-- China ("CN")
SELECT country as COUNTS from cran_logs GROUP BY country HAVING count(1)> (SELECT count(1) from cran_logs GROUP BY country HAVING country = 'CN' ) ;

-- 9.9 Print the average length of the package name of all the UNIQUE packages
SELECT avg(length(package)) FROM (SELECT DISTINCT package FROM cran_logs) as b;
-- 9.10 Get the package whose downloading count ranks 2nd (print package name
-- and it's download count).
SELECT package,count(1) FROM cran_logs GROUP BY package ORDER BY count(1) DESC;
-- 9.11 Print the name of the package whose download count is bigger than 1000.
SELECT package from cran_logs GROUP by package HAVING count(*) > 1000;
-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).

SELECT substr(r_os,1,5) as os,count(*) as Download_Count,round(count(*)/((SELECT COUNT(*) FROM cran_logs)*1.0)*100) || '%' AS PROPORTION from cran_logs GROUP by substr(r_os,1,5);