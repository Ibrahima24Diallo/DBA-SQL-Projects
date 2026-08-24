# E-Commerce Sales Analysis \& SQL Server Database Project



## Skills Demonstrated in This Project

* Excel Data Cleaning
* Database Design using SQL Server
* Data Analysis using SQL Queries
* Joins \& Aggregations
* CTEs \& Window Functions
* Views and Indexing
* Stored Procedures and Triggers
* Power BI Sales Report



## Project Overview

This project was based on an actual e-commerce sales data that I worked on in a professional work setting. I downloaded sales data from the company's Shopify store for the months of February through May. The data included sales from multiple e-commerce platforms, including Amazon, eBay, TikTok, and the company's website.

The goal of the project was to clean the sales data, import it then organize it into a SQL Server database with tables then answer business questions by analyzing the data using SQL queries. Also, create multiple SQL views for reporting and connect Power BI directly to SQL Server views. Finally, design an interactive dashboard for sales, customer, product, and geographic analysis etc...

## 1) Data Cleaning in Excel

I first used Excel to clean the raw sales data downloaded from the company's Shopify store before importing it into SQL Server.

The cleaning process included:

* Removing duplicate records, null and unnecessary values
* Removing columns that were not needed for the analysis
* Formatting columns to the correct data types
* Reviewing the data for any inconsistencies to avoid inaccurate analysis



After cleaning the data, I saved the final Excel file and made sure it was ready to be imported into SQL Server Management Studio (SSMS).



## 2\) Database Design in SQL Server

After importing the cleaned data into SQL Server, I divided the data into three tables such as:

* Orders – This table contains order details such Order\_ID, dates, payment information, fulfillment status, and order totals.
* Products – This table contains product information such as SKU, item name, vendor, quantity, and price.
* CustomerInfo – This table contains customer and shipping information.



I used the Order\_ID as the primary key and the foreign key to create relationships between the three tables.

This made the data easier to manage and allowed me to use SQL joins to combine information from the three tables.



## 3\) SQL Data Analysis

After creating the tables, I used SQL Server to analyze the sales data and answer different business questions using SQL features such as:
JOIN, GROUP BY, HAVING, CASE, CTEs, Subqueries, Aggregate functions, Window functions, LAG(), ROW\_NUMBER()

I first answered basic business questions then moved to more advanced analysis.
Some of the analysis included:

* Monthly revenue, total orders and average order value (AOV)
  <img width="772" height="189" alt="2_Monthly_Sales_Performance" src="https://github.com/user-attachments/assets/dfc29330-de03-4e9f-abb5-1ab19f17e7bf" />

* Sales by vendor
  <img width="735" height="147" alt="3_Revenue_by_Vendor" src="https://github.com/user-attachments/assets/b10b8c2a-ce43-4f42-86c0-bccfd59af515" />

* Revenue by state
  <img width="754" height="265" alt="4_Sales_by_State" src="https://github.com/user-attachments/assets/b9407d10-329a-4aba-bac3-9e656801e8c2" />

* Top Selling Products
  <img width="429" height="146" alt="8_Top_Selling_Products" src="https://github.com/user-attachments/assets/39e6536a-9a9a-4fd7-bc27-0624d27cf76a" />

* Month-over-month revenue growth
  <img width="777" height="285" alt="image" src="https://github.com/user-attachments/assets/ac94e9f6-0d56-4c5b-b342-59e9f84daaeb" />

* Cumulative sales trend
  <img width="855" height="184" alt="image" src="https://github.com/user-attachments/assets/ee26ea18-98a5-48d5-8c1a-bae4f9e9d91b" />

## 4\) SQL Views

I created several views to make data easier to work with and make commonly used analysis easier to access.

Some of the views included:

* Monthly Sales
* Top Products
* Sales by State
* Vendor Performance
* Order Summary
* Shipping Analysis
* Top Customers
* Weekly Orders and Sales

The views summarized the data that later in the project was used as a source for creating reports in Power BI.



## 5\) Stored Procedures

I created stored procedures to make some of the SQL code reusable instead of having to write the same query every time.

