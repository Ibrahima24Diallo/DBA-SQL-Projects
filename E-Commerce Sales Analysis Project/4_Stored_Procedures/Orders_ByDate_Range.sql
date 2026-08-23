-- =============== STORED PROCEDURE =======================

-- CREATING A STORED PROCEDURE THAT RETURNS ALL ORDERS FOR A GIVEN DATE RANGE.

CREATE PROCEDURE sp_OrdersBYDateRange 
		@StartDate DATE,
		@EndDate DATE
AS
BEGIN
	 SELECT o.Order_ID, 
			Billing_Name, 
			Order_Date, 
			Item_Name, 
			SKU,
			Item_Quantity,
			Item_Price,
			ROUND(SUM(Item_Price * Item_Quantity),2) AS Total_Revenue
	 FROM Orders o
	 JOIN CustomerInfo ci 
		ON o.Order_ID = ci.Order_ID
	 JOIN Products p 
		ON ci.Order_ID = p.Order_ID
	 WHERE Billing_Name IS NOT NULL AND Order_Date IS NOT NULL
		   AND Order_Date >= @StartDate 
		   AND Order_Date < DATEADD(DAY, 1, @EndDate)
	 GROUP BY o.Order_ID, Billing_Name, Order_Date, 
			  Item_Name, SKU, Item_Quantity, Item_Price;	 
END;

-- CALL THE STORED PROCEDURE AND RETRIEVE ORDERS FROM A SPECIFIC DATE RANGE

EXECUTE sp_OrdersBYDateRange
	 @StartDate = '2026-2-28',
	 @EndDate = '2026-2-28';