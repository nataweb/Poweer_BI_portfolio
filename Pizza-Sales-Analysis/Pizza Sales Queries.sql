---------- KPI's -------------
SELECT SUM(total_price) AS Total_Revenue,
SUM(total_price)/Count(Distinct order_id) AS Avg_Order_Value,
SUM(quantity) AS Total_Pizzas_Sold,
COUNT(DISTINCT order_id) AS Total_Orders,
CAST(CAST(SUM(quantity) AS decimal (10,2))/
CAST(COUNT(DISTINCT order_id)  as decimal(10,2))as decimal(10,2)) AS Avg_Pizzas_per_Order 
FROM pizza_sales;

-----------------------------------------------
------------------ Charts ---------------------
-----------------------------------------------

----------  Total Orders by days --------------
SELECT DATENAME(DW,order_date) as order_day,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

------------- MONTHLY TREND ---------------------
SELECT DATENAME(MONTH,order_date) as Month_Name,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Orders DESC ;

SELECT pizza_category,ROUND(SUM(total_price),2) as Total_Sales,
ROUND(SUM(total_price) * 100/(SELECT SUM(total_price) from pizza_sales),2) as Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category;


SELECT pizza_size,ROUND(SUM(total_price),2) as Total_Sales,
ROUND(SUM(total_price) * 100/(SELECT SUM(total_price) from pizza_sales),2) as Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_sales DESC;












-------------------------------------------------
------------- MOST Sold 5 pizzas  ---------------
-------------------------------------------------
SELECT TOP 5 pizza_name,ROUND(SUM(total_price),2) as Total_Sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC;

------------- WORST Sold 5 pizzas  ---------------
SELECT TOP 5 pizza_name,ROUND(SUM(total_price),2) as Total_Sales
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC;


---------------------------------------------------------
------------- MOST 5 pizzas by quantity   ---------------
---------------------------------------------------------
SELECT TOP 5 pizza_name,SUM(quantity) as Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC;

------------- LESS 5 pizzas by quantity   ---------------
SELECT TOP 5 pizza_name,SUM(quantity) as Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC;

-------------------------------------------------
------------ Total ORDERS -----------------------
-------------------------------------------------
--------  MOST popular pizzas  -----------

SELECT TOP 5 pizza_name,
COUNT(order_id) as total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;

--------  LESS popular pizzas  -----------
SELECT TOP 5 pizza_name,
COUNT(order_id) as total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC;


----------------  MY queries  --------------------
SELECT 
COUNT(DISTINCT pizza_category) AS pizza_category_number
FROM pizza_sales;

SELECT 
COUNT(DISTINCT pizza_name) AS pizza_number
FROM pizza_sales;

SELECT 
MAX(pizza_name) as most_popular, 
MIN(pizza_name) as less_popular
FROM pizza_sales

-------------------------------------------------
------------- Top 5 pizzas by revenue -----------
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Quantity,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

----------- Bottom 5 pizzas by revenue -----------
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Quantity,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;