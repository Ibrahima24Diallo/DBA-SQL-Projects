
-- ABOVE AVERAGE PRODUCT REVENUE ANALYSIS
-- Identifying products whose sales are above the average product revenue.

WITH Product_Revenue AS (
    SELECT SKU, Item_Name, SUM(Item_Price * Item_Quantity) AS Total_Revenue
    FROM Products
    GROUP BY SKU, Item_Name
)
SELECT SKU, Item_Name, Total_Revenue
FROM Product_Revenue
WHERE Total_Revenue > 
    (
     SELECT AVG(Total_Revenue) 
     FROM Product_Revenue      
    ) 
ORDER BY Total_Revenue DESC;  