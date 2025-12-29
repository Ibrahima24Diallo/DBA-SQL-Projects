CREATE DATABASE MovieStreamingDB;
GO

USE MovieStreamingDB;
GO

-- USERS TABLE
CREATE TABLE Users (
    UserID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE NOT NULL,
    SignupDate DATE NOT NULL
);

-- SUBSCRIPTIONS TABLE
CREATE TABLE Subscriptions (
    SubID INT IDENTITY PRIMARY KEY,
    UserID INT NOT NULL,
    PlanType VARCHAR(20), -- Basic, Standard, Premium
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- MOVIES TABLE
CREATE TABLE Movies (
    MovieID INT IDENTITY PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    ReleaseYear INT,
    DurationMinutes INT,
    Rating VARCHAR(10) -- PG, PG-13, R
);

-- GENRES TABLE
CREATE TABLE Genres (
    GenreID INT IDENTITY PRIMARY KEY,
    GenreName VARCHAR(50) UNIQUE NOT NULL
);

-- MOVIE GENRES (many-to-many)
CREATE TABLE MovieGenres (
    MovieID INT,
    GenreID INT,
    PRIMARY KEY (MovieID, GenreID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- WATCH HISTORY TABLE
CREATE TABLE WatchHistory (
    WatchID INT IDENTITY PRIMARY KEY,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    WatchDate DATETIME NOT NULL,
    WatchDuration INT NOT NULL, -- minutes watched
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- INSERTING DATA INTO TABLES

INSERT INTO Users (FirstName, LastName, Email, SignupDate)
VALUES
('Jule', 'Badji', 'julebaj@gmail.com', '2024-01-01'),
('Siks', 'Ndiaye', 's.ndiaye@yahoo.com', '2024-02-15'),
('Jennifer', 'Morrison', 'jenny.md@gmail.com', '2024-03-01'),
('Ibama', 'Diallo', 'ibdiallo@gmail.com', '2024-04-24'),
('Veronica', 'Peck', 'v.peck@aol.com', '2024-05-03'),
('Dylan', 'Peck', 'dylan.p14@gmail.com', '2024-05-10');

INSERT INTO Subscriptions (UserID, PlanType, StartDate, EndDate)
VALUES
(1, 'Premium', '2024-01-01', NULL),
(2, 'Basic', '2024-02-15', NULL),
(3, 'Standard', '2024-03-01', NULL);

INSERT INTO Subscriptions (UserID, PlanType, StartDate, EndDate)
VALUES
(4, 'Premium', '2024-04-24', NULL),
(5, 'Basic',  '2024-05-03', NULL),
(6, 'Standard', '2024-05-10', NULL);



INSERT INTO Movies (Title, ReleaseYear, DurationMinutes, Rating)
VALUES
('Inception', 2010, 148, 'PG-13'),
('The Matrix', 1999, 136, 'R'),
('Toy Story', 1995, 81, 'G'),
('John Wick', 2014, 101, 'R'),
('Gladiator', 2000, 171, 'R');

INSERT INTO Genres (GenreName)
VALUES ('Action'), ('Sci-Fi'), ('Animation'), ('Drama'), ('Thriller');

INSERT INTO MovieGenres (MovieID, GenreID)
VALUES
(1, 2), -- Inception = Sci-Fi
(1, 5), -- Thriller
(2, 1), -- Matrix = Action
(2, 2), -- Sci-Fi
(3, 3), -- Toy Story = Animation
(4, 1), -- John Wick = Action
(4, 5), -- Thriller
(5, 1), -- Gladiator = Action
(5, 4); -- Gladiator = Drama

INSERT INTO WatchHistory (UserID, MovieID, WatchDate, WatchDuration)
VALUES
(1, 1, '2024-04-10', 120),
(1, 2, '2024-04-11', 100),
(2, 3, '2024-04-12', 81),
(3, 4, '2024-04-15', 90),
(3, 1, '2024-04-16', 148),
(4, 5, '2024-04-24', 171),
(4, 2, '2024-04-30', 120),
(5, 3, '2024-05-10', 110),
(5, 4, '2024-05-15', 100),
(6, 5, '2024-05-15', 130),
(6, 3, '2024-05-30', 181);

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

select *
from MovieStreamingDB..Subscriptions