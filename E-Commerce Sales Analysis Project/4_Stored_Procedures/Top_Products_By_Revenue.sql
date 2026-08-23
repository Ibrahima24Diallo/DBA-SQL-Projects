-- =============== STORED PROCEDURE =======================

-- CREATING A STORED PROCEDURE THAT RETURNS THE TOP N PRODUCTS SOLD BASED ON REVENUE.

CREATE PROCEDURE sp_Top_Products_By_Revenue
		@TopN INT
AS 
BEGIN
	 SELECT Top (@TopN) SKU,
			Item_Name,
			SUM(Item_Quantity * Item_Price) AS Total_Revenue
	 FROM Products
	 GROUP BY SKU, Item_Name
	 ORDER BY Total_Revenue DESC;
END;

-- CALLING THE STORED PROCEDURE TO RETRIEVE, THE TOP 10 HIGHEST EARNING PRODUCTS
EXEC sp_Top_Products_By_Revenue 
	 @TopN = 10;
