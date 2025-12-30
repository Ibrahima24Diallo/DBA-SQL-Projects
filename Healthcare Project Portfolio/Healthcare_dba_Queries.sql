-- SQL Queries for Healthcare Project

-- 1. Total appointments per doctor
SELECT a.DoctorID, FirstName, LastName, COUNT(appointmentID) AS total_appt
FROM Appointments a 
LEFT JOIN Doctors d ON A.DoctorID = d.DoctorID
GROUP BY a.DoctorID, FirstName, LastName
ORDER BY a.DoctorID;

-- 2. Patients with more than one appointment
SELECT p.patientID, FirstName, LastName, COUNT(appointmentID) AS Number_Visits
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, FirstName, LastName
HAVING Number_Visits > 1;

-- 3. Revenue per doctor
SELECT d.DoctorID, d.FirstName, d.LastName, SUM(b.Amount) AS Total_Revenue
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
JOIN Billing b ON a.AppointmentID = b.AppointmentID
GROUP BY d.DoctorID, d.FirstName, d.LastName
ORDER BY Total_Revenue DESC;

-- 4. Display all the Doctors and their specialties
SELECT d.FirstName, d.LastName, s.SpecialtyName
FROM Doctors d 
JOIN DoctorSpecialties ds ON d.DoctorID = ds.DoctorID
JOIN Specialties s ON ds.SpecialtyID = s.SpecialtyID;

-- 5. DSiplay patients with the Most common appointment reasons
SELECT p.FirstName, p.LastName, a.reason, COUNT(a.Reason) AS Common_Reason
FROM patients p 
JOIN Appointments  a ON p.PatientID = a.PatientID 
GROUP BY p.FirstName, p.LastName, a.reason
ORDER BY Common_Reason;

-- 6. Patients with a Pending payments
SELECT p.FirstName, p.LastName, b.Amount, b.PaymentStatus
FROM patients p 
JOIN Appointments  a ON p.PatientID = a.PatientID 
JOIN Billing b ON a.AppointmentID = b.AppointmentID
WHERE PaymentStatus = 'Pending';

-- 7. CTE: Identify high-value patients who spent more than 200
WITH High_Value_Patients AS (
	SELECT p.FirstName, p.LastName, SUM(b.Amount) AS Total_Spent
	FROM patients p 
	JOIN Appointments a ON p.PatientID = a.PatientID 
	JOIN Billing b ON a.AppointmentID = b.AppointmentID
	GROUP BY p.FirstName, p.LastName
	) 
SELECT *
FROM High_Value_Patients
WHERE Total_Spent > 200
ORDER BY Total_Spent DESC;

-- 8. Window function: Rank doctors by revenue
SELECT d.FirstName, d.LastName, SUM(b.amount) AS Total_Revenue, 
		RANK() OVER (ORDER BY SUM(b.amount) DESC) AS Rank_Revenue
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
JOIN Billing b ON a.AppointmentID = b.AppointmentID
GROUP BY d.FirstName, d.LastName;


	






























