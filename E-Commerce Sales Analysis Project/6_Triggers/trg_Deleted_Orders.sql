-- CREATING A TRIGGER THAT RECORDS EVERY DELETED ORDER INTO AN AUDIT TABLE.

-- 1) FIRST, WE NEED TO CREATE AN AUDIT TABLE THAT CAPTURES EVERY DELETED ROW FROM THE ORDERS TABLE

-- Copying all the columns from the Orders table into an audit table.
SELECT *
INTO Orders_Audit
FROM Orders
WHERE 1=0; -- This creates the table structure without copying any data

-- 2) LET'S ADD COLUMNS THAT AUTOMATICALLY REGISTER THE USER WHO DELETED A ROW AND WHEN IT WAS DELETED.

-- Adding a column that gives each audit record a unique identifier.
ALTER TABLE Orders_Audit
ADD Audit_ID INT IDENTITY(1, 1) PRIMARY KEY;

-- Adding a column that captures the login name of the user executing the delete
ALTER TABLE Orders_Audit
ADD DeletedBy SYSNAME
CONSTRAINT DFLT_OrdersAudit_DeletedBy DEFAULT SUSER_SNAME();

-- Adding a column that captures the timestamp a row was deleted
ALTER TABLE Orders_Audit
ADD Deleted_Date DATETIME
CONSTRAINT DFLT_OrdersAudit_Deleted_Date DEFAULT GETDATE();

-- 3) CREATING THE TRIGGER THAT COPIES THE ROWS DELETED INTO THE ORDER AUDIT TABLE

CREATE TRIGGER trg_Deleted_Orders             
ON Orders
AFTER DELETE
AS 
BEGIN

        -- Take every row that was just deleted and insert it into Orders_Audit.
         INSERT INTO Orders_Audit 
         (Order_ID, Order_Date, Financial_Status, Fulfillment_Status, Shipped_Date, Payment_Method, Shipping_Method,
          Shipping_Price, Taxes, Discount_Amount, Total_Paid, Refunded_Amount, Source, Email)
     
         SELECT Order_ID, Order_Date, Financial_Status, Fulfillment_Status, Shipped_Date, Payment_Method, Shipping_Method,
                Shipping_Price, Taxes, Discount_Amount, Total_Paid, Refunded_Amount, Source, Email
         FROM deleted

 END;
     


