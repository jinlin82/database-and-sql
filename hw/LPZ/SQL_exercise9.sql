--*********exercise9**********
select* from cran_logs LIMIT 20;

-- 9.1 give the total number of recordings in this table
SELECT COUNT(*) FROM cran_logs;

-- 9.2 the number of packages listed in this table?
SELECT count(DISTINCT package) from cran_logs;

-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT count(*) from cran_logs WHERE package = 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
SELECT count(*) from cran_logs WHERE country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT package,count(*) from cran_logs GROUP by package order by 2 desc;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select a.package,count(a.*) from(SELECT * from cran_logs WHERE substr(time,1,5)<'11:00' and substr(time,1,5)>'09:00') as a group by a.package order by 2 desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT COUNT(*) FROM cran_logs WHERE country IN ('CN' , 'JP', 'SG');

-- 9.8 Print the countries whose downloaded are more than the downloads from
-- China ("CN")
SELECT a.country,a.downloads from 
(SELECT country,count(*) downloads from cran_logs group by country) as a
WHERE a.downloads > (
SELECT count(*) downloads from cran_logs group by country having country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages
SELECT avg(length(package)) from cran_logs;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
select TEMP.a package,temp.b count from (SELECT package a,count(*) b from cran_logs GROUP by package order by b DESC )TEMP LIMIT 1 OFFSET 1;

-- 9.11 Print the name of the package whose download count is bigger than 1000.

SELECT package from cran_logs GROUP by package HAVING count(*) > 1000;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
SELECT substr(r_os,1,5) as os,count(*) as Download_Count,round(count(*)/((SELECT COUNT(*) FROM cran_logs)*1.0)*100) || '%' AS PROPORTION from cran_logs GROUP by substr(r_os,1,5);