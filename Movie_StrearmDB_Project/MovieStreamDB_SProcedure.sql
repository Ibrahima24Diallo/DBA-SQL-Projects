   -- CREATE STRORED PROCEDURES THAT CAN BE CALLED REPEATEDLY

-- 1. Create a SQL statement that displays the date, title and the duration of the movie 
-- whenever you call the UserID

CREATE PROCEDURE usp_GetUserWatchHistory
    @UserID INT
AS
BEGIN
    SELECT w.WatchDate, w.WatchDuration, m.Title
    FROM WatchHistory w
    JOIN Movies m ON w.MovieID = m.MovieID
    WHERE w.UserID = @UserID
    ORDER BY w.WatchDate DESC;
END;

EXEC usp_GetUserWatchHistory @UserID = 1;

GO

-- 2. Create a query that displays the number of movies watched since the user became member
-- whenever you call their UserID and last name. 

CREATE PROCEDURE usp_MoviesWatched_Since_SignUP
    @UserID INT, @LastName VARCHAR(50)
AS
    BEGIN
    SELECT u.USerID, SignupDate, PlanType, COUNT(wh.WatchID) AS Num_Movies_Watched, 
            CONCAT(DATEDIFF(YEAR, SignupDate, GETDATE()), ' Year',
            CASE 
                WHEN DATEDIFF(YEAR, SignupDate, GETDATE()) = 1 THEN ''
                ELSE 's'
            END
            ) AS Years_Subscbribed
    FRom  Users u 
    JOIN Subscriptions s ON u.UserID = s.UserID
    JOIN WatchHistory wh ON s.UserID = wh.UserID
    WHERE u.UserID = @UserID
    And LastName = @LastName
    GROUP BY u.USerID, SignupDate, PlanType
END;

EXEC usp_MoviesWatched_Since_SignUP @UserID = 4, @LastName = 'Diallo';