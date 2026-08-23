--CREATE A VIEW THAT FIND THE TOTAL REVENUE AND NUMBER OF ORDERS BY STATE USING THE:
--STATE
--ORDERS
--REVENUE

CREATE VIEW vw_Sales_ByState AS
SELECT 
	   (
		CASE WHEN Shipping_State IS NULL THEN 'Undefined State'
		ELSE Shipping_State
		END
	   ) AS State,
	   COUNT(ci.Order_ID) AS Total_Orders,
	   ROUND(SUM(Total_Paid), 2) AS Total_Revenue
FROM CustomerInfo ci
JOIN Orders o 
	ON ci.Order_ID = o.Order_ID
GROUP BY Shipping_State;

-- DETERMINING THE TOTAL ORDERS AND TOTAL REVENUE BY STATE
--SELECT TOP 10 *
--FROM vw_Sales_ByState
--ORDER BY Total_Revenue DESC;

