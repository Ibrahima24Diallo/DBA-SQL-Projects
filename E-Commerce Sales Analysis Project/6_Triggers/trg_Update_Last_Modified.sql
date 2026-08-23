-- CREATE A TRIGGER THAT AUTOMATICALLY UPDATES A "LAST_MODIFIED" COLUMN 
-- WHENEVER AN ORDER RECORD IS UPDATED.

-- 1) Let's create a column named Last_Modified and add it to the Orders table
ALTER TABLE Orders 
ADD Last_Modified DATETIME(2) 
CONSTRAINT DFTL_Orders_Last_Modified DEFAULT SYSDATETIME();

-- 2) CREATING THE TRIGGER
CREATE TRIGGER trg_Set_Last_Modified
ON Orders
AFTER UPDATE
AS 
BEGIN
      
        UPDATE O
        SET Last_Modified = SYSDATETIME()
        FROM Orders o
        INNER JOIN inserted i On o.Order_ID = i.Order_ID;
 
 END;