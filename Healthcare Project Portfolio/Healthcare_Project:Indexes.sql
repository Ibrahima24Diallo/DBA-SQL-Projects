-- Indexes ( Improve Query Performance)
-- 1. Create an index on the PatientID column of the Appointments table
CREATE INDEX idx_appointments_patient ON Appointments(PatientID);

-- 2. Create an index on the DoctorID column of the Appointments table
CREATE INDEX idx_appointments_doctor ON Appointments(DoctorID);

-- 3. Create an index on the PaymentStatus column of the Billing table
CREATE INDEX idx_billing_status ON Billing(PaymentStatus);