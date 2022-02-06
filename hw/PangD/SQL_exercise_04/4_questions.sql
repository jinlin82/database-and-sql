-- Movie_theatres
-- 4.1 Select the title of all movies.
SELECT * FROM movies;
SELECT title FROM movies;
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT rating FROM movies;
-- 4.3  Show all unrated movies.
SELECT title FROM movies WHERE rating IS NULL;
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT * FROM movietheaters;
SELECT name FROM movietheaters WHERE movie IS NULL;
-- 4.5 Select all data from all movie theaters
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT * FROM movies m RIGHT JOIN movietheaters mt ON m.code = mt.movie;
-- 4.6 Select all data from all movies and, if that movie is being shown in a
-- theater, show the data from the theater.
SELECT * FROM movies m LEFT JOIN movietheaters mt ON m.code = mt.movie;
-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT m.title FROM movies m LEFT JOIN movietheaters mt ON m.code = mt.movie
WHERE mt.name IS NULL;
-- 4.8 Add the unrated movie "One, Two, Three".
SELECT * FROM movies;
INSERT INTO movies
VALUES (9,'One,Two,Three',NULL);
-- 4.9 Set the rating of all unrated movies to "G".
UPDATE movies
SET rating = 'G' WHERE rating IS NULL;
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
SELECT * FROM movietheaters;
DELETE FROM movietheaters WHERE movie IN (SELECT code FROM movies WHERE rating = 'NC-17');