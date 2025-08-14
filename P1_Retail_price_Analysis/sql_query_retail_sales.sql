-- Database: sql_project_retail_price (Project 1)

 DROP DATABASE IF EXISTS sql_project_retail_price;
	DROP TABLE IF EXISTS retail_sales
-- create table
CREATE TABLE retail_sales
	(
		transactions_id	INT PRIMARY KEY,
		sale_date	DATE,	
		sale_time TIME,
		customer_id	INT,
		gender	VARCHAR(10),
		age INT,
		category VARCHAR(50),	
		quantity	INT,
		price_per_unit	FLOAT,
		cogs FLOAT,
		total_sale FLOAT
		);

SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM retail_sales

-- DAta cleaning check null values
SELECT * FROM retail_sales
WHERE 
transactions_id IS NULL
OR sale_date IS NULL
OR gender IS NULL
OR category IS NULL
OR quantity IS NULL
OR cogs IS NULL
OR total_sale IS NULL
-- deleting rows with null values
DELETE FROM retail_sales
WHERE 
transactions_id IS NULL
OR sale_date IS NULL
OR gender IS NULL
OR category IS NULL
OR quantity IS NULL
OR cogs IS NULL
OR total_sale IS NULL

-- count the remaining data records(3 data deleted from 2000)
SELECT COUNT(*) FROM retail_sales

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many unique customers we have 
SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales

-- How many categories in table Ans is 3
SELECT COUNT(DISTINCT(category)) FROM retail_sales

-- DAta Analysis & Business Key Problems & Answers
-- The following SQL queries were developed to answer specific business questions
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
--  the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND quantity >= 4 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category
SELECT SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >1000

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
EXTRACT (YEAR FROM sale_date) As year,
EXTRACT (MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC
-- ------------------- answer using rnk function as follows

SELECT year, month, avg_sale
FROM 
(
SELECT 
EXTRACT (YEAR FROM sale_date) As year,
EXTRACT (MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rk
FROM retail_sales
GROUP BY 1,2
) AS cte1
WHERE rk = 1

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT DISTINCT(customer_id), SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category
SELECT COUNT(DISTINCT(customer_id)) AS uniques_customers,category
FROM retail_sales
GROUP BY 2

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT COUNT(transactions_id),
CASE
	WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning' 
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening'
END AS shift
FROM retail_sales
GROUP BY shift



--- Aliter for Q10
WITH cte1 AS(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning' 
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM cte1
GROUP BY shift
ORDER BY total_orders DESC
-- End of Project