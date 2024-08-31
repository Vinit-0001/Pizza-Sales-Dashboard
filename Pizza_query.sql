create database pizza;
use pizza;
SELECT * FROM pizza_sales;
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales;
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;
SELECT COUNT(DISTINCT order_id) AS Total_Order_Placed FROM pizza_sales;
SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS Avg_Pizza_Per_Order FROM pizza_sales;

# Daily Trend 
SELECT dayname(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_day, COUNT(DISTINCT order_id) 
FROM pizza_sales
GROUP BY dayname(STR_TO_DATE(order_date, '%d-%m-%y'));

# Hourly Trend
SELECT hour(order_time) AS order_hours, COUNT(DISTINCT order_id)
FROM pizza_sales
GROUP BY hour(order_time);

# Percentage of Sales
SELECT pizza_category, round(SUM(total_price)) AS Total_Sales,round(SUM(total_price) *100/ (SELECT SUM(total_price) FROM pizza_sales),2)
AS PCT FROM pizza_sales
GROUP BY pizza_category;

SELECT pizza_size, round(SUM(total_price)) AS Total_Sales,round(SUM(total_price) *100/ (SELECT SUM(total_price) FROM pizza_sales WHERE dayofmonth(STR_TO_DATE(order_date, '%d-%m-%y')) = 1),2)
AS PCT FROM pizza_sales
WHERE dayofmonth(STR_TO_DATE(order_date, '%d-%m-%y')) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
Group BY pizza_category;

SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
WHERE dayofmonth(STR_TO_DATE(order_date, '%d-%m-%y')) = 1
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
WHERE dayofmonth(STR_TO_DATE(order_date, '%d-%m-%y')) = 1
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC
LIMIT 5;