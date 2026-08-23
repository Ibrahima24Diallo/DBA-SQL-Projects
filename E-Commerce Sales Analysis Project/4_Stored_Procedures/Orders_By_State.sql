-- ================= STORED PROCEDURE ==============================

-- Creating a stored procedure that returns all orders for a specific state.
-- Let's say we want to find out all orders placed from New York, 
-- we can pass the value "New York" to the parameters and it will return all orders from New York 

CREATE PROCEDURE sp_Orders_By_State
	   @State NVARCHAR(50)
AS
BEGIN
	 SELECT ci.Order_ID, 
			(CASE WHEN Billing_Name = 'Anonymous Customer' THEN 'Amazon Order'
			 ELSE Billing_Name 
			 END) AS Customer_Name, 
			Shipping_State,
			Item_Name, 
			SKU,
			Item_Quantity,
			Item_Price 	
	 FROM CustomerInfo ci 
	 JOIN Products p 
		  ON ci.Order_ID = p.Order_ID
	 WHERE Billing_Name IS NOT NULL AND Shipping_State IS NOT NULL
		   AND Shipping_State = @State
	 GROUP BY ci.Order_ID, Shipping_State, Billing_Name, Item_Name, SKU, Item_Quantity, Item_Price;
END;

-- CALLING THE STORED PROCEDURE TO RETRIEVE ORDERS FROM A SPECIFIC STATE
EXECUTE sp_Orders_By_State
		@State = 'New York'