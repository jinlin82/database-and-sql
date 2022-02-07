-- 8.1 Obtain the names of all physicians that have performed a medical
-- procedure they have never been certified to perform.

select * from Trained_In;
select * from Undergoes;
select * from Procedures;
select * from Patient;
select * from Appointment;

SELECT p.name FROM physician p ,(SELECT physician,procedures FROM undergoes EXCEPT SELECT physician,treatment FROM Trained_In) p1 WHERE p.employeeid = p1.physician;

-- 8.2 Same as the previous query, but include the following information in the
-- results: Physician name, name of procedure, date when the procedure was
-- carried out, name of the patient the procedure was carried out on.
SELECT 
        p.name AS physician_name,
        pr.name AS procedure_name,
        u.dateundergoes AS date,
        pa.name AS patient_name
FROM physician p,procedures pr,undergoes u,patient pa,
(SELECT physician,procedures FROM undergoes
EXCEPT
SELECT physician,treatment FROM trained_in) p1
WHERE p.employeeid = p1.physician AND p1.procedures = pr.code AND p1.physician = u.physician
AND u.patient = pa.SSN;
-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
SELECT 
        distinct p.name AS physician_name
FROM physician p,undergoes u,Trained_In t,
(SELECT physician,procedures FROM undergoes
INTERSECT
SELECT physician,treatment FROM trained_in) p1
WHERE p.employeeid = p1.physician AND p1.procedures = u.procedures AND p1.physician = u.physician
AND u.dateundergoes>t.certificationexpires;



-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
SELECT 
        p.name AS physician_name,
        u.dateundergoes AS carried_out_date,
        t.certificationexpires AS certification_expired_date,
        pr.name AS name_of_procedure,
        pa.name AS patient_name
FROM physician p,undergoes u,Trained_In t,Procedures pr,Patient pa,
(SELECT physician,procedures FROM undergoes
INTERSECT
SELECT physician,treatment FROM trained_in) p1
WHERE p.employeeid = p1.physician AND p1.procedures = u.procedures AND p1.procedures =pr.code AND p1.physician = u.physician
AND u.dateundergoes>t.certificationexpires AND pa.ssn=u.patient;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
SELECT 
        p.name AS physician_name,
        pa.name AS patient_name
FROM physician p,Patient pa,Appointment app
WHERE pa.ssn=app.patient AND app.physician =p.employeeid AND app.physician <> pa.pcp;

SELECT
        pa.name AS patient_name,
        p.name AS physician_name,
        n.name AS nurse_name,
        a.start_,
        a.end_,
        pa.PCP
FROM appointment a
JOIN physician p ON a.physician = p.employeeid
JOIN patient pa ON pa.SSN = a.patient
LEFT JOIN nurse n ON n.employeeid = a.prepnurse
WHERE a.patient != pa.PCP;
-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.
