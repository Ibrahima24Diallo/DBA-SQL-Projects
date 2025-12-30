-- STORED PROCEDURE
-- 1. Get Patient's information based on PatientID
DELIMITER $$
CREATE PROCEDURE GetPatientHistory(IN patID INT)
BEGIN
    SELECT a.AppointmentDate, a.Reason, d.FirstName AS DoctorFirst, d.LastName AS DoctorLast
    FROM Appointments a
    JOIN Doctors d ON a.DoctorID = d.DoctorID
    -- WHERE a.PatientID = patID
    ORDER BY a.AppointmentDate DESC;
END$$
DELIMITER ;

-- 2. Get Doctor Revenue by Date Range
-- Calculates revenue for a doctor within a specific date range.
DELIMITER $$
CREATE PROCEDURE DoctorRevenueByRange(IN DoctID INT, IN StartDate DATE, IN EndDate DATE)
	BEGIN 
		SELECT d.FirstName AS DocFirstName, d.LastName AS DocLastName, SUM(b.amount) AS TotalRevenue
        FROM Doctors d
        JOIN Appointments a ON d.DoctorID = a.DoctorID
        JOIN Billing b ON a.appointmentID = b.appointmentID
        WHERE d.DoctorID = DoctID
        AND a.appointmentDate BETWEEN StartDate AND EndDate 
        GROUP BY d.DoctorID;
	END $$
DELIMITER ;
-- LET'S TEST THE PROCEDURE
CALL DoctorRevenueByRange(1, '2024-03-15', '2024-04-15');

-- 3. Add new appointment and Billing Record
-- Simulates inserting business data safely through a procedure
DELIMITER $$ 
CREATE PROCEDURE AppointmentWithBilling (IN PatID INT, IN DocID INT, 
		IN AppDate DATETIME, IN Reason VARCHAR(255), IN BillAmount DECIMAL(10,2)
		)
BEGIN
	DECLARE NewAppointmentID INT;
    
    INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason)
    VALUES (PatID, DocID, AppDate, Reason);
    
    SET NewAppointmentID = LAST_INSERT_ID();
    
    INSERT INTO Billing (AppointmentID, Amount, PaymentStatus)
    VALUES (NewAppointmentID, BillAmount, 'Pending');
END $$
DELIMITER ;
drop procedure AppointmentWithBilling;

CALL AppointmentWithBilling(2, 1, '2024-05-01', 'Routine Checkup', 200.00);
    

