The Stored Procedures included:

* Searching orders by date range
* Searching orders by state
* Viewing sales by vendor
* Finding top products by revenue
* Viewing sales by month



I used parameters so that different values could be entered without having to rewrite the SQL query.



## 6\) Indexes

I also created indexes to demonstrate performance optimization techniques.

Examples included indexes on:

* Order\_Date
* CustomerInfo.Order\_ID
* Products.SKU and Item\_Name



The purpose of these indexes was to help SQL Server improve the speed of data retrieval from table(s) by creating a lookup structure.



## 7\) Triggers

I created triggers to demonstrate database automation and data protection within a real business workflow.

Example of Triggers I created included

* Deleted Order Audit

I created an Orders\_Audit table to keep a record of all deleted orders.

The trigger uses SQL Server's deleted temporary table to capture the records that were removed from the Orders table.

The audit table also includes an AuditID to identify the user who deleted the record and the time the record was deleted.



* Prevent Negative Total Amount

I created a trigger that checks newly inserted orders.

If for example the Total\_Paid is less than or equal to zero (<=0), the trigger prevents the transaction from going through and returns an error message.



## 8\) Power BI Dashboard

The SQL views was used to connect Power BI with SQL Server to create reports and visualization.

The purpose is to use the cleaned and organized SQL Views data to create dashboards showing for example sales performance, products, vendors, orders, and other important business information in Power BI.



## 9\) Business Insights \& Recommendations

After analyzing the sales data, I found several areas where the business could improve inventory planning, fulfillment, shipping, and customer marketing.



* **Product Performance**

The Brassy Bra products showed more consistent sales across the months and appeared to perform especially well on Amazon, regardless of the product variant.

I would recommend to keep these products as a priority when planning inventory and promotions. For products that only sell once or twice a month, I would review the current inventory before purchasing more. This could help reduce overstocking products with low demand.



* **Vendor Performance**

Some vendors, such as Prima,, Ani and Emprnte, although having some of the most expensive products, had stronger sales and quantity sold compared to other vendors.

My recommendation is to continue monitoring these vendors and make sure popular products are kept in stock. For vendors with lower sales, I would review product demand, pricing, and product selection before deciding whether to continue purchasing at the same level.



* **Fulfillment Performance**

One of the findings that stood out was that many of the cancelled and returned/refunded orders came from the company's website. Some products that sell well on other platforms, especially on Amazon, seem to have difficulty performing well when purchased through the company's website.

I'd suggest investigating why this is happening. I would compare inventory levels, product descriptions, fulfillment times, and return reasons between the company's website and other platforms. This could help determine whether the problem is related to inventory, fulfillment, customer expectations, or the products themselves.



* **Shipping Costs**

The analysis showed that the current overnight shipping rate of $35 may not fully cover the actual shipping cost for most states located in the west, such as California, Colorado. It seems the carrier cost can be significantly higher, sometimes twice the price of the original overnight shipping fee.

What I would recommend is to consider reviewing the overnight shipping rate and testing a higher rate, such as $45. I would also consider offering a $25 two-day shipping option. This could give customers a lower-cost alternative while helping the business better manage shipping expenses. However, before making the change, I would compare the proposed rates with actual carrier costs and customer demand to make sure the new pricing is reasonable.



* **Customer \& Marketing Analysis**

The data was also able to help me identify customers who have purchased multiple times and customers who accepted marketing.

My recommendation would  be to create targeted marketing campaigns for repeat customers instead of sending the same promotions to everyone. For example, customers who regularly purchase certain products could receive promotions or recommendations related to those products. This could help increase repeat purchases and improve customer retention.



#### Overall Recommendation

The advantage of these recommendations is to use the sales data to make inventory, fulfillment, shipping, and marketing decisions based on actual sales patterns rather than treating all products, vendors, and sales channels the same. To sum up my analysis, the business should focus more on its top performing products and vendors, investigate the higher cancellation and return activity on its website and review shipping rates to better balance customer cost and business expenses.

**Note:** These recommendations are based on the sales data analyzed in this project and are intended to identify areas for further investigation and potential improvement.

