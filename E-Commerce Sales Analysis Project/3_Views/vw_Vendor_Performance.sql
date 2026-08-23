--CREATE A VIEW THAT ANALYSES VENDOR PERFORMANCE USING THE:
--VENDOR
--ORDERS
--UNITS SOLD
--REVENUE

CREATE VIEW vw_Vendor_Performance AS
SELECT Vendor, 
	   COUNT(Order_ID) AS Total_Orders,
	   SUM(Item_Quantity) AS Quantity_Sold,
	   ROUND(SUM(Item_Price * Item_Quantity),2) AS Total_Revenue
FROM Products
GROUP BY Vendor;

-- Find the top 10 Vendors based on their Revenue
--SELECT *
--FROM vw_Vendor_Performance 
--ORDER BY Total_Revenue DESC;
