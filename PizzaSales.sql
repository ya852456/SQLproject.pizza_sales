#Project Name: Pizza Sales Data Exploration 
#Data Source: Kaggle
#Purpose: Organize and analyze data sets for visualization on Tableau


#Top 10 pizzas sold over the year

SELECT Name, COUNT(*) AS NumberSold FROM project.pizzas p JOIN project.pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id JOIN project.order_details od
ON p.pizza_id = od.pizza_id
GROUP BY Name
ORDER BY NumberSold DESC
LIMIT 10

#The total sales for each months

SELECT MONTH(date) AS Month,category, ROUND(SUM(price),2) AS Total_Sales FROM project.orders o JOIN project.order_details od JOIN project.pizzas p JOIN project.pizza_types pt
ON o.order_id = od.order_id AND od.pizza_id = p.pizza_id AND p.pizza_type_id = pt.pizza_type_id
GROUP BY Month, category


#Which time period in a day has the most orders over the year

SELECT CASE WHEN LEFT(time,2)<12 THEN 'Morning' WHEN LEFT(time,2)<18 THEN 'Afternoon' ELSE 'Night' END AS time_period
,COUNT(*) count from project.orders 
GROUP BY time_period

#How many types of pizzas are there in each category

SELECT category, name, COUNT(*) OVER(partition by category) AS category_num FROM project.pizza_types

#Number of sold for different sizes

SELECT UPPER(RIGHT(pizza_id,1)) PizzaSize, COUNT(*) NumberSold FROM project.order_details
GROUP BY PizzaSize