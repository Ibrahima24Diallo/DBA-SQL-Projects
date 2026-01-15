-- EXPLORATORY DATA ANALYSIS
SELECT * 
FROM company_layoffs2;

-- 1) Compute yearly layoffs per company
-- Write a query that shows how many employees each company laid off each year.
SELECT YEAR(date) AS Layoff_Year, company,SUM(total_laid_off) AS Total_yearly_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY YEAR(date), company
ORDER BY Layoff_Year;

-- 2) Rank companies by total layoffs
-- Find the top 10 companies with the highest total layoffs across the entire dataset.
SELECT company, SUM(total_laid_off) AS Highest_Total_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- 3) Layoffs by industry over time
-- Show how layoffs changed year over year for each industry, ordered by year.
SELECT industry, YEAR(date) AS Layoff_Year, SUM(total_laid_off) AS Total_layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
AND industry IS NOT NULL
GROUP BY industry, YEAR(date)
ORDER BY industry, Layoff_Year;

-- 4) Percentage of layoffs by country
-- Calculate the percentage of total layoffs that each country 
-- contributes relative to all layoffs combined.
SELECT country, SUM(total_laid_off) AS Total_Layoffs,
		ROUND(SUM(total_laid_off) * 100 / SUM(SUM(total_laid_off))
				OVER(), 2
			 ) AS percentage_of_total_layoffs
FROM company_layoffs2
WHERE country IS NOT NULL
AND total_laid_off IS NOT NULL
GROUP BY country
ORDER BY percentage_of_total_layoffs DESC;

-- 5) Monthly layoffs trend
-- Produce a report with total layoffs per month, 
-- sorted chronologically, to analyze trends over time.

SELECT Year(date) AS Year, MONTH(date) AS Months,  
		SUM(total_laid_off) AS Monthly_Total_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY Year(date), MONTH(date) 
ORDER BY Year, Months;

-- 6) Companies with 100% layoffs
-- List companies that laid off 100% of their workforce, 
-- sorted by the largest number of laid-off employees.
SELECT company, SUM(total_laid_off) AS Largest_Layoffs, percentage_laid_off
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
AND percentage_laid_off = 1
GROUP BY company, percentage_laid_off
ORDER BY Largest_Layoffs DESC;

-- 7) Average layoffs per company stage
-- Determine the average number of employees laid off for each company stage 
-- (e.g., early stage, post-IPO).

SELECT company, stage, AVG(total_laid_off) AS Avg_Emp_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY company, stage
ORDER BY Avg_Emp_Layoffs;

-- Industry ranking by layoffs each year
-- For each year, rank industries by the total number of layoffs they experienced.

SELECT industry, YEAR(date) AS Layoffs_Year, SUM(total_laid_off) AS Industry_Total_layoffs, 
        DENSE_RANK() OVER(PARTITION BY YEAR(date) ORDER BY SUM(total_laid_off) DESC
		) AS Ranking_By_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY industry,YEAR(date);

-- 9) Find location with the most layoffs per country
-- For each country, find the location (city/region) with the highest total layoffs.

WITH Most_Layoffs_Per_Country AS (
	SELECT Country, Location, SUM(total_laid_off) AS Highest_Total_Layoffs,
			ROW_NUMBER() OVER(PARTITION BY Country ORDER BY SUM(total_laid_off) DESC) AS r_num
	FROM company_layoffs2
    WHERE total_laid_off IS NOT NULL
	GROUP BY Country, Location
) 
SELECT *
FROM Most_Layoffs_Per_Country
WHERE r_num = 1
ORDER BY Highest_Total_Layoffs DESC;

-- 10) Cumulative layoffs over time
-- Create a running total of layoffs month by month 
-- to see how layoffs accumulate throughout the years.
SELECT YEAR(date) AS Layoff_Year, MONTH(date) AS Layoff_Month,
		SUM(total_laid_off) AS Monthly_Layoffs, 
        SUM(SUM(total_laid_off)) OVER ( 
			ORDER BY Year(date), Month(date)
            ) AS Cumulative_Layoffs
FROM company_layoffs2
GROUP BY Year(date), Month(date)
ORDER BY  Layoff_Year, Layoff_Month;

 




select empID, AVG(Salary)
from (select  Salary
		from employees
		Order by salary ASC
		limit 5) AS AVG_SALARY;                   
	
select empID, FName, LName
from employee
WHERE Year(from_days(datediff(current_date, DOB))) > 
(select  AVG(Year(from_days(datediff(current_date, DOB))))
from employees);

select empID, Year(datediff(current_date, Year_Service)), 
		(select AVG(Year(datediff(current_date, Year_Service)))
		from employees )
from employees;

select empID, firstName, lastName, job_title
from employees
where job_id IN
	(select job_id
	from empoloyees
	where job_title = 'designer');

select *
from jobs
where job_id IN
	(select job_id
	from empoloyees
    where YEAR(birthdate) > 1976);

























