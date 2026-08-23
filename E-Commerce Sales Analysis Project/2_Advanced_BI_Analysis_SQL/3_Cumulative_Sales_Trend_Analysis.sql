-- CUMULATIVE SALES TREND ANALYSIS
-- Calculating cumulative sales over time to measure business growth and monitor the overall sales performance.
SELECT DATENAME(MONTH, Order_Date) AS Month_Name, MONTH(Order_Date) AS Month_Number, 
       ROUND(SUM(Total_Paid), 2) AS Total_Sales,   
       SUM(SUM(Total_Paid)) OVER(
           ORDER BY MONTH(Order_Date)
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS Cumulative_Sales
FROM Orders 
GROUP BY DATENAME(MONTH, Order_Date), MONTH(Order_Date);
