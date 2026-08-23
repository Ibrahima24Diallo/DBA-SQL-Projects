-- =============== STORED PROCEDURE =======================

-- CREATING A STORED PROCEDURE THAT RETRIEVES THE CUSTOMERS ORDER INFORMATION BASED ON EITHER THEIR ORDER NUMBER OR THEIR FULL NAME
-- Let's say a customer calls your company about their recent order placed on your website.
-- You can either input their name to pull their order information or 
-- you can use their name to get their order details in case they don't have their order number.
-- Although customers can have the same name, you can still verify if it is the correct customer
-- by confirming their address, phone number or email etc.

CREATE PROCEDURE sp_Get_Order_Details
	   @Order_ID INT,
	   @Billing_Name NVARCHAR(255)
AS
BEGIN
	 SELECT o.Order_ID, 
			Order_Date,
			Billing_Name AS Customer_Name, 
			Email, 
			Shipping_Address,
			SKU, 
			Item_Name,
			Item_Quantity,
			Item_Price,
			SUM(Item_Price * Item_Quantity) AS Total,
			Fulfillment_Status
	  FROM Orders o
	 JOIN CustomerInfo ci 
		ON o.Order_ID = ci.Order_ID
	 JOIN Products p 
		ON ci.Order_ID = p.Order_ID
	 WHERE Billing_Name IS NOT NULL AND Order_Date IS NOT NULL
		   AND (o.Order_ID = @Order_ID OR Billing_Name = @Billing_Name)
	 GROUP BY o.Order_ID, Order_Date, Billing_Name, Email, Shipping_Address, 
			  SKU, Item_Name, Item_Quantity, Item_Price, Fulfillment_Status;			  
END; 

-- 1) CALL THE STORED PROCEDURE USING THE CUSTOMER'S NAME TO RETURN ORDER DETAILS
EXEC sp_Get_Order_Details
	 @Order_ID = '' ,
	 @Billing_Name = 'Kelly Ilczyszyn';

-- 2) CALL THE STORED PROCEDURE USING THE CUSTOMER'S ORDER NUMBER TO RETURN ORDER DETAILS
EXEC sp_Get_Order_Details
	 @Order_ID = 79072 ,
	 @Billing_Name = '';






