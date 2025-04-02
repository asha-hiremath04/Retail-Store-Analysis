CREATE DATABASE retail_store_analysis;
use retail_store_analysis;

CREATE TABLE stores (
    Store_ID INT PRIMARY KEY,
    Store_Area INT,
    Items_Available INT,
    Daily_Customer_Count INT,
    Store_Sales DECIMAL(10,2),
    Estimated_Profit DECIMAL(10,2),
    Sales_per_Customer DECIMAL(10,2),
    Revenue_Category VARCHAR(10),
    Customer_Density DECIMAL(10,4),
    Sales_per_Item DECIMAL(10,2),
    Store_Size_Category VARCHAR(15)
);
# 1. Estimated Profit per Customer
SELECT Store_ID, Estimated_Profit * Daily_Customer_Count AS Estimated_Profit_per_Customer
FROM stores;

# 2.Total Estimated Profit
SELECT Store_ID, SUM(Estimated_Profit) AS Total_Estimated_Profit
FROM stores
GROUP BY Store_ID;

# 3.Average Sales per Store
SELECT AVG(Store_Sales) AS Avg_Sales FROM stores;

# 4.Total Sales by Store (Highest First)
SELECT Store_ID, SUM(Store_Sales) AS Total_Sales
FROM stores
GROUP BY Store_ID
ORDER BY Total_Sales DESC;

# 5.Customer Density vs. Sales
SELECT Store_ID, Customer_Density, Store_Sales
FROM stores;

# 6.  Store Size and Revenue Category Performance
SELECT Store_Size_Category, Revenue_Category, AVG(Store_Sales) AS Avg_Sales
FROM stores
GROUP BY Store_Size_Category, Revenue_Category;

# 7.Customer Count and Sales Comparison
SELECT Daily_Customer_Count, Store_Sales
FROM stores
ORDER BY Daily_Customer_Count;


