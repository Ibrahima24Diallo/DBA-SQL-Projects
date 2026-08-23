
-- CUSTOMER LOYALTY AND BUYING BEHAVIOR ANALYSIS
-- Identifying repeat customers by analyzing the number of times they placed an order  
-- and the total spending to better understand customer loyalty based on order frequency
SELECT Email AS Customer_Email, 
       (CASE WHEN Billing_Name = 'Anonymous Customer' THEN 'Anonymous Amazon Customer' 
        ELSE Billing_Name 
        END) AS Customer_Name, 
       COUNT(o.Order_ID) AS Total_Orders, 
       ROUND(SUM(Total_Paid), 2) as Total_Spending      
FROM CustomerInfo ci
JOIN Orders o ON ci.Order_ID = o.Order_ID
WHERE Billing_Name IS NOT NULL
GROUP BY Email, Billing_Name
HAVING COUNT(o.Order_ID) > 1
ORDER BY Total_Orders DESC;