--**************exercise4************
-- Movie_theatres
select* from movies;
SELECT * from movietheaters;

-- 4.1 Select the title of all movies.
select title from movies;

-- 4.2 Show all the distinct ratings in the database.
select distinct rating from movies;

-- 4.3  Show all unrated movies.
select * from movies where rating is NULL;

-- 4.4 Select all movie theaters that are not currently showing a movie.
select * from MovieTheaters where Movie is NULL;


-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT* from movies,movietheaters WHERE movies.code = movietheaters.movie;

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * from movies left JOIN movietheaters on movies.code = movietheaters.movie;

-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT title from movies where code not in (SELECT movie from movietheaters where movie is not null);

-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies VALUES(10,'One, Two, Three',NULL);

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies SET Rating = 'G' WHERE Rating is NULL;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
delete from MovieTheaters where Movie in (select Code from Movies where Rating = 'NC-17');