-- Movie_theatres

-- 4.1 Select the title of all movies.
SELECT title from movies;
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT rating FROM movies;
-- 4.3  Show all unrated movies.
SELECT * from movies;
SELECT * from movies
WHERE rating is null;
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT * from movietheaters
WHERE movie is null;
-- 4.5 Select all data from all movie theaters 
--     and, additionally, the data from the movie that is being shown in the
--     theater (if one is being shown).
SELECT * from movietheaters
left OUTER JOIN movies on movietheaters.movie=movies.code;
-- 4.6 Select all data from all movies and, if that movie is being shown in a
-- theater, show the data from the theater.
SELECT * from movietheaters
inner JOIN movies on movietheaters.movie=movies.code;

-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT title
from movies
WHERE movies.code not in( SELECT movie from movietheaters WHERE movie is not null);
-- 4.8 Add the unrated movie "One, Two, Three".
insert into movies(code,title,rating)
VALUES(999,'One, Two, Three',null)
;

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE movies
set rating='G'
WHERE rating is NULL;
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE from movietheaters
WHERE movietheaters.movie in 
(SELECT code from movies
WHERE movies.rating='NC-17');
