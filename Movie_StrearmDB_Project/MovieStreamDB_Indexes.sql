-- CREATE INDEXES TO OPTIMIZE THE PERFORMANCE

CREATE INDEX idx_WatchHistory_UserID ON WatchHistory(UserID);

CREATE INDEX idx_WatchHistory_MovieID ON WatchHistory(MovieID);
