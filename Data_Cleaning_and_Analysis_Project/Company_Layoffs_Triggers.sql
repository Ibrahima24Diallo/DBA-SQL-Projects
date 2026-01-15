-- WORKING WITH TRIGGERS
-- 1) Create a trigger that Runs BEFORE INSERT
-- Prevents inserting records where total_laid_off is negative
-- Raises an error or blocks the insert if the condition is violated

DELIMITER $$
CREATE TRIGGER Prevent_Negative_Records
	BEFORE INSERT ON company_layoffs2
    FOR EACH ROW
    BEGIN
		IF NEW.total_laid_off < 0 THEN SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT ='ERROR!! total_laid_off cannot be a negative value';
        END IF;
	END $$
DELIMITER ;

-- If we try to insert the values below the trigger will automatically display an error message.
INSERT INTO company_layoffs2
VALUES('Eleven20Four', 'Dakar', 'Design', -200, '-0.07', '2022-11-24', 
		'Series F', 'Senegal', 222);

-- 2) Create a trigger that automatically sets percentage_laid_off to NULL
-- When total_laid_off is NULL during INSERT or UPDATE
DELIMITER $$
CREATE TRIGGER Set_Value_To_Null 
	BEFORE INSERT ON company_layoffs2   -- OR BEFORE UPDATE ON company_layoffs2
    FOR EACH ROW
    BEGIN
		IF NEW.total_laid_off IS NULL THEN
        SET NEW.percentage_laid_off = NULL;
        END IF;
	END $$
DELIMITER ;

