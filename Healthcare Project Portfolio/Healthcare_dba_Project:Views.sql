-- WORKING WIH VIEWS

-- 1. Create View to store high Value patients
CREATE VIEW ValuedPatients AS
SELECT p.patientID, CONCAT(p.FirstName,' ',p.LastName) AS Full_Name, 
		CONCAT('$',SUM(b.Amount)) AS Total_Spent
FROM patients p 
JOIN Appointments a ON p.PatientID = a.PatientID 
JOIN Billing b ON a.AppointmentID = b.AppointmentID
GROUP BY p.patientID, p.FirstName, p.LastName
ORDER BY Total_Spent DESC;

-- 2. Patient Visit summary
-- Gives a quick overview of how often each patient visits and how much they’ve spent.(Reporting)
CREATE VIEW PatientsVisitsReporting AS 
SELECT p.patientID, p.FirstName, p.LastName, COUNT(a.AppointmentID) AS Num_of_Visits, 
		COALESCE(SUM(b.amount), 0) AS Total_Spent
FROM Patients p 
JOIN Appointments a ON p.patientID = a.patientID
JOIN Billing b ON a.appointmentID =  b.appointmentID
GROUP BY p.patientID, p.FirstName, p.LastName
ORDER BY Num_of_Visits DESC;

-- 3. Doctor Appoinment Schedule
-- Shows upcoming appointments per doctor, sorted by date.
CREATE VIEW DoctorSchedule AS
SELECT CONCAT(d.FirstName, ' ', d.LastName) AS Doctor_Name, 
		CONCAT(p.FirstName,' ',p.LastName) AS Patient_Name,
        a.appointmentDate
FROM Patients p 
JOIN Appointments a ON p.patientID = a.patientID
JOIN Doctors d ON a.DoctorID =  d.DoctorID
ORDER BY a.appointmentDate;
        
