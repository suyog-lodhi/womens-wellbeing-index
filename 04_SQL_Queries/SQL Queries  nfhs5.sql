CREATE DATABASE  nfhs5;
USE  nfhs5;


CREATE TABLE state_summary (
    state_ut VARCHAR(100),
    total_households_surveyed INT,
    total_women_interviewed INT,
    avg_school_ever DECIMAL(5,2),
    avg_literacy DECIMAL(5,2),
    avg_schooling_10plus DECIMAL(5,2),
    avg_child_marriage DECIMAL(5,2),
    avg_clean_fuel DECIMAL(5,2),
    avg_clean_water DECIMAL(5,2),
    avg_sanitation DECIMAL(5,2),
    avg_menstrual_hygiene DECIMAL(5,2),
    avg_bmi_low DECIMAL(5,2),
    avg_bmi_high DECIMAL(5,2),
    avg_anaemia_all DECIMAL(5,2),
    avg_anaemia_teen DECIMAL(5,2),
    avg_sugar_high DECIMAL(5,2),
    avg_sugar_veryhigh DECIMAL(5,2),
    avg_bp_mild DECIMAL(5,2),
    avg_bp_severe DECIMAL(5,2),
    avg_breast_cancer_screening DECIMAL(5,2),
    avg_oral_cancer_screening DECIMAL(5,2),
    avg_tobacco DECIMAL(5,2),
    avg_alcohol DECIMAL(5,2),
    avg_education_gap DECIMAL(5,2)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/state_summary.csv'
INTO TABLE state_summary
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from state_summary;
select count(*) from state_summary; -- 36 row AND 25 column returned , OK

CREATE TABLE women_clean (
    district VARCHAR(100),
    state_ut VARCHAR(100),

    households_surveyed INT,
    women_interviewed INT,

    school_ever DECIMAL(5,2),
    sex_ratio DECIMAL(6,2),
    literacy DECIMAL(5,2),
    schooling_10plus DECIMAL(5,2),
    child_marriage DECIMAL(5,2),

    clean_fuel DECIMAL(5,2),
    clean_water DECIMAL(5,2),
    sanitation DECIMAL(5,2),
    health_insurance DECIMAL(5,2),
    menstrual_hygiene DECIMAL(5,2),

    bmi_low DECIMAL(5,2),
    bmi_high DECIMAL(5,2),

    anaemia_all DECIMAL(5,2),
    anaemia_teen DECIMAL(5,2),

    sugar_high DECIMAL(5,2),
    sugar_veryhigh DECIMAL(5,2),

    bp_mild DECIMAL(5,2),
    bp_severe DECIMAL(5,2),

    breast_cancer_screening DECIMAL(5,2),
    oral_cancer_screening DECIMAL(5,2),

    tobacco DECIMAL(5,2),
    alcohol DECIMAL(5,2),

    education_gap DECIMAL(5,2)
);



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/women_clean.csv'
INTO TABLE women_clean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from women_clean;

select count(*) from women_clean; -- 706 row AND 27 columns returned , OK



-- Important Note : All Values are in % .



-- CATEGORY 1 : Health Outcomes


-- Q1 Which are the top 5 states with highest anaemia in women?

SELECT 
	State_ut AS State_UT, 
	AVG_ANAEMIA_ALL AS Anaemia_highest
FROM STATE_SUMMARY
	ORDER BY Anaemia_highest DESC
	LIMIT 5 ; -- all result values are in %

-- Q2 Which are the bottom 5 states with lowest anaemia?

SELECT 
	State_ut AS State_UT, 
	AVG_ANAEMIA_ALL AS Anaemia_lowest
FROM STATE_SUMMARY
	ORDER BY Anaemia_lowest ASC
	LIMIT 5 ; -- all result values are in %

/* Q3 What is the national average of anaemia_all,anaemia_teen, bmi_low, bmi_high, sugar_high, 
     sugar_veryhigh and bp_mild bp_severe ? */

SELECT 
	round(AVG(avg_bmi_low),0) AS avg_national_bmi_low, 
	round(AVG(avg_bmi_high),0) AS avg_national_bmi_high ,
	round(AVG(avg_anaemia_all),0) AS avg_national_anaemia_all,
	round(AVG(avg_anaemia_teen),0) AS avg_national_anaemia_teen , 
	round(AVG(avg_sugar_high),0) AS avg_national_sugar_high,
	round(AVG(avg_sugar_veryhigh),0) AS avg_national_sugar_veryhigh , 
	round(AVG(avg_bp_mild),0) AS avg_national_bp_mild ,
	round(AVG(avg_bp_severe),0) AS avg_national_bp_severe
FROM STATE_SUMMARY ; -- all result values are in % 


-- Q4: Which states have teenage anaemia worse than adult women anaemia — and by how much ?

SELECT 
	state_ut,
	avg_anaemia_teen , 
	avg_anaemia_all, 
	ROUND(avg_anaemia_teen - avg_anaemia_all,0) AS Teen_excess
FROM state_summary
	WHERE avg_anaemia_teen > avg_anaemia_all 
	ORDER BY Teen_excess DESC ; -- These are those states where children are suffering more than women from anaemia


-- Q5 : Which states are facing double burden — both bmi_low AND bmi_high above national average simultaneously?

/* 
Double burden states need two completely different health interventions at the same time — 
fighting hunger AND fighting obesity.
These are those states where avg bmi low is greater than national bim low , and avg bmi high is greater than 
national bmi high */


WITH CTE1 AS (
		SELECT *,
		round(AVG(avg_bmi_low) OVER(),0) AS National_BMI_Low ,
		round(AVG(avg_bmi_high) OVER() , 0) AS National_BMI_High
		 FROM (
			SELECT 
			state_ut,
			avg_bmi_low,
			avg_bmi_high 
			FROM state_summary) t
		) 
SELECT * FROM CTE1
WHERE CTE1.avg_bmi_low > CTE1.National_BMI_Low
AND CTE1.avg_bmi_high > CTE1.National_BMI_High ; 


-- CATEGORY 2 :  Education & Social


-- Question 1 : Which are the top 5 states with highest child marriage rate?

SELECT 
		state_ut , 
        avg_child_marriage 
FROM state_summary 
	ORDER BY avg_child_marriage DESC
		LIMIT 5 ;

-- Question 2 : Which are the bottom 5 states with lowest child marriage rate?

SELECT 
		state_ut , 
        avg_child_marriage 
FROM state_summary 
	ORDER BY  avg_child_marriage ASC
    LIMIT 5 ;

-- Question 3 : Which states have literacy rate below national average — order from worst to best?

WITH CTE1 AS (
			SELECT 
					*, 
                    ROUND(AVG(t.avg_literacy)  OVER(),0) AS Avg_National_literacy 
			FROM (
					SELECT 
						state_ut , 
						avg_literacy
					FROM  state_summary ) t 
				)
SELECT 
	CTE1.state_ut, 
	ROUND(CTE1.avg_literacy,0) AS Avg_literacy,
	CTE1.Avg_National_literacy  
FROM CTE1 
	WHERE 
		CTE1.avg_literacy < CTE1.Avg_National_literacy
;


-- Question 4 : Which states have highest edu_gap — meaning girls are enrolling in school but dropping out before 
-- 				completing 10 years?

SELECT 
	state_ut , 
	avg_education_gap 
FROM state_summary 
	ORDER BY avg_education_gap DESC
		LIMIT 5 ;


-- Question 5 :  What is the national average of literacy, school_ever, school_10plus, edu_gap, child_marriage and 
-- 		menstrual_hygiene?

SELECT 
	ROUND(AVG(avg_literacy),0) AS avg_national_literacy, 
	ROUND(AVG(avg_school_ever),0) AS avg_national_school_ever ,
	ROUND(AVG(avg_schooling_10plus),0) AS avg_national_schooling_10plus,
	ROUND(AVG(avg_education_gap),0) AS avg_national_education_gap , 
	ROUND(AVG(avg_child_marriage),0) AS avg_national_child_marriage,
	ROUND(AVG(avg_menstrual_hygiene),0) AS avg_national_menstrual_hygiene
FROM state_summary;


/* Question : 6 Which states have low edu_gap AND low child marriage then respective national average
			meaning girls are both completing education AND not getting married early? */


SELECT * 
FROM  (
		SELECT 
			state_ut, 
			avg_education_gap,
			avg_child_marriage,
			ROUND(AVG(avg_education_gap) OVER(),0) AS AVG_National_edu_gap,
			ROUND(AVG(avg_child_marriage) OVER(),0) AS AVG_National_child_marriage
		FROM state_summary 
	) t
	WHERE t.avg_education_gap < t.AVG_National_edu_gap
		AND
			t.avg_child_marriage < t.AVG_National_child_marriage ;
		


--  Category 3 — Lifestyle & Screening 


-- Q1. Which are the top 5 states with highest tobacco use among women?

SELECT 
		state_ut,
        avg_tobacco AS Avg_Tobacco_Consumption
FROM state_summary 
	ORDER BY Avg_Tobacco_Consumption DESC
		LIMIT 5 ;

SELECT * FROM STATE_SUMMARY ;

-- Q2. Which are the top 5 states with highest alcohol consumption among women?

SELECT 
		state_ut,
        avg_alcohol AS Avg_Alcohol_Consumption
FROM state_summary 
	ORDER BY Avg_Alcohol_Consumption DESC
		LIMIT 5 ;

-- Q3. What is the national average of tobacco, alcohol, breast_screening and oral_screening?

SELECT 
	ROUND(AVG(avg_alcohol),2) AS avg_national_alcohol_consumption, 
	ROUND(AVG(avg_tobacco),2) AS avg_national_tobacco_consumption ,
	ROUND(AVG(avg_breast_cancer_screening),2) AS avg_national_breast_cancer_screening,
	ROUND(AVG(avg_oral_cancer_screening),2) AS avg_national_oral_cancer_screening	
FROM state_summary;


-- Q4. Which states have tobacco use above national average but oral screening BELOW national average — meaning high risk states NOT getting screened?

WITH CTE1 AS (
			SELECT *, 
				ROUND(AVG(t.avg_tobacco) OVER(),2) AS avg_national_tobacco_consumption,
				ROUND(AVG(t.avg_oral_cancer_screening) OVER(),2) AS avg_national_oral_cancer_screening
			FROM(
					SELECT 
						state_ut , 
						avg_tobacco , 
						avg_oral_cancer_screening
					FROM state_summary) t 
				) 
	SELECT 
		CTE1.state_ut, 
		CTE1.avg_tobacco,
		CTE1.avg_national_tobacco_consumption,
		CTE1.avg_oral_cancer_screening,
		CTE1.avg_national_oral_cancer_screening
	FROM CTE1 
			WHERE CTE1.avg_tobacco > CTE1.avg_national_tobacco_consumption
			AND CTE1.avg_oral_cancer_screening < CTE1.avg_national_oral_cancer_screening ;


-- Q5. Which states have both tobacco AND alcohol above national average simultaneously — highest lifestyle risk states?


WITH CTE1 AS (
			SELECT 
				state_ut, 
				avg_tobacco , 
				avg_alcohol,
				ROUND(AVG(avg_tobacco) OVER(),2) AS avg_national_tobacco_consumption,
				ROUND(AVG(avg_alcohol) OVER() ,2) AS avg_national_alcohol_consumption
			FROM state_summary)
SELECT 
		CTE1.state_ut, 
		CTE1.avg_tobacco, 
		CTE1.avg_national_tobacco_consumption, 
		CTE1.avg_alcohol, 
		CTE1.avg_national_alcohol_consumption
FROM CTE1
		WHERE CTE1.avg_tobacco > CTE1.avg_national_tobacco_consumption
			AND CTE1.avg_alcohol > CTE1.avg_national_alcohol_consumption ;


-- Q6. Which states have best screening awareness — both breast_screening AND oral_screening above national average?
SELECT * FROM (
SELECT 
		state_ut, 
		avg_oral_cancer_screening,
        avg_breast_cancer_screening,
        ROUND(AVG(avg_oral_cancer_screening) OVER(),2) AS avg_national_oral_cancer_screening,
		ROUND(AVG(avg_breast_cancer_screening) OVER(),2) AS avg_national_breast_cancer_screening
FROM state_summary ) t
	WHERE     t.avg_national_oral_cancer_screening > t.avg_oral_cancer_screening
		AND   t.avg_national_breast_cancer_screening > t.avg_breast_cancer_screening ;



-- Q 7A : For each state show alcohol and breast screening together — for scatter plot
SELECT 
    state_ut, 
    avg_alcohol, 
    avg_breast_cancer_screening
FROM state_summary
		ORDER BY avg_alcohol DESC;

-- Q 7B :Which states have alcohol ABOVE national average but breast screening BELOW national average — danger zone states?


WITH CTE1 AS (
    SELECT 
        state_ut,
        avg_alcohol,
        avg_breast_cancer_screening,
        ROUND(AVG(avg_alcohol) OVER(),2) AS avg_national_alcohol_consumption,
        ROUND(AVG(avg_breast_cancer_screening) OVER(),2) AS avg_national_breast_cancer_screening
    FROM state_summary
)
SELECT 
    state_ut,
    avg_alcohol,
    avg_national_alcohol_consumption,
    avg_breast_cancer_screening,
    avg_national_breast_cancer_screening
FROM CTE1
	WHERE avg_alcohol > avg_national_alcohol_consumption
		AND avg_breast_cancer_screening < avg_national_breast_cancer_screening ;



--        Category 4 — Environment & Access


select * from state_summary;


-- Q1 : What is the national average of clean_fuel, sanitation, clean_water and health_insurance?

SELECT 
	ROUND(AVG(avg_clean_fuel),2) AS avg_national_clean_fuel, 
	ROUND(AVG(avg_sanitation),2) AS avg_national_sanitation ,
	ROUND(AVG(avg_clean_water),2) AS avg_national_clean_water,
	ROUND(AVG(avg_health_insurance),2) AS avg_national_health_insurance
FROM state_summary;

-- Q2. Which are the bottom 5 states with lowest clean fuel access — women cooking on dirty fuel most?

SELECT
		state_ut,
        avg_clean_fuel
FROM state_summary
	ORDER BY avg_clean_fuel asc
	LIMIT 5 ;

-- Q3. Which are the bottom 5 states with lowest sanitation access?

SELECT
		state_ut,
        avg_sanitation
FROM state_summary
	ORDER BY avg_sanitation asc
	LIMIT 5 ;

-- Q4. Which states have all three basic amenities — clean_fuel, sanitation AND clean_water — all below national average simultaneously? These are your most deprived states!


SELECT 
	t.state_ut,
	t.avg_sanitation,
	t.avg_national_sanitation,
	t.avg_clean_fuel,
	t.avg_national_clean_fuel,
	t.avg_clean_water,
	t.avg_national_clean_water
 FROM (
		SELECT
				state_ut,
				avg_sanitation,
				avg_clean_fuel,
				avg_clean_water,
				ROUND(AVG(avg_sanitation) OVER(), 2) AS avg_national_sanitation ,
				ROUND(AVG(avg_clean_fuel) OVER(), 2) AS avg_national_clean_fuel, 
				ROUND(AVG(avg_clean_water) OVER(), 2) AS avg_national_clean_water
		FROM state_summary ) t 
	WHERE t.avg_sanitation < t.avg_national_sanitation
	AND   t.avg_clean_fuel < t.avg_national_clean_fuel
	AND   t.avg_clean_water < t.avg_national_clean_water ;

-- Q5. Which states have high health insurance but surprisingly LOW breast screening —
--   meaning insured women are still not getting screened?

SELECT t.state_ut,
	   t.avg_health_insurance,
       t.avg_national_health_insurance,
       t.avg_breast_cancer_screening,
       t.avg_national_breast_cancer_screening
FROM (
			SELECT 
				state_ut, 
				avg_health_insurance,
				avg_breast_cancer_screening , 
				ROUND(AVG(avg_health_insurance) OVER(), 2) AS avg_national_health_insurance,
				ROUND(AVG(avg_breast_cancer_screening) OVER(), 2) AS avg_national_breast_cancer_screening 
			FROM state_summary) t
	WHERE t.avg_health_insurance > t.avg_national_health_insurance
	AND   t.avg_breast_cancer_screening < t.avg_national_breast_cancer_screening ;

-- Q6. For each state show clean_fuel AND anaemia_all together ordered by clean_fuel ascending...

SELECT 
		state_ut, 
		avg_clean_fuel,
		avg_anaemia_all 
FROM state_summary
	ORDER BY avg_clean_fuel ASC ; 


--                               Category 5 — Relationship Queries

-- Q1 — Education vs Health

SELECT state_ut, avg_literacy, avg_anaemia_all
FROM state_summary
ORDER BY avg_literacy ASC;

-- Q2 — Child Marriage vs Teenage Anaemia

SELECT state_ut, avg_child_marriage, avg_anaemia_teen
FROM state_summary
ORDER BY avg_child_marriage DESC;

-- Q3 — Education Gap vs Child Marriage

SELECT state_ut, avg_education_gap, avg_child_marriage
FROM state_summary
ORDER BY avg_education_gap DESC;

-- Q4 — Clean Fuel vs Anaemia

SELECT 
		state_ut, 
		avg_clean_fuel,
		avg_anaemia_all 
FROM state_summary
	ORDER BY avg_clean_fuel ASC ;


-- Q5 — Obesity vs Diabetes

SELECT state_ut, avg_bmi_high, avg_sugar_veryhigh
FROM state_summary
ORDER BY avg_bmi_high DESC;

-- Q6 — Sanitation vs BMI Low

SELECT state_ut, avg_sanitation, avg_bmi_low
FROM state_summary
ORDER BY avg_sanitation ASC;

-- Q7 — Tobacco vs Oral Screening

SELECT state_ut, avg_tobacco, avg_oral_cancer_screening
FROM state_summary
ORDER BY avg_tobacco DESC;


-- Q8 — Menstrual Hygiene vs Literacy

SELECT state_ut, avg_literacy, avg_menstrual_hygiene
FROM state_summary
ORDER BY avg_literacy ASC;



-- ------------------------------------------             *******************************************               ------------------------------------------------------------------------------------------------------------