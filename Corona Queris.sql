-- 1. Find the number of corona patients who faced shortness of breath.

SELECT Count(*) FROM cleaned_data WHERE Corona = 'Positive' AND Shortness_of_breath ='TRUE';


-- 2. Find the number of negative corona patients who have fever and sore_throat. 
select count(*) from cleaned_data where corona ="negative" and fever="TRUE" and sore_throat="TRUE";


-- 3. Find the female negative corona patients who faced cough and headache.
select count(*) from cleaned_data where sex="FEMALE" and Corona="negative" and Cough_symptoms="TRUE" and Headache="TRUE";


-- 4. How many elderly corona patients have faced breathing problems?

select count(*) from cleaned_data where corona="positive" and Age_60_above="YES" and Shortness_of_breath="TRUE";


-- 5. Group the data by month and rank the number of positive cases.

SELECT MONTH(Test_date) AS months, sum(corona='positive') AS total_positive_cases,
RANK() OVER (ORDER BY SUM(Corona='positive') DESC) AS Ranks FROM cleaned_data 
WHERE corona='positive' GROUP BY months;


-- 6. Which three symptoms were more common among COVID positive patients?

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Fever = 'TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Headache = 'TRUE'
) as x
GROUP BY symptom ORDER BY total_count DESC LIMIT 3;

-- 7. Which symptom was less common among COVID negative people?

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'negative' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'negative' AND Fever = 'TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'negative' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'negative' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'negative' AND Headache = 'TRUE'
) AS x
GROUP BY symptom ORDER BY total_count ASC LIMIT 1;

-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT symptom, SUM(count) AS total_count
FROM (
    SELECT 'Cough_symptoms' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Fever' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Fever = 'TRUE' And Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Sore_throat' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Sore_throat = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE' AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 'Headache' AS symptom, COUNT(*) AS count FROM cleaned_data WHERE Corona = 'positive' AND Headache = 'TRUE' And Sex='Male' AND Known_contact ='abroad'
) AS x
GROUP BY symptom ORDER BY total_count DESC LIMIT 1;