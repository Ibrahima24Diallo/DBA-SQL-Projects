
--===================== DATABASE DESIGN ==================================

--After importing the cleaned data into SQL Server, I separated the data into three tables:
-- Orders 
-- Products 
-- CustomerInfo 
--I used the Order_ID column to connect the 3 tables and worked with primary and foreign key relationships where needed.

-- Let's verify we have all the expected columns.
SELECT top 10 * 
FROM shopify_sales_raw;

-- Let's format the data type of some of the columns 
-- Change the Order_ID data type to int
Alter Table shopify_sales_raw
Alter Column Order_ID int;

-- Change the item_quantity data type to int
Alter Table shopify_sales_raw
Alter Column item_quantity int;

-- Change the Billing_Zipcode data type to String
Alter Table shopify_sales_raw
Alter Column Billing_Zipcode nvarchar(10);

-- Change the Shipping_Zipcode data type to String
Alter Table shopify_sales_raw
Alter Column Shipping_Zipcode nvarchar(10);

UPDATE shopify_sales_raw
SET Item_Name = 'Gift Card'
WHERE Item_Name LIKE '%Extender Gift Card%';

UPDATE shopify_sales_raw
SET Vendor = 'Bra Extender'
WHERE Vendor = 'Shop Extender'


-- CREATING 3 DIFFERENTS TABLES FROM THE RAW DATA USING SQL
-- 1) Creating the Orders table
SELECT DISTINCT
    Order_ID,
    Order_Date,
    Financial_Status,
    Fulfillment_Status,
    Shipped_Date,
    Payment_Method,
    Shipping_Method,
    Shipping_Price,
    Taxes,
    Discount_Amount,
    Total_Paid,
    Refunded_Amount,
    Source,
    Email
INTO Orders
FROM shopify_sales_raw;

-- 2) Creating the Products table
SELECT
    Order_ID,
    SKU,
    Item_Name,
    Item_Quantity,
    Item_Price,
    Vendor
INTO Products
FROM shopify_sales_raw;

-- 3) Creating the CustomerInfo table
SELECT DISTINCT
    Order_ID,
    Billing_Name,
    Billing_Address,
    Billing_City,
    Billing_State,
    Billing_Zipcode,
    Shipping_Name,
    Shipping_Address,
    Shipping_City,
    Shipping_State,
    Shipping_Zipcode,
    Accepts_Marketing
INTO CustomerInfo
FROM shopify_sales_raw;

