-- WORKING WITH INDEXES TO OPTIMIZE THE PERFORMANCE
-- 1) Create an index to Improve performance for queries that filter by company and date
CREATE INDEX idx_company_date 
ON company_layoffs2 (company, `date`);

-- 2) Create an index to optimize queries filtering by country and date
CREATE INDEX idx_country_date 
ON company_layoffs2 (country, `date`);
