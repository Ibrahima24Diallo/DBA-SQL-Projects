-- CREATING A TRIGGER THAT PREVENTS INSERTING AN ORDER WHERE total_paid < 0

CREATE TRIGGER trg_Prevent_Negative_Total
ON Orders 
AFTER INSERT 
AS 
BEGIN

		-- Checking if any of the newly inserted rows (order) have a total amount of less than 0 
		IF EXISTS (
			SELECT 1
			FROM inserted
			WHERE Total_Paid < 0
		)
		BEGIN
			-- Prevent the insertion by raising an ERROR MESSAGE and showing the severity level of the error.
			RAISERROR('SORRY, INSERTION FAILED: Total_Paid cannot be less than 0', 16, 1);
			-- THROW 50001, 'SORRY, INSERTION FAILED: Total_Paid cannot be less than 0', 1;

			ROLLBACK TRANSACTION; -- Undoing the insertion to ensure data integrity 
		END

END;