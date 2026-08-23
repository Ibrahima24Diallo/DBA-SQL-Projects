-- VENDOR PRODUCT PERFORMANCE RANKING
-- Rank products for each vendor based on total sales to identify top-performing products

SELECT Vendor, Item_Name, SKU, SUM(Item_Price * Item_Quantity) AS Total_Sales, 
       ROW_NUMBER() OVER(PARTITION BY Vendor ORDER BY SUM(Item_Price * Item_Quantity) DESC) r_num
FROM Products
GROUP BY Vendor, Item_Name, SKU
ORDER BY Total_Sales DESC;
