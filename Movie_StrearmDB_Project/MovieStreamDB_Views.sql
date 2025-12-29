-- USE VIEW TO CREATE VIRTUAL TABLES FROM THE ORIGINAL TABLES

-- 1. This command creates a View that displays Movies watched by genre.
CREATE VIEW Watched_By_Genre AS
SELECT g.GenreName, COUNT(wh.MovieID) AS Genre_Watched
FROM WatchHistory wh
JOIN MovieGenres mg ON wh.MovieID = mg.MovieID
JOIN Genres g ON mg.GenreID = g.GenreID
GROUP BY g.Genrename;

GO 
-- 2. This command creates a View to display the popularity of a movie by number of plays
CREATE VIEW Movie_By_Popularity AS
SELECT m.Title,
       COUNT(wh.MovieID) AS PlayCount
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.Title;

