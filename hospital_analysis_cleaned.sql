/*
===========================================================
HOSPITAL PATIENT ANALYTICS
SQL ANALYSIS
===========================================================
Purpose:
Explore patient volume, demographics, hospital operations,
treatment costs, diagnoses, insurance, doctors, and patient
satisfaction using SQL Server.

Source table:
dbo.hospital_patient_dataset
===========================================================
*/

-- =========================================================
-- 1. PATIENT VOLUME & ADMISSIONS
-- =========================================================

-- Total number of unique patients
SELECT COUNT(DISTINCT Patient_ID) AS total_patients
FROM dbo.hospital_patient_dataset;

-- Monthly admissions
SELECT
    DATEFROMPARTS(YEAR(Admission_Date), MONTH(Admission_Date), 1) AS admission_month,
    COUNT(*) AS admitted_patients
FROM dbo.hospital_patient_dataset
GROUP BY DATEFROMPARTS(YEAR(Admission_Date), MONTH(Admission_Date), 1)
ORDER BY admission_month;

-- Admissions by admission type
SELECT
    Admission_Type,
    COUNT(*) AS admission_count
FROM dbo.hospital_patient_dataset
WHERE Admission_Type IS NOT NULL
GROUP BY Admission_Type
ORDER BY admission_count DESC;

-- Emergency admission percentage
SELECT
    COUNT(CASE WHEN Admission_Type = 'Emergency' THEN 1 END) * 100.0
        / NULLIF(COUNT(*), 0) AS emergency_admission_percentage
FROM dbo.hospital_patient_dataset;

-- Admissions in 2024 vs 2025
SELECT
    SUM(CASE
        WHEN Admission_Date >= '2024-01-01'
         AND Admission_Date < '2025-01-01' THEN 1 ELSE 0 END) AS admissions_2024,
    SUM(CASE
        WHEN Admission_Date >= '2025-01-01'
         AND Admission_Date < '2026-01-01' THEN 1 ELSE 0 END) AS admissions_2025
FROM dbo.hospital_patient_dataset;


-- =========================================================
-- 2. DEMOGRAPHICS
-- =========================================================

-- Gender distribution
SELECT
    Gender,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Gender IS NOT NULL
GROUP BY Gender
ORDER BY patient_count DESC;

-- Age range
SELECT
    MIN(Age) AS youngest_age,
    MAX(Age) AS oldest_age
FROM dbo.hospital_patient_dataset;

-- Patients by location
SELECT
    Location,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Location IS NOT NULL
GROUP BY Location
ORDER BY patient_count DESC;


-- =========================================================
-- 3. DEPARTMENT ANALYSIS
-- =========================================================

-- Patient volume by department
SELECT
    Department,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY patient_count DESC;

-- Department with the highest patient volume
SELECT TOP (1)
    Department,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY patient_count DESC;

-- Total treatment cost by department
SELECT
    Department,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY total_treatment_cost DESC;

-- Average treatment cost by department
SELECT
    Department,
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
  AND Treatment_Cost_NGN IS NOT NULL
GROUP BY Department
ORDER BY average_treatment_cost DESC;

-- Department with the highest average treatment cost
SELECT TOP (1)
    Department,
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
  AND Treatment_Cost_NGN IS NOT NULL
GROUP BY Department
ORDER BY average_treatment_cost DESC;

-- Average length of stay by department
SELECT
    Department,
    AVG(Length_of_Stay_Days) AS average_length_of_stay
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY average_length_of_stay DESC;

-- Department with the highest average length of stay
SELECT TOP (1)
    Department,
    AVG(Length_of_Stay_Days) AS average_length_of_stay
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY average_length_of_stay DESC;

-- Patient satisfaction by department
SELECT
    Department,
    AVG(Patient_Satisfaction) AS average_patient_satisfaction
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
  AND Patient_Satisfaction IS NOT NULL
GROUP BY Department
ORDER BY average_patient_satisfaction DESC;


-- =========================================================
-- 4. DIAGNOSIS ANALYSIS
-- =========================================================

-- Most common diagnosis
SELECT TOP (1) WITH TIES
    Diagnosis,
    COUNT(*) AS diagnosis_count
FROM dbo.hospital_patient_dataset
WHERE Diagnosis IS NOT NULL
GROUP BY Diagnosis
ORDER BY diagnosis_count DESC;

-- Number of unique diagnoses
SELECT COUNT(DISTINCT Diagnosis) AS unique_diagnoses
FROM dbo.hospital_patient_dataset
WHERE Diagnosis IS NOT NULL;

-- Patient volume by diagnosis
SELECT
    Diagnosis,
    COUNT(*) AS diagnosis_count
FROM dbo.hospital_patient_dataset
WHERE Diagnosis IS NOT NULL
GROUP BY Diagnosis
ORDER BY diagnosis_count DESC;

-- Total treatment cost by diagnosis
SELECT
    Diagnosis,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Diagnosis IS NOT NULL
GROUP BY Diagnosis
ORDER BY total_treatment_cost DESC;

-- Average treatment cost by diagnosis
SELECT
    Diagnosis,
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Diagnosis IS NOT NULL
GROUP BY Diagnosis
ORDER BY average_treatment_cost DESC;

-- Highest average-cost diagnosis within each department
WITH DiagnosisByDepartment AS (
    SELECT
        Department,
        Diagnosis,
        AVG(Treatment_Cost_NGN) AS average_treatment_cost,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY AVG(Treatment_Cost_NGN) DESC
        ) AS rn
    FROM dbo.hospital_patient_dataset
    WHERE Department IS NOT NULL
      AND Diagnosis IS NOT NULL
      AND Treatment_Cost_NGN IS NOT NULL
    GROUP BY Department, Diagnosis
)
SELECT
    Department,
    Diagnosis,
    average_treatment_cost
FROM DiagnosisByDepartment
WHERE rn = 1
ORDER BY Department;


-- =========================================================
-- 5. FINANCIAL ANALYSIS
-- =========================================================

-- Total treatment cost
SELECT
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset;

-- Average treatment cost
SELECT
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset;

-- Monthly treatment cost trend
SELECT
    DATEFROMPARTS(YEAR(Admission_Date), MONTH(Admission_Date), 1) AS admission_month,
    SUM(Treatment_Cost_NGN) AS monthly_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Admission_Date IS NOT NULL
GROUP BY DATEFROMPARTS(YEAR(Admission_Date), MONTH(Admission_Date), 1)
ORDER BY admission_month;

-- Treatment cost by admission type
SELECT
    Admission_Type,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Admission_Type IS NOT NULL
GROUP BY Admission_Type
ORDER BY total_treatment_cost DESC;

-- Treatment cost by location
SELECT
    Location,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Location IS NOT NULL
GROUP BY Location
ORDER BY total_treatment_cost DESC;

-- Location with the highest total treatment cost
SELECT TOP (1)
    Location,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Location IS NOT NULL
GROUP BY Location
ORDER BY total_treatment_cost DESC;


-- =========================================================
-- 6. INSURANCE ANALYSIS
-- =========================================================

-- Most frequently used insurance type
SELECT TOP (1)
    Insurance_Type,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Insurance_Type IS NOT NULL
GROUP BY Insurance_Type
ORDER BY patient_count DESC;

-- Patient volume by insurance type
SELECT
    Insurance_Type,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Insurance_Type IS NOT NULL
GROUP BY Insurance_Type
ORDER BY patient_count DESC;

-- Total treatment cost by insurance type
SELECT
    Insurance_Type,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Insurance_Type IS NOT NULL
GROUP BY Insurance_Type
ORDER BY total_treatment_cost DESC;


-- =========================================================
-- 7. DOCTOR WORKLOAD
-- =========================================================

-- Patients treated by each doctor
SELECT
    Doctor,
    COUNT(DISTINCT Patient_ID) AS patients_treated
FROM dbo.hospital_patient_dataset
WHERE Doctor IS NOT NULL
GROUP BY Doctor
ORDER BY patients_treated DESC;

-- Top 5 doctors by patient workload
SELECT TOP (5)
    Doctor,
    COUNT(DISTINCT Patient_ID) AS patients_treated
FROM dbo.hospital_patient_dataset
WHERE Doctor IS NOT NULL
GROUP BY Doctor
ORDER BY patients_treated DESC;

-- Top 5 doctors by total treatment cost
SELECT TOP (5)
    Doctor,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Doctor IS NOT NULL
GROUP BY Doctor
ORDER BY total_treatment_cost DESC;

-- Doctors who treated more than 500 patients
SELECT
    Doctor,
    COUNT(DISTINCT Patient_ID) AS patients_treated
FROM dbo.hospital_patient_dataset
WHERE Doctor IS NOT NULL
GROUP BY Doctor
HAVING COUNT(DISTINCT Patient_ID) > 500
ORDER BY patients_treated DESC;


-- =========================================================
-- 8. PATIENT SATISFACTION
-- =========================================================

-- Overall average patient satisfaction
SELECT
    AVG(Patient_Satisfaction) AS average_patient_satisfaction
FROM dbo.hospital_patient_dataset;

-- Average satisfaction by location
SELECT
    Location,
    AVG(Patient_Satisfaction) AS average_patient_satisfaction
FROM dbo.hospital_patient_dataset
WHERE Location IS NOT NULL
GROUP BY Location
ORDER BY average_patient_satisfaction DESC;

-- Average treatment cost for patients with satisfaction below 3
SELECT
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Patient_Satisfaction < 3;


-- =========================================================
-- 9. ADVANCED ANALYSIS
-- =========================================================

-- Top 10 patients by treatment cost
SELECT TOP (10)
    Patient_ID,
    SUM(Treatment_Cost_NGN) AS total_treatment_cost
FROM dbo.hospital_patient_dataset
GROUP BY Patient_ID
ORDER BY total_treatment_cost DESC;

-- Patients whose treatment cost is above the overall average
SELECT
    Patient_ID,
    Treatment_Cost_NGN
FROM dbo.hospital_patient_dataset
WHERE Treatment_Cost_NGN > (
    SELECT AVG(Treatment_Cost_NGN)
    FROM dbo.hospital_patient_dataset
)
ORDER BY Treatment_Cost_NGN DESC;

-- Average treatment cost for patients with satisfaction below 3
SELECT
    AVG(Treatment_Cost_NGN) AS average_treatment_cost
FROM dbo.hospital_patient_dataset
WHERE Patient_Satisfaction < 3;

-- Relationship-ready summary: cost and length of stay by department
SELECT
    Department,
    AVG(Treatment_Cost_NGN) AS average_treatment_cost,
    AVG(Length_of_Stay_Days) AS average_length_of_stay,
    AVG(Patient_Satisfaction) AS average_patient_satisfaction,
    COUNT(*) AS patient_count
FROM dbo.hospital_patient_dataset
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY patient_count DESC;
