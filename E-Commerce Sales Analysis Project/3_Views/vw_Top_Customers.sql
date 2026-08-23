-- CREATE A VIEW THAT ANALYSES CUSTOMER BUYING BEHAVIOR 

-- Show Customer spending and order frequency

CREATE VIEW vw_Top_Customers AS
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
HAVING COUNT(o.Order_ID) > 1;

-- Identifying top customers who placed more than one orders
--SELECT * 
--FROM vw_Top_Customers
--ORDER BY Total_Orders DESC;