CREATE DATABASE SalesDB1;
USE SalesDB1;

SELECT * FROM customers;

-- 1. Calculate total sales, total profit, and total quantity sold for each Category.
SELECT category, SUM(amount) AS Total_Sales,SUM(profit) AS Total_Profit,SUM(quantity) AS Total_Quantity
FROM customers
GROUP BY category;

-- 2. Find the top 5 customers based on total purchase amount.
SELECT customername,SUM(amount) AS Total_Purchased FROM customers
GROUP BY customername
ORDER BY Total_Purchased DESC LIMIT 5;

-- 3. Show monthly sales and profit trends using the Year-Month column.
SELECT year-month, SUM(amount) AS Sales,SUM(profit) AS Profit 
FROM customers
GROUP BY year-month;

-- 4. Calculate the average order value (AOV) for each PaymentMode.
SELECT payment_mode,ROUND(AVG(amount),2) AS AOV FROM customers
GROUP BY payment_mode
ORDER BY AOV DESC;

-- 5. Identify the State and City combination generating the highest total sales.
SELECT state,city,SUM(amount) AS Total_Sales FROM customers
GROUP BY state,city
ORDER BY state,city DESC;

-- 6. Find customers who have placed orders using more than one PaymentMode.
SELECT order_id,customername,COUNT(payment_mode) AS Pyament FROM customers
GROUP BY order_id,customername
HAVING COUNT(DISTINCT payment_mode) > 1 ;

-- 7. Determine the Sub-Category-wise contribution to total sales (in percentage).
SELECT sub_category,SUM(amount) AS Sales,SUM(amount) * 100 / (SELECT SUM(amount) FROM customers) AS Contribution 
FROM customers
GROUP BY sub_category;

-- 8. Find the average profit per order for each Category.
SELECT category,ROUND(AVG(profit),2) AS Avg_Profit_Per_Order
FROM customers
GROUP BY category;

-- 9. Compare sales performance of Electronics vs Furniture across all years.
SELECT category, SUM(amount) AS Sales,SUM(profit) AS Proft FROM customers
WHERE category IN ('Electronics','Furniture')
GROUP BY category;

-- 10. Rank customers within each State based on total sales using window functions.
SELECT state,customername,
					SUM(amount) AS Total_Sales,
					RANK() OVER (PARTITION BY state ORDER BY SUM(amount) DESC) AS State_Rank
FROM customers
GROUP BY state,customername;

-- 11. Identify orders whose Amount is greater than the average Amount of their Category.
SELECT * FROM customers c 
WHERE amount > (SELECT AVG(amount) FROM customers
WHERE category = c.category);



-- 12. Calculate Category-wise profit margin (%) and rank them from highest to lowest.
SELECT category,ROUND(SUM(profit) / SUM(amount) * 100,2) AS Margin FROM customers
GROUP BY category
ORDER BY Margin DESC;






