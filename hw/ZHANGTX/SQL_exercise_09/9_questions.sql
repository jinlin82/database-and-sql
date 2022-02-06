-- 9.1 give the total number of recordings in this table
SELECT count(time) from cran_logs;
-- 9.2 the number of packages listed in this table?
SELECT count( DISTINCT package) from cran_logs;
-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT count(package)
from cran_logs
GROUP by package
HAVING package='Rcpp';
-- 9.4 How many recordings are from China ("CN")?
SELECT count(country)
from cran_logs
GROUP by country
HAVING country='CN';
-- 9.5 Give the package name and how many times they're downloaded. Order by the
-- 2nd column descently.
SELECT package,count(package)
from cran_logs
GROUP by package
order by count(package)DESC;
-- 9.6 Give the package ranking (based on how many times it was downloaded)
-- during 9AM to 11AM
SELECT package,count(package)
from(
SELECT time,package
from cran_logs
WHERE time >= '09:00:00' AND time<='11:00:00')as new
group by package
order by count(package)desc;
-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore
-- ("SG")?
SELECT country,count(country)
from cran_logs
GROUP by country
HAVING country='CN' OR country='JP' OR country='SG';
-- 9.8 Print the countries whose downloaded are more than the downloads from
-- China ("CN")
SELECT country
from(
SELECT country,count(country)
FROM cran_logs
GROUP by country
)as new 
WHERE count>(SELECT count
FROM (SELECT country,count(country)
FROM cran_logs
GROUP by country)as new1
WHERE country='CN');
-- 9.9 Print the average length of the package name of all the UNIQUE packages
SELECT avg(length(package))
from(
SELECT DISTINCT package
from cran_logs)as new
;
-- 9.10 Get the package whose downloading count ranks 2nd (print package name
-- and it's download count).
SELECT package,count(package)
from cran_logs
group by package
order by count(package)desc
LIMIT 1 OFFSET 1;
-- 9.11 Print the name of the package whose download count is bigger than 1000.
SELECT package,count(package)
from cran_logs
group by package
HAVING count(package)>1000
order by count(package)desc
;
-- 9.12 The field "r_os" is the operating system of the users.
--      Here we would like to know what main system we have (ignore version
--      number), the relevant counts, and the proportion (in percentage).
SELECT r_os,concat(round(100*count/total::numeric,8),'%')as percent
from(
SELECT r_os,count(r_os)
from cran_logs
GROUP by r_os)as new1,(
    SELECT count( *)as total from cran_logs
    )as new2
;

