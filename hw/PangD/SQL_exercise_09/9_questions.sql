-- 9.1 give the total number of recordings in this table
SELECT * FROM cran_logs;
SELECT COUNT(date) FROM cran_logs;
-- 9.2 the number of packages listed in this table?
SELECT COUNT(DISTINCT package) FROM cran_logs;
-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT COUNT(time) FROM cran_logs WHERE package = 'Rcpp';
-- 9.4 How many recordings are from China ("CN")?
SELECT COUNT(time) FROM cran_logs WHERE country = 'CN';
-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT package,COUNT(time) FROM cran_logs GROUP BY package ORDER BY COUNT(time) DESC;
-- 9.6 Give the package ranking (based on how many times it was downloaded)-- during 9AM to 11AM

SELECT package,COUNT(time) FROM cran_logs WHERE time BETWEEN '09:00:00' AND '11:00:00' GROUP BY package ORDER BY COUNT(time) DESC;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT COUNT(time) FROM cran_logs WHERE country IN ('CN','JP','SG');
-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
SELECT country FROM cran_logs GROUP BY country HAVING COUNT(time) >(SELECT COUNT(time) FROM cran_logs WHERE country='CN');
-- 9.9 Print the average length of the package name of all the UNIQUE packages
SELECT AVG(length(package)) FROM (SELECT DISTINCT package FROM cran_logs) AS pa;
-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
SELECT package,COUNT(time) FROM cran_logs GROUP BY package ORDER BY COUNT(time) DESC LIMIT 1 OFFSET 1;

SELECT package,COUNT(time) FROM cran_logs GROUP BY package ORDER BY COUNT(time) DESC;
-- 9.11 Print the name of the package whose download count is bigger than 1000.
SELECT package FROM cran_logs GROUP BY package HAVING COUNT(time) >1000;
-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
SELECT r_os,COUNT(time),CAST( (COUNT(time)*100/(SELECT COUNT(time) FROM cran_logs)) AS FLOAT) AS proportion FROM cran_logs GROUP BY r_os;
