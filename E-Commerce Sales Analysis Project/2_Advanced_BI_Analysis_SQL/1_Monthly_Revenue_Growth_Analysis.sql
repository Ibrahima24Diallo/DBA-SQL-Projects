
-- MONTHLY REVENUE GROWTH ANALYSIS
-- Analyze month-over-month revenue growth to identify sales trends 
-- and periods of business growth or decline.

WITH Monthly_Revenue_CTE AS (
    SELECT DATENAME(MONTH, Order_date) AS Month_Name, MONTH(Order_Date) AS Month_Num, 
           ROUND(SUM(Total_Paid), 2) AS Total_Revenue
    FROM orders 
    GROUP BY DATENAME(MONTH, Order_date), MONTH(Order_Date)
)
SELECT Month_Name, Month_Num, Total_Revenue,
       LAG(Total_Revenue, 1) OVER(ORDER BY Month_Num) AS Previous_Month_Revenue,
       ROUND((Total_Revenue - LAG(Total_Revenue, 1) OVER(ORDER BY Month_Num))
       /
       NULLIF(LAG(Total_Revenue, 1) OVER(ORDER BY Month_Num), 0) * 100, 2) AS MoM_Growth_Percentage
FROM Monthly_Revenue_CTE
ORDER BY Month_Num;



