-- STORED PROCEDURES
-- 1) Create a stored procedure that accepts a year as a parameter
-- Returns the top 10 companies with the highest total layoffs for that year
-- Orders results from highest to lowest layoffs

DELIMITER $$
CREATE PROCEDURE Company_Highest_Layoff(IN sp_year INT) 
BEGIN 
	SELECT Company, sp_year AS Yearly_Layoff, 
			SUM(total_laid_off) AS Total_Layoffs
	FROM company_layoffs2
	WHERE total_laid_off IS NOT NULL
    AND YEAR(date) = sp_year
    GROUP BY Company
    ORDER BY Total_Layoffs DESC
    LIMIT 10;
END $$
DELIMITER ;

-- Excuting the strored procedure using the CALL statement
CALL Company_Highest_Layoff(2021);

-- 2) Creating a stored procedure that accepts a country name as a parameter
-- Returns monthly layoffs for that country
-- and includes a cumulative (running) total of layoffs over time.

DELIMITER $$
CREATE PROCEDURE Cumulative_Layoffs(IN sp_country VARCHAR(100))
BEGIN 
	SELECT MONTHNAME(date) AS Monthly_Layoff, YEAR(date) AS Yearly_Layoff, 
			SUM(total_laid_off) AS Monthly_Layoffs,
            SUM(SUM(total_laid_off)) OVER ( 
			ORDER BY YEAR(date), MONTHNAME(date)
            ) AS Layoffs_Overtime
	FROM company_layoffs2
	WHERE total_laid_off IS NOT NULL
    AND country = sp_country
    GROUP BY YEAR(date), MONTHNAME(date)
    ORDER BY Yearly_Layoff, Monthly_Layoff;
END $$
DELIMITER ;

-- Excuting the strored procedure using the CALL statement    
CALL Cumulative_Layoffs('Canada'); 