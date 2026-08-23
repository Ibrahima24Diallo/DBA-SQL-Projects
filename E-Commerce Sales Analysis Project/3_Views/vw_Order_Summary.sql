--CREATE A VIEW THAT SUMMARIZES ALL THE ORDERS  

--ORDER ID
--ORDER DATE
--CUSTOMER EMAIL
--TOTAL PAID
--SHIPPING METHOD
--FINANCIAL STATUS

CREATE VIEW vw_Order_Summary AS
SELECT Order_ID, Order_Date, Email,
	   Shipping_Method,
	   SUM(Total_Paid) AS Total_Revenue,
	   Financial_Status
FROM Orders 
WHERE Order_Date IS NOT NULL
GROUP BY Order_ID, Order_Date, Email,
		 Shipping_Method, Financial_Status;


