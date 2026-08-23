-- =============== STORED PROCEDURE =======================
-- CREATING A STORED PROCEDURE THAT RETURNS SALES FOR A SELECTED VENDOR 
-- SUCH AS (Hue, Anita or Chantelle) etc...

CREATE PROCEDURE sp_Sales_By_Vendor 
		@Vendor NVARCHAR(50)
AS
BEGIN
	 SELECT Vendor,
			COUNT(Order_ID) AS Total_Orders,
			SUM(Item_Price * Item_quantity) AS Total_Sales
	 FROM Products
	 WHERE Vendor = @Vendor
	 GROUP BY Vendor;
END;

-- -- CALLING THE STORED PROCEDURE AND RETURN SALES INFORMATION FROM THE VENDOR CALLED 'Hue'
EXECUTE sp_Sales_By_Vendor 
		@Vendor = 'Hue';