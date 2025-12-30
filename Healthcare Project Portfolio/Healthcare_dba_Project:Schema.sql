DROP DATABASE IF EXISTS HealthcareProject;
CREATE DATABASE HealthcareProject;
USE HealthcareProject;

-- LET'S CREATE THE TABLES 
-- PATIENTS TABLE
CREATE TABLE Patients (
PatientID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DOB DATE,
Gender ENUM('Male', 'Female','Other'),
Phone VARCHAR(50)
);

-- DOCTORS TABLES
CREATE TABLE Doctors (
DoctorID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Phone VARCHAR(50)
);

-- SPECIALTIES
CREATE TABLE Specialties (
SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
SpecialtyName VARCHAR(50) UNIQUE NOT NULL
);

-- DOCTOR SPECIALTIES
CREATE TABLE DoctorSpecialties (
DoctorID INT,
SpecialtyID INT,
PRIMARY KEY (DoctorID, SpecialtyID),
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);

-- APPOINTMENTS
CREATE TABLE Appointments(
AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
PatientID INT NOT NULL,
DoctorID INT NOT NULL,
AppointmentDate DATETIME NOT NULL,
Reason VARCHAR(2550),
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- BILLING
CREATE TABLE Billing (
BillingID INT AUTO_INCREMENT PRIMARY KEY,
AppointmentID INT UNIQUE,
Amount DECIMAL(10,2),
PaymentStatus ENUM('Paid', 'Pending', 'Cancelled') DEFAULT 'Pending',
FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- LET'S INSERT THE DATA TO THE TABLES
INSERT INTO Patients (FirstName, LastName, DOB, Gender, Phone)
VALUES
('John', 'Carter', '1985-05-12', 'Male', '555-1010'),
('Emily', 'Stone', '1990-11-23', 'Female', '555-2020'),
('Michael', 'Lee', '1978-07-08', 'Male', '555-3030');

INSERT INTO Doctors (FirstName, LastName, Phone)
VALUES
('Sarah', 'Mitchell', '555-1111'),
('David', 'Nguyen', '555-2222'),
('Olivia', 'Wright', '555-3333');

INSERT INTO Specialties (SpecialtyName)
VALUES
('Cardiology'), ('Dermatology'), ('Pediatrics'), ('Orthopedics');

INSERT INTO DoctorSpecialties VALUES
(1, 1), -- Dr. Mitchell - Cardiology
(2, 2), -- Dr. Nguyen - Dermatology
(3, 3), -- Dr. Wright - Pediatrics
(3, 4); -- Dr. Wright - Orthopedics (multi-specialty)

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason)
VALUES
(1, 1, '2024-04-10 09:00:00', 'Chest Pain'),
(1, 2, '2024-04-11 10:30:00', 'Skin Rash'),
(2, 3, '2024-04-12 13:00:00', 'Child Fever (Mother consult)'),
(3, 1, '2024-04-15 15:00:00', 'Follow-up Check');

INSERT INTO Billing (AppointmentID, Amount, PaymentStatus)
VALUES
(1, 250.00, 'Paid'),
(2, 150.00, 'Pending'),
(3, 175.00, 'Paid'),
(4, 300.00, 'Pending');