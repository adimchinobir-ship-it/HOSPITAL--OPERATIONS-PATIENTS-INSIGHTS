# Hospital Patient Analytics — SQL & Power BI

## Project Overview

This portfolio project analyzes **5,000 hospital patient records** using **SQL and Microsoft Power BI**.

The goal was to explore patient demographics, admission patterns, hospital operations, treatment costs, insurance coverage, doctor workload, diagnoses, length of stay, and patient satisfaction, then communicate the findings through an interactive four-page Power BI dashboard.

> **Dataset note:** This is a portfolio analysis of the provided hospital patient dataset. It should not be presented as verified performance data from a real hospital.

## Tools & Technologies

- **SQL Server** — data exploration, aggregation, validation, and analytical queries
- **Power BI** — interactive dashboard and business intelligence
- **DAX** — calculated measures and dashboard metrics
- **Data Visualization** — charts, KPIs, tables, and interactive filters

## Dataset

The dataset contains 5,000 patient records and 14 fields:

| Field | Description |
|---|---|
| Patient_ID | Unique patient identifier |
| Age | Patient age |
| Gender | Patient gender |
| Location | Patient location |
| Admission_Date | Date of admission |
| Discharge_Date | Date of discharge |
| Admission_Type | Emergency, Scheduled, or Referral |
| Department | Hospital department |
| Diagnosis | Patient diagnosis |
| Doctor | Attending doctor |
| Insurance_Type | Insurance/payment category |
| Treatment_Cost_NGN | Treatment cost in Nigerian Naira |
| Length_of_Stay_Days | Length of hospital stay |
| Patient_Satisfaction | Satisfaction score |

## Business Questions

The analysis addressed questions such as:

1. How many patients were admitted?
2. How does patient volume change over time?
3. Which departments handle the highest patient volumes?
4. Which diagnoses are most common?
5. Which departments have the highest treatment costs?
6. How does average treatment cost vary by diagnosis?
7. What is the average length of stay?
8. Which admission type is most common?
9. Which insurance type is used most frequently?
10. Which doctors have the highest patient workload?
11. How does patient satisfaction vary by department and location?
12. Which patients have treatment costs above the overall average?

## Key KPIs

Based on the full dataset:

- **Total Patients:** 5,000
- **Total Treatment Cost:** approximately ₦1.217B
- **Average Treatment Cost:** approximately ₦243K
- **Average Length of Stay:** 10.36 days
- **Average Patient Satisfaction:** 3.88 / 5
- **Emergency Admissions:** 44.0%

## Key Insights

- Emergency admissions account for approximately **44%** of all admissions.
- The **65+** age group is the largest age segment in the dataset.
- **General Medicine** has the highest patient volume, followed by Emergency.
- Treatment cost has a strong positive relationship with length of stay in this dataset.
- Average treatment cost is approximately **₦243K** per patient.
- Patient satisfaction is relatively close across locations, with the displayed location averages ranging from about **3.81 to 3.93**.
- Treatment cost and patient satisfaction show little linear relationship in the dataset.

These observations describe patterns in the portfolio dataset and should not be interpreted as causal conclusions.

## Power BI Dashboard

The dashboard contains four analytical pages:

### 1. KPI & Visuals
Executive-level overview including:
- Total patients
- Total treatment cost
- Average treatment cost
- Average length of stay
- Average satisfaction
- Monthly admission trend
- Patient volume by department
- Admission type distribution
- Patient satisfaction distribution

### 2. Patient & Clinical Analysis
Focuses on:
- Age distribution
- Gender distribution
- Treatment cost by diagnosis
- Average treatment cost by diagnosis
- Department × diagnosis analysis

### 3. Hospital Operations
Focuses on:
- Monthly treatment cost trend
- Average length of stay by department
- Admission type analysis
- Patient volume by department
- Doctor workload

### 4. Financial & Patient Experience
Focuses on:
- Treatment cost by department
- Treatment cost by location
- Insurance treatment cost
- Average treatment cost by diagnosis
- Average patient satisfaction by location

## SQL Analysis

The SQL analysis is organized into:

1. Patient Volume & Admissions
2. Demographics
3. Department Analysis
4. Diagnosis Analysis
5. Financial Analysis
6. Insurance Analysis
7. Doctor Workload
8. Patient Satisfaction
9. Advanced Analysis

The SQL file includes aggregation, filtering, grouping, conditional calculations, subqueries, and window functions.

## Project Workflow

```text
Raw Hospital Dataset
        ↓
SQL Exploration & Validation
        ↓
Aggregations & Analytical Queries
        ↓
Power BI Data Modeling / DAX
        ↓
Interactive Dashboard
        ↓
Business Insights
```

## Repository Structure

```text
hospital-operations-patient-insights/
├── README.md
├── data/
│   └── hospital_patient_dataset.csv
├── sql/
│   └── hospital_analysis.sql
├── powerbi/
│   └── hospital_patient_dashboard.pbix
├── screenshots/
│   ├── 01_Executive_Overview.png
│   ├── 02_Patient_Clinical_Analysis.png
│   ├── 03_Hospital_Operations.png
│   └── 04_Financial_Patient_Experience.png
└── documentation/
    └── project-insights.md
```

## Skills Demonstrated

**SQL | Power BI | DAX | Data Cleaning | Data Analysis | Exploratory Data Analysis | Data Visualization | Business Intelligence | Healthcare Analytics**

## Portfolio Note

This project demonstrates the ability to move from raw data to structured analysis and an interactive business intelligence dashboard. The emphasis is on analytical thinking, SQL querying, data visualization, and communicating findings clearly.
