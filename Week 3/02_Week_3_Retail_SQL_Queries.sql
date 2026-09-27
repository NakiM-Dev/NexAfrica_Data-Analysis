-- WEEK 3: SQL FOR DATA ANALYSIS
-- Tool: SQLite | Dataset: Superstore Sales
-- Required SQL: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, JOIN,
-- SUM, COUNT, AVG, MIN, MAX.

-- Schema is represented by sales, regions and categories tables.

-- Basic SELECT / WHERE / ORDER BY
SELECT Order_ID,Order_Date,Customer_Name,Category,Product_Name,Sales,Profit
FROM sales WHERE Sales >= 1000 ORDER BY Sales DESC;

-- MIN / MAX
SELECT MIN(Sales) Minimum_Sales, MAX(Sales) Maximum_Sales,
       MIN(Profit) Minimum_Profit, MAX(Profit) Maximum_Profit FROM sales;

-- Q1 — Core KPIs
SELECT ROUND(SUM(Sales),2) Total_Sales, ROUND(SUM(Profit),2) Total_Profit,
COUNT(DISTINCT Order_ID) Total_Orders, COUNT(DISTINCT Customer_ID) Total_Customers,
SUM(Quantity) Total_Quantity, ROUND(AVG(Sales),2) Avg_Line_Sales,
ROUND(SUM(Profit)*100.0/SUM(Sales),2) Profit_Margin_Percent FROM sales;

-- Q2 — Top products
SELECT Product_Name, ROUND(SUM(Sales),2) Total_Sales,
SUM(Quantity) Units_Sold, ROUND(SUM(Profit),2) Total_Profit FROM sales
GROUP BY Product_Name ORDER BY Total_Sales DESC LIMIT 10;

-- Q3 — Regional performance with JOIN
SELECT s.Region,r.Region_Manager,ROUND(SUM(s.Sales),2) Total_Sales,
ROUND(SUM(s.Profit),2) Total_Profit,COUNT(DISTINCT s.Order_ID) Orders,
ROUND(SUM(s.Profit)*100.0/SUM(s.Sales),2) Profit_Margin_Percent
FROM sales s JOIN regions r ON s.Region=r.Region
GROUP BY s.Region,r.Region_Manager ORDER BY Total_Sales DESC;

-- Q4 — Category performance with JOIN
SELECT s.Category,c.Category_Group,ROUND(SUM(s.Sales),2) Total_Sales,
ROUND(SUM(s.Profit),2) Total_Profit,SUM(s.Quantity) Quantity_Sold
FROM sales s JOIN categories c ON s.Category=c.Category
GROUP BY s.Category,c.Category_Group ORDER BY Total_Sales DESC;

-- Q5 — Monthly performance
SELECT Month_Name,Month,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit FROM sales
GROUP BY Month,Month_Name ORDER BY Total_Sales DESC;

-- Q6 — Top customers
SELECT Customer_ID,Customer_Name,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit,COUNT(DISTINCT Order_ID) Orders
FROM sales GROUP BY Customer_ID,Customer_Name ORDER BY Total_Sales DESC LIMIT 10;

-- Q7 — Loss-making products (HAVING)
SELECT Product_Name,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit,ROUND(SUM(Profit)*100.0/SUM(Sales),2) Profit_Margin_Percent
FROM sales GROUP BY Product_Name HAVING SUM(Profit)<0 ORDER BY Total_Profit ASC LIMIT 10;

-- Q8 — States above $50,000 sales (HAVING)
SELECT State,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit FROM sales GROUP BY State
HAVING SUM(Sales)>50000 ORDER BY Total_Sales DESC;

-- Q9 — Customer segments
SELECT Segment,COUNT(DISTINCT Customer_ID) Customers,
COUNT(DISTINCT Order_ID) Orders,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit,ROUND(AVG(Sales),2) Avg_Line_Sales
FROM sales GROUP BY Segment ORDER BY Total_Sales DESC;

-- Q10 — Annual trend
SELECT Year,ROUND(SUM(Sales),2) Total_Sales,
ROUND(SUM(Profit),2) Total_Profit,SUM(Quantity) Quantity_Sold
FROM sales GROUP BY Year ORDER BY Year;

-- Additional WHERE example
SELECT Order_ID,Product_Name,Sales,Profit FROM sales
WHERE Category='Technology' ORDER BY Sales DESC;
