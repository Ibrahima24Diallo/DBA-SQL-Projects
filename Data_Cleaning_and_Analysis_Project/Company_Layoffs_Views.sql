-- CREATING VIEWS FOR REPORTING AND TREND ANALYSIS 
-- 1) reate a view that shows, Company, Industry, Year, Total layoffs per company per year
CREATE VIEW Layoff_Per_Company_Year AS
SELECT Company, Industry, Year(date) AS Year_Layoff,
		SUM(total_laid_off) AS Total_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY Company, Industry, YEAR(date);

-- 2) Creating a view to analyze monthly layoff trends per country. 
-- The view should show the, Country, Month and year and the Total layoffs per month
CREATE VIEW Monthly_Layoff_Trends AS
SELECT Country, MONTH(date) AS Monthly_Layoff, YEAR(date) AS Yearly_Layoff,
		SUM(total_laid_off) AS Total_Layoffs
FROM company_layoffs2
WHERE total_laid_off IS NOT NULL
GROUP BY Country, MONTH(date), YEAR(date);

















































