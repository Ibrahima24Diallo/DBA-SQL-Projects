-- PERFORMANCE OPTIMIZATION USING INDEX 

-- 1) Creating an Index that Improves searches by Order_Date
CREATE INDEX idx_Order_Date
ON Orders (Order_Date);

-- 2) Create an appropriate index that improves the performance of JOIN operations 
-- between the Orders and Products tables using the Order_ID column.

CREATE NONCLUSTERED INDEX idx_Products_Order_ID
ON Products (Order_ID);

-- 3) between the Orders and CustomerrInfo tables using the Order_ID column.
CREATE NONCLUSTERED INDEX idx_CustomerInfo_Order_ID
ON CustomerInfo (Order_ID);

-- 4) Create a composite index to improve product searches using the sku, and the item_name

CREATE INDEX idx_SKU_Item_Name
ON Products (SKU, Item_Name);

-- a nonclustered index lets the RDBMS quicqkly find the matching row instaed of scannin g the whole table
-- The primary is usually clustered and additional indexes are non clustered
-- A clustered index determines the physical order of the rows in a table.