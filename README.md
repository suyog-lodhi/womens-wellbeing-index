# Women's Wellbeing Index — India
📊 *2026 Power BI Project*

## 📌 Project Overview
A multi-dimensional data analysis project examining 
women's health, education, lifestyle and environmental 
factors across 36 Indian States & UTs using NFHS-5 
district-level survey data.

## 📜 Problem Statement
What factors most strongly predict women's health 
outcomes in India — and which states need urgent 
policy intervention?

## 🗃️ Dataset
- **Source:** National Family Health Survey — NFHS-5 (2019-21)
- **Published by:** Ministry of Health & Family Welfare, 
  Government of India
- **Coverage:** 706 Districts | 36 States & UTs
- **Indicators analyzed:** 25 health, education, 
  lifestyle and environmental variables

## 🛠️ Tools Used
| Tool | Purpose |
|---|---|
| Microsoft Excel | Data cleaning, calculated columns, pivot tables |
| MySQL | 33 SQL queries across 5 analytical categories |
| Power BI | 5-page interactive dashboard |

## ✅ Key Findings

**1️⃣ Anaemia Crisis**
54% of Indian women are anaemic nationally. Ladakh 
leads at 92.75% due to altitude-related factors. 
West Bengal (71.53%) and Tripura (67.05%) show 
highest mainland anaemia.

**2️⃣ Education Drives Health**
School completion (10+ years) is the strongest social 
predictor of delayed marriage (R²=59.87%). Bihar 
(28.6% schooling, 41% child marriage) vs Kerala 
(76.9% schooling, 5.46% child marriage).

**3️⃣ Screening Emergency**
Despite 13.47% national tobacco use, oral cancer 
screening stands at less than 1% nationally. 
99 out of 100 women are never screened for breast cancer.

**4️⃣ Environment Is Health**
Sanitation is the strongest environmental predictor 
of anaemia (R²=54.1%) — stronger than even education. 
6 states face triple deprivation — below average on 
clean fuel, sanitation AND clean water simultaneously.

**5️⃣ The Northeast Paradox**
Northeast states show India's highest tobacco and 
alcohol consumption yet paradoxically lowest anaemia 
rates — proving social cohesion and nutrition outweigh 
lifestyle habits.

## 📊 Dashboard Preview

### Page 1 — National Overview
<img width="1715" height="772" alt="Screenshot 2026-06-05 104338" src="https://github.com/user-attachments/assets/fbb52aff-4f9a-4477-aeb5-594843e54a0d" />



### Page 2 — Health Outcomes
<img width="1718" height="768" alt="Screenshot 2026-06-05 115948" src="https://github.com/user-attachments/assets/55075703-70c2-42ad-b046-c4cb3e3c5deb" />


### Page 3 — Education & Social Factors
<img width="1713" height="780" alt="Screenshot 2026-06-05 104404" src="https://github.com/user-attachments/assets/c070fe0c-8dec-41dd-9c15-de034650fc6a" />


### Page 4 — Lifestyle & Environment
<img width="1716" height="785" alt="Screenshot 2026-06-05 104414" src="https://github.com/user-attachments/assets/f63d8272-f915-4ca1-9f46-3efbc192804d" />


### Page 5 — Key Insights
<img width="1713" height="778" alt="Screenshot 2026-06-05 104426" src="https://github.com/user-attachments/assets/80954dee-4267-460b-8c0c-749550f56436" />


## 👩🏻‍💻 SQL Analysis Structure
33 queries organized across 5 categories:
- Category 1 — Health Outcomes 
- Category 2 — Education & Social
- Category 3 — Lifestyle & Screening
- Category 4 — Environment & Access
- Category 5 — Relationship Analysis

---

# 📂 Repository Structure
```
├── 01_Data
│   └── 01_Raw_data
|   └── 02_Clean_data
│  
│
├── 02_Dashboard
│   └──  WomensWellbeingIndex.pbix
│
├── 03_Images
│   └── Dashboard_overview.png
│
├── 04_SQL_Queries
│   └── SQL_queries.sql
│
└── README.md
```
## 🧮 Analytical Approach
- Data cleaning and mean imputation for erroneous values
- Calculated edu_gap column — original metric measuring 
  school enrollment vs completion gap
- State-level aggregation from district-level data
- Scatter plot correlation analysis with R² values
- Cross-category relationship mapping

## ❗ Data Limitations
- NFHS-5 covers 2019-21 — most recent available data
- State summary values represent averages of 
  district-level means
- Cancer screening columns represent awareness/access, 
  not prevalence

---

# 👨‍💻 Author

**Suyog Lodhi**<br/>Aspiring Data Analyst | Excel | SQL | Power BI

🔗 LinkedIn: www.linkedin.com/in/suyog-lodhi-94a45825a
