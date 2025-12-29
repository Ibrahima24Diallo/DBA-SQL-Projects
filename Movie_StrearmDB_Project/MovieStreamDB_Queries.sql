-- MOVIE STREAMING SQL QUERIES

-- 1. Most watched movies (by total watch time)
SELECT m.Title, SUM(WatchDuration) AS Total_Watch_Time
FROM MovieStreamingDB..Movies m
JOIN MovieStreamingDB..WatchHistory wh
ON m.MovieID = wh.MovieID
GROUP BY m.MovieID, m.Title
ORDER BY Total_Watch_Time DESC;

-- 2. Most active users
SELECT  CONCAT(FirstName, ' ', LastName) AS Full_Name, COUNT(WatchDuration) AS Most_Active_Users
FROM MovieStreamingDB..Users u
JOIN MovieStreamingDB..WatchHistory wh
ON u.UserID = wh.UserID
GROUP BY  CONCAT(FirstName, ' ', LastName)
ORDER BY Most_Active_Users DESC;

-- 3. Movie popularity by number of plays
SELECT m.Title, COUNT(m.MovieID) AS Num_Plays
FROM MovieStreamingDB..Movies m
JOIN MovieStreamingDB..WatchHistory wh 
ON m.MovieID = wh.MovieID
GROUP BY Title
ORDER BY Num_Plays DESC;

SELECT U.USERID, FIRSTNAME 
FROM MovieStreamingDB..Users u
JOIN MovieStreamingDB..WatchHistory wh 
ON u.userID = wh.userID
Join Movies m ON wh.MovieID = m.MovieID
WHERE m.title = 'Toy Story';

-- 4. Display sign up of new users per month (Using DATENAME OR DATEPART)
-- DATENAME: extract a specified part of a date/time value and return it as a character string
-- DATEPART: returns an integer representing a specific part of a given date or time value. 
SELECT DATENAME(mm, SignupDate) AS Months, Count(UserID) AS New_Users
FROM MovieStreamingDB..Users 
GROUP BY DATENAME(mm, SignupDate)
ORDER BY Months;

-- 5. Show users who watched more than one movie
SELECT CONCAT(FirstName,' ', LastName) AS Full_Name, 
		COUNT(wh.WatchID) AS Num_Movies_Watched
FROM MovieStreamingDB..Users u
JOIN MovieStreamingDB..WatchHistory wh 
Join Movies m ON wh.MovieID = m.MovieID
ON u.userID = wh.userID
GROUP BY CONCAT(FirstName,' ', LastName)
HAVING COUNT(wh.WatchID) > 1;

-- 6. Movies watched by genre
SELECT g.Genrename, COUNT(wh.MovieID) AS Genre_Watched
FROM WatchHistory wh
JOIN MovieGenres mg ON wh.MovieID = mg.MovieID
JOIN Genres g ON mg.GenreID = g.GenreID
GROUP BY g.Genrename
ORDER BY Genre_Watched DESC;

-- 7. CTE: Top 2 users by total watch time
WITH TopUserrs  AS (
	SELECT u.UserID, CONCAT(FirstName,' ', LastName) AS Full_Name,
			SUM(wh.WatchDuration) AS Total_WatchTime
	FROM Users u
	JOIN WatchHistory wh 
	ON u.UserID = wh.UserID
	GROUP BY u.UserID, CONCAT(FirstName,' ', LastName)
)
SELECT TOP 2 UserID AS Top_UsersID, Full_Name, Total_WatchTime
from TopUserrs
ORDER BY Total_WatchTime DESC;

-- 8. Window function: Rank movies by popularity
SELECT Title, COUNT(m.MovieID) AS Num_Plays,
		RANK() OVER (ORDER BY COUNT(m.MovieID) DESC) AS Rank_By_Popolarity
FROM MovieStreamingDB..Movies m
LEFT JOIN MovieStreamingDB..WatchHistory wh 
ON m.MovieID = wh.MovieID
GROUP BY Title
ORDER BY Num_Plays DESC;

SELECT Title,
       COUNT(w.MovieID) AS PlayCount,
       RANK() OVER (ORDER BY COUNT(w.MovieID) DESC) AS PopularityRank
FROM Movies m
LEFT JOIN WatchHistory w ON m.MovieID = w.MovieID
GROUP BY Title;



SELECT UserID, SignupDate,
       ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY SignupDate DESC) AS rn
FROM Users;

SELECT UserID, COUNT(*) AS TotalSubs,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank
FROM Subscriptions
GROUP BY UserID;

SELECT UserID, StartDate,
       LAG(StartDate) OVER (PARTITION BY UserID ORDER BY StartDate) AS PreviousStart
FROM Subscriptions;

SELECT StartDate,
       COUNT(*) OVER (ORDER BY StartDate) AS RunningTotal
FROM Subscriptions;
