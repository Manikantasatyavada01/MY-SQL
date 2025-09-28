select *from healthcare_dataset;
--  2. Show all doctors with their specialization.
alter table healthcare_dataset rename column `medical condition` to medical_condition;
select doctor, medical_condition from healthcare_dataset;
--  3. Display all hospitals available in the dataset.
select hospital from healthcare_dataset;
--  4. Find all admissions of type Emergency
alter table healthcare_dataset rename column `admission type` to admission_type;
select * from healthcare_dataset where admission_type='emergency';
--  5. Retrieve patients whose age is between 30 and 50.
select *from healthcare_dataset where age between 30 and 50;
--  6. Show patients whose names start with ‘A’.
select *from healthcare_dataset where name like 'A%';
--  7. Display patients with blood type IN (‘A+’, ‘O-’)
alter table healthcare_dataset rename column `blood type` to BLOOD_TYPE;
select *from healthcare_dataset where blood_type in('A+','O-');
-- 8. Show admissions made in January 2023
alter table healthcare_dataset rename column `DATE OF ADMISSION` to DATE_OF_ADMISSION;
select *from healthcare_dataset where STR_TO_DATE(DATE_OF_ADMISSION, '%d-%m-%Y') 
      BETWEEN '2023-01-01' AND '2023-01-31';
--  9. Find the total billing amount per hospital
alter table healthcare_dataset rename column `BILLING AMOUNT` to BILLING_AMNT;
select hospital,SUM(BILLING_AMNT) as total_bill_amnt from healthcare_dataset
		group by hospital;
--  10. Show the average billing per doctor.
select doctor,avg(BILLING_AMNT) as avg_bill_dctr from healthcare_dataset group by doctor;
--  11. Retrieve patients along with their assigned doctor and hospital name.
select name,doctor,hospital from healthcare_dataset ;
--  12. List doctors and the number of patients they treated.
select doctor,count(name) from healthcare_dataset group by doctor;
--  13. Find doctors who treated patients in more than one hospital.
select doctor,count(distinct hospital) as hospital_count from healthcare_dataset 
	group by doctor having hospital_count>1;
--  14. Display patients who were not billed.
select name from healthcare_dataset where 
billing_amnt IS NULL OR Billing_Amnt = 0;
-- 15. Find the oldest patient.
select name,age from healthcare_dataset order by age desc limit 1;
--  16. Show the youngest patient.
select name,age from healthcare_dataset order by age  limit 1;
-- 17. List the most common medical condition among patients.
SELECT Medical_Condition, COUNT(*) AS condition_count
FROM healthcare_dataset
GROUP BY Medical_Condition
ORDER BY condition_count DESC
LIMIT 1;
-- 18. Retrieve hospitals and the total number of admissions per hospital.
select hospital,count(name) as total_num_admission from healthcare_dataset group by hospital;
-- 19. Show patients who stayed more than 10 days.
alter table healthcare_dataset rename column `DISCHARGE DATE` TO DISCHARGE_DATE;
SELECT Name
FROM healthcare_dataset
WHERE DATEDIFF(STR_TO_DATE(Discharge_Date, '%d-%m-%Y'),
               STR_TO_DATE(Date_of_Admission, '%d-%m-%Y')) > 10;
--  20. Retrieve the top 3 hospitals with the highest total billing.
select hospital,sum(billing_amnt) as total_bill from healthcare_dataset
 group by hospital order by total_bill desc limit 3;
-- 21. Find doctors earning more than the average billing amount (based on bills assigned to them).
select doctor ,avg(billing_amnt) as more_than_avg_bill from healthcare_dataset
group by doctor having more_than_avg_bill >
(select avg(billing_amnt)  from healthcare_dataset);
--  22. Show distinct admission types.
select distinct admission_type from healthcare_dataset;
-- 23. Retrieve patients who have the same medical condition (self-join).
SELECT p1.name AS patient1, p2.name AS patient2, p1.medical_condition
FROM healthcare_dataset p1
JOIN healthcare_dataset p2 
  ON p1.medical_condition = p2.medical_condition
  AND p1.name < p2.name;

--  24. Find patients who were admitted in February 2023 but not in March 2023 (set difference).
select name  from healthcare_dataset where 
STR_TO_DATE(DATE_OF_ADMISSION, '%d-%m-%Y') 
      BETWEEN '2023-02-01' AND '2023-02-28' and
      name not in(select name from healthcare_dataset where str_to_date(DATE_OF_ADMISSION, '%d-%m-%Y') 
      BETWEEN '2023-03-01' AND '2023-03-31');

--  25. Find patients who were admitted in both January and February 2023 (set intersection).
SELECT distinct name 
FROM healthcare_dataset 
 WHERE name IN (
    SELECT name FROM healthcare_dataset WHERE MONTH(date_of_admission) = 1 and year(date_of_admission)=2023
)
and name IN (
    SELECT name FROM healthcare_dataset WHERE MONTH(date_of_admission) = 2 and year(date_of_admission)=2023
);