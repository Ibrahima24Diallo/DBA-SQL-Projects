-- CREATE A VIEW THAT ANALYZES THE SHIPPING FEES FOR EACH SELLING CHANNEL
-- Show the number of orders shipped and the Total Shipping paid based on the E-Commerce Platform 
-- and the Shipping Method used. 

CREATE VIEW vw_ShippingFee_Analysis AS
SELECT Source, Shipping_Method,
       COUNT(O.Order_ID) AS Total_Orders,
       ROUND(SUM(Shipping_Price), 2) AS Total_Shipping_Fees
FROM Orders O
JOIN Products p ON o.Order_ID = p.Order_ID
WHERE Shipping_Method IS NOT NULL 
GROUP BY Source, Shipping_Method;