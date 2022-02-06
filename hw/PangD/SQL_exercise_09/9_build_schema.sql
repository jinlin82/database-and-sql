--cran_logs_2015-01-01

create database db9;

\c db9;

create table cran_logs(
    date varchar(200),
    time varchar(200),
    size varchar(200),
    r_version varchar(200),
    r_arch varchar(200),
    r_os varchar(200),
    package varchar(200),
    version varchar(200),
    country varchar(200),
    ip_id varchar(200));

\copy cran_logs from 'SQL-exercise-without-solutions\SQL_exercise_09\cran_logs_2015-01-01.csv' with (format csv,header true,quote '"',DELIMITER ',');

\copy cran_logs from './cran_logs_2015-01-01.csv' with (format csv,header true,quote '"',DELIMITER ',');
