-- Movie_theatres
-- 4.1 Select the title of all movies.
SELECT * FROM movies;
SELECT * FROM movietheaters;
SELECT title FROM movies;
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT rating FROM movies;
-- 4.3  Show all unrated movies.
SELECT title FROM movies WHERE rating is NULL;
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT code,name FROM movietheaters WHERE movie is NULL;

-- 4.5 Select all data from all movie theaters
--     and, additionally, the data from the movie that is being shown in the
--     theater (if one is being shown).
SELECT * from movietheaters AS a LEFT JOIN movies AS b ON a.movie=b.code;

SELECT DISTINCT
        MainTable.warehouse ,
        COALESCE(SubTable.SubNum,0) AS TotalNum
FROM    boxes AS MainTable
LEFT JOIN (
           SELECT   warehouse ,
                    COUNT(1) AS SubNum
           FROM     boxes
           GROUP BY warehouse
          ) AS SubTable ON MainTable.warehouse = SubTable.warehouse;
-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * from movies AS a LEFT JOIN movietheaters AS b ON a.code=b.movie;
-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT title FROM movies WHERE code NOT IN (SELECT movie from movietheaters WHERE movie is not NULL)
-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies VALUES(9,'One, Two, Three',NULL);

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies SET rating='G' WHERE rating is NULL;
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM movietheaters WHERE movie in (SELECT code FROM movies WHERE rating='NC-17');