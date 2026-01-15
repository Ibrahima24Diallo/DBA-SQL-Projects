-- DATA CLEANING PROJECT
SELECT * 
FROM worldwide_layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Update or Remove Null Values or Blank Values
-- 4. Remove Any unnecessary columns or rows

-- Let's copy the raw data into a new table so we can keep the original file/data
-- in case something happens to the duplicate table.
CREATE TABLE company_layoffs
LIKE worldwide_layoffs;

-- Copying all the data from the worldwide_layoffs table to the company_layoffs table
INSERT INTO company_layoffs
SELECT *
FROM worldwide_layoffs;
-- Let's test and see if all the raw data was copied
SELECT * 
FROM company_layoffs;

-- 1. We will first remove the duplicates
WITH Remove_Duplicates AS (
	SELECT *, 
    ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, 
    percentage_laid_off, `date`, stage, country, funds_raised_millions) as r_num
    FROM company_layoffs
)
SELECT *
FROM Remove_Duplicates
WHERE r_num > 1;
 -- Since it's a bit complicated to remove duplicate rowsa in Mysql 
 -- compared to SSMS that allows the removal of duplicates within a CTE,
 -- We do something different, which creating anoither table and including
 -- the r_num from the CTE as a column then use it to delete the duplicate row(s).
-- LET'S CREATE A NEW TABLE
CREATE TABLE company_layoffs2
LIKE company_layoffs;
-- Turning the Window Fucntions from CTE into a column
ALTER TABLE company_layoffs2
ADD r_num INT;

-- COpying all the data into the new table including the r_num column and its data
INSERT INTO company_layoffs2
SELECT *, 
    ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, 
    percentage_laid_off, `date`, stage, country, funds_raised_millions) as r_num
    FROM company_layoffs;
-- Testing if the r_num column was added and its data inserted
SELECT *
FROM company_layoffs2
WHERE r_num > 1;

-- This code enables Updates and Deletes with no restrictions
SET SQL_SAFE_UPDATES = 0; 

-- Removing all the duplicates from the new tables
DELETE
FROM company_layoffs2
WHERE r_num > 1;

-- 2. STANDARDIZING DATA: Finding issues in the data and fixing it. 
-- Removing extra spaces for selected columns
SELECT company, TRIM(company)
FROM company_layoffs2;

UPDATE company_layoffs2
SET company = TRIM(company);

-- Update Table and add missing values into selected columns

UPDATE company_layoffs2
SET industry = 'Travel'
WHERE company = 'Airbnb' AND Location = 'SF Bay Area' AND industry = '';

UPDATE company_layoffs2
SET industry = 'Transportation'
WHERE company = 'Carvana' AND Location = 'Phoenix' AND industry = '';

UPDATE company_layoffs2
SET industry = 'E-Cigarettes'
WHERE company = 'Juul' AND Location = 'SF Bay Area' AND industry = '';

UPDATE company_layoffs2
SET industry = 'Sports Betting'
WHERE company = 'Bally''s Interactive' AND Location = 'Providence' 
	AND industry IS NULL;

select * 
from company_layoffs2 
where company = 'juul';
-- Let's double check    
SELECT *
FROM company_layoffs2
WHERE industry IS NULL OR industry = '';

-- Remove the dot(.) at the end of THE US country name.
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM company_layoffs2
ORDER BY 1;

UPDATE company_layoffs2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States.%';

-- Change the rows that say 'Crypto Currency' to 'Crypto' only 
UPDATE company_layoffs2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Add the missing date value to the company named 'Blackbaud'
SELECT *
FROM company_layoffs2
WHERE company = 'Blackbaud';

UPDATE company_layoffs2
SET date = '2022-11-24'
WHERE company = 'Blackbaud';

-- Let's chnage the date format of the date column to match it with MySQL date format
SELECT `date`-- , STR_TO_DATE(`date`, '%m/%d/%Y')
FROM company_layoffs2;

UPDATE company_layoffs2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
 -- Let's change the date column's data type from TEXT to DATE. 
ALTER TABLE company_layoffs2
MODIFY COLUMN `date` DATE;
-- DESCRIBE company_layoffs2; 

-- Let's delete columns with null values
SELECT * 
FROM company_layoffs2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE
FROM company_layoffs2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Let's delete the r_num column since we don't need it anymore
ALTER TABLE company_layoffs2
DROP COLUMN r_num;

-- Let's check if the r_num column was deleted or still exists
SELECT COUNT(*) AS column_exists
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'worldwide_layoffs'
	AND TABLE_NAME = 'company_layoffs2'
    AND COLUMN_NAME = 'r_num';
























