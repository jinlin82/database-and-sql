-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
-- 找出已经进行手术，但手术还未认证的医生
SELECT p.name
FROM physician p ,
(SELECT physician,procedures FROM undergoes
EXCEPT
SELECT physician,treatment FROM trained_in) p1
WHERE p.employeeid = p1.physician;

-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
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
-- 找出已经进行手术，并且手术已经认证的医生，但是该手术是在医生认证过期之后的某日进行的
SELECT p.name
FROM undergoes u JOIN procedures pr ON pr.code = u.procedures
                JOIN trained_in t ON t.physician = u.physician AND t.treatment = u.procedures
                JOIN physician p ON p.employeeid = t.physician
WHERE u.dateundergoes > t.certificationexpires;

-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
-- 医生名，手术名，手术进行的时间，对应患者，认证过期的时间
SELECT 
        p.name AS physician_name,
        pr.name AS procedure_name,
        u.dateundergoes AS date,
        pa.name AS patient_name,
        t.certificationexpires
FROM undergoes u JOIN procedures pr ON pr.code = u.procedures
                JOIN trained_in t ON t.physician = u.physician AND t.treatment = u.procedures
                JOIN physician p ON p.employeeid = t.physician
                JOIN patient pa ON pa.SSN = u.patient
WHERE u.dateundergoes > t.certificationexpires;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.

-- 这样PCP出现的是医生id,并非医生姓名
SELECT
        pa.name AS patient_name,
        p.name AS physician_name,
        n.name AS nurse_name,
        a.starts,
        a.ends,
        pa.PCP
FROM appointment a
JOIN physician p ON a.physician = p.employeeid
JOIN patient pa ON pa.SSN = a.patient
LEFT JOIN nurse n ON n.employeeid = a.prepnurse
WHERE a.patient != pa.PCP;

-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

--Undergoes 表可能包含患者 ID 与我们通过 Undergoes.Stay 外键从 Stay 表中获得的 患者ID 不匹配的行。 从 Undergoes 中选择所有表现出这种不一致的行。
SELECT *
FROM undergoes u
WHERE patient !=(select s.patient
                FROM stay s
                WHERE u.stay = s.stayid);

-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.

--获取 123 房间所有值班护士的姓名
SELECT n.name
FROM nurse n
WHERE employeeid in(select oc.nurse
                    FROM on_call oc
                    JOIN room r ON oc.blockcode = r.blockcode AND oc.blockfloor = r.blockfloor
                    WHERE r.roomnumber = 123);

-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
--医院有几个检查室，用于预约。 获取每个检查室场的预约次数

SELECT examinationroom,count(appointmentid)
FROM appointment
GROUP BY examinationroom;

-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

--获取所有患者的姓名（还包括，对于每个患者，患者的初级保健医生的姓名），使得以下为真：
     -- 患者已由他/她的初级保健医生开具了一些药物。
     -- 患者接受了一项费用超过 5,000 美元的手术
     -- 患者至少有两次预约，其中准备预约的护士是注册护士。
     -- 患者的初级保健医生不是任何部门的负责人。

SELECT
        pa.name AS patient_name,
        ph.name AS physician_name
FROM patient pa
JOIN physician ph ON ph.employeeid = pa.PCP
WHERE EXISTS(select * FROM prescribes pr
            WHERE pr.patient = pa.SSN AND pr.physician = pa.PCP)
     AND EXISTS(SELECT * FROM undergoes u, procedures pr
                WHERE u.procedures = pr.Code
                        AND u.Patient = pa.SSN
                        AND Pr.Cost > 5000)
      AND( SELECT COUNT(A.AppointmentID) FROM appointment a, nurse n
          WHERE a.PrepNurse = n.EmployeeID
            AND n.Registered = TRUE)>=2
      AND NOT pa.PCP IN
       (SELECT Head FROM Department);
