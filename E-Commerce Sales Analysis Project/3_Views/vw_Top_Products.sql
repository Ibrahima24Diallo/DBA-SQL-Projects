-- CREATE A VIEW THAT IDIENTIFIES THE TOP 10 PRODUCTS SOLD USING THE:
-- SKU 
-- PRODUCT NAME
-- QUANTITY SOLD
-- REVENUE

CREATE VIEW vw_Top_Products AS
SELECT SKU, Item_Name,
	   SUM(Item_Quantity) AS Quantity_Sold,
	   ROUND(SUM(Item_Price * Item_Quantity), 2) AS TotaL_Revenue
FROM Products 
GROUP BY SKU, Item_Name;

-- Remove Comments then Run Query to Find the the TOP 10 Products Sold
--SELECT TOP 10 *
--FROM vw_Top_Products
--ORDER BY TotaL_Revenue DESC;

