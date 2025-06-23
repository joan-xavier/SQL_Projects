Certainly! Below is the cleaned and professional `README.md` file **without emojis** and with each SQL block enclosed in triple backticks and labeled as `sql`:

---

````markdown
# SQL Project 1: Retail Sales Analysis

## Database: `sql_project_retail_price`

This project demonstrates the use of SQL for data cleaning, exploration, and business analysis using a retail sales dataset. The database simulates retail transaction data to generate insights related to customer behavior, product categories, and time-based trends.

---

## Table Schema

### Table: `retail_sales`

| Column           | Data Type   | Description                        |
|------------------|-------------|------------------------------------|
| transactions_id  | INT (PK)    | Unique transaction ID              |
| sale_date        | DATE        | Date of sale                       |
| sale_time        | TIME        | Time of sale                       |
| customer_id      | INT         | ID of the customer                 |
| gender           | VARCHAR(10) | Gender of the customer             |
| age              | INT         | Age of the customer                |
| category         | VARCHAR(50) | Product category                   |
| quantity         | INT         | Quantity sold                      |
| price_per_unit   | FLOAT       | Unit price                         |
| cogs             | FLOAT       | Cost of goods sold                 |
| total_sale       | FLOAT       | Total sale amount                  |

---

## Data Cleaning

Check for nulls:
```sql
SELECT * FROM retail_sales
WHERE 
  transactions_id IS NULL OR
  sale_date IS NULL OR
  gender IS NULL OR
  category IS NULL OR
  quantity IS NULL OR
  cogs IS NULL OR
  total_sale IS NULL;
````

Delete rows with nulls:

```sql
DELETE FROM retail_sales
WHERE 
  transactions_id IS NULL OR
  sale_date IS NULL OR
  gender IS NULL OR
  category IS NULL OR
  quantity IS NULL OR
  cogs IS NULL OR
  total_sale IS NULL;
```

Check record count after deletion:

```sql
SELECT COUNT(*) FROM retail_sales;
```

---

## Data Exploration

Total number of records:

```sql
SELECT COUNT(*) FROM retail_sales;
```

Number of unique customers:

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

Number of unique product categories:

```sql
SELECT COUNT(DISTINCT category) FROM retail_sales;
```

---

## Business Questions and Analysis

### Q1. Retrieve all sales made on '2022-11-05':

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### Q2. Clothing category sales (quantity >= 4) in November 2022:

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' 
  AND quantity >= 4 
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

### Q3. Total sales per category:

```sql
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;
```

### Q4. Average age of customers who purchased from 'Beauty' category:

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### Q5. Transactions where total\_sale > 1000:

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### Q6. Number of transactions by gender for each category:

```sql
SELECT category, gender, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### Q7. Average monthly sale and best selling month of each year:

Monthly average sales:

```sql
SELECT 
  EXTRACT(YEAR FROM sale_date) AS year,
  EXTRACT(MONTH FROM sale_date) AS month,
  AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC;
```

Best selling month per year:

```sql
SELECT year, month, avg_sale
FROM (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rk
  FROM retail_sales
  GROUP BY 1, 2
) AS cte
WHERE rk = 1;
```

### Q8. Top 5 customers by total sales:

```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### Q9. Number of unique customers per category:

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### Q10. Orders by time of day (shift):

Simple CASE version:

```sql
SELECT 
  COUNT(transactions_id),
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift
FROM retail_sales
GROUP BY shift;
```

CTE version:

```sql
WITH cte1 AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT 
  shift,
  COUNT(*) AS total_orders
FROM cte1
GROUP BY shift
ORDER BY total_orders DESC;
```

---

## How to Use

1. Clone this repository.
2. Set up a PostgreSQL database and run the `CREATE TABLE` and `INSERT` scripts as needed.
3. Execute each SQL query in your SQL client or PostgreSQL terminal to explore the data.
4. Modify queries as needed for deeper insights.

---

