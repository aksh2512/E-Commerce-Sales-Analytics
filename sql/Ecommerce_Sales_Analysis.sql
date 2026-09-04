-- E-Commerce Sales & Customer Analytics
-- SQL Business Analysis

-- 1. Total Sales and Total Profit
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales;


-- 2. Sales by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM ecommerce_sales
GROUP BY Category
ORDER BY Total_Sales DESC;


-- 3. Top 10 Products by Sales
SELECT
    Product,
    SUM(Sales) AS Total_Sales
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;


-- 4. Top 10 Products by Profit
SELECT
    Product,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Profit DESC
LIMIT 10;


-- 5. Sales and Profit by Region
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales
GROUP BY Region
ORDER BY Total_Sales DESC;


-- 6. Top 10 Customers by Sales
SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Number_of_Orders
FROM ecommerce_sales
GROUP BY Customer_ID
ORDER BY Total_Sales DESC
LIMIT 10;


-- 7. Monthly Sales and Profit
SELECT
    strftime('%Y-%m', Order_Date) AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales
GROUP BY strftime('%Y-%m', Order_Date)
ORDER BY Month;


-- 8. Overall Profit Margin
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin
FROM ecommerce_sales;


-- 9. Discount vs Profit Margin
SELECT
    Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin
FROM ecommerce_sales
GROUP BY Discount
ORDER BY Discount;


-- 10. Product Ranking by Sales
WITH product_sales AS (
    SELECT
        Product,
        SUM(Sales) AS Total_Sales
    FROM ecommerce_sales
    GROUP BY Product
)
SELECT
    Product,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM product_sales
ORDER BY Sales_Rank;


-- 11. Customer Ranking by Sales
WITH customer_sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM ecommerce_sales
    GROUP BY Customer_ID
)
SELECT
    Customer_ID,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM customer_sales
ORDER BY Sales_Rank;


-- 12. Top 10 Customer Performance and Average Order Value
SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Number_of_Orders,
    ROUND(
        SUM(Sales) * 1.0 / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM ecommerce_sales
GROUP BY Customer_ID
ORDER BY Total_Sales DESC
LIMIT 10;
