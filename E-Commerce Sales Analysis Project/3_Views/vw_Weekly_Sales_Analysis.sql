-- CREATE A VIEW THAT ANALYZES THE WEEKLY SALES ANALYSIS

-- FIND THE:
-- MONTH
-- WEEK NUMBER
-- WEEKLY ORDERS
-- TOTAL SALES PER WEEK

CREATE VIEW vw_Weekly_Sales_Analysis AS
SELECT 
    DATENAME(MONTH, Order_Date) AS SalesMonth,
    CONCAT('Week ', DATEPART(wk, Order_Date)) AS Week_Number,
    COUNT(Order_ID) AS Total_Weekly_Orders,
    ROUND(SUM(Total_Paid),2) AS Total_Weekly_Sales
FROM Orders
WHERE Order_Date IS NOT NULL
GROUP BY MONTH(Order_Date), DATENAME(MONTH, Order_Date), DATEPART(wk, Order_Date);