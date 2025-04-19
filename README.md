
# 🛍️ Retail Sales Analysis - PostgreSQL Project

Welcome to my very first SQL project using **PostgreSQL**!  
This project focuses on analyzing **retail sales data**, answering real business questions through SQL queries to extract valuable insights about sales trends, customer behavior, and product performance.

---

## 📊 Project Overview

This project uses PostgreSQL to manage and analyze retail sales data. It includes a set of **10 SQL queries** designed to explore different aspects of sales, such as customer activity, category performance, and time-based patterns.

---

## 🗃️ Database Structure

The core table used is `Retail_Price`, which contains the following key columns:

- `transaction_id`
- `sale_date`
- `sale_time`
- `customer_id`
- `gender`
- `age`
- `category`
- `quantity`
- `total_sale`

---

## 🧠 Queries & Insights

Here are the 10 SQL questions and their purposes:

### 1️⃣ Sales on a Specific Date
```sql
SELECT * FROM Retail_Price WHERE sale_date = '2022-11-05';
```
> Fetches all sales made on November 5, 2022.

---

### 2️⃣ Clothing Category - High Quantity
```sql
SELECT * FROM Retail_Price 
WHERE category = 'Clothing'
  AND quantity > 10
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```
> Retrieves all high-quantity clothing sales in November 2022.

---

### 3️⃣ Total Sales per Category
```sql
SELECT 
  category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM Retail_Price
GROUP BY category;
```
> Calculates total revenue and order count per category.

---

### 4️⃣ Average Age of Beauty Buyers
```sql
SELECT ROUND(AVG(age), 2) AS average 
FROM Retail_Price 
WHERE category = 'Beauty';
```
> Finds the average age of customers buying beauty products.

---

### 5️⃣ High-Value Transactions
```sql
SELECT * 
FROM Retail_Price 
WHERE total_sale > 1000;
```
> Lists all transactions with a sale amount greater than $1000.

---

### 6️⃣ Transactions by Gender and Category
```sql
SELECT gender, category, COUNT(*) AS total_transn 
FROM Retail_Price 
GROUP BY gender, category 
ORDER BY gender DESC;
```
> Shows number of transactions split by gender and product category.

---

### 7️⃣ Best-Selling Month by Year
```sql
SELECT year, month, average_sale
FROM (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         EXTRACT(MONTH FROM sale_date) AS month,
         ROUND(AVG(total_sale)::NUMERIC, 5) AS average_sale,
         RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) 
                      ORDER BY ROUND(AVG(total_sale)::NUMERIC, 5) DESC) AS rank
  FROM Retail_Price
  GROUP BY 1, 2
) AS t1
WHERE rank = 1;
```
> Identifies the month with the highest average sales in each year.

---

### 8️⃣ Top 5 Customers by Total Sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM Retail_Price
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```
> Ranks the top 5 customers based on total spending.

---

### 9️⃣ Unique Customers per Category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_id_no
FROM Retail_Price
GROUP BY category;
```
> Counts how many unique customers purchased from each category.

---

### 🔟 Order Shifts by Time of Day
```sql
WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM Retail_Price
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```
> Categorizes sales into Morning, Afternoon, and Evening shifts.

---

## 📌 Key Learnings

- Gained practical experience in writing advanced SQL queries
- Explored data aggregation, filtering, ranking, and grouping
- Applied PostgreSQL date/time functions for time-based analysis
- Discovered valuable insights into retail sales operations

---

## 🔧 Tools Used

- **PostgreSQL** – for database setup and querying
- **pgAdmin 4** – for GUI-based database interaction

---

## 🚀 Future Ideas

- Visualize insights using Power BI or Tableau
- Build stored procedures for reporting
- Automate ETL pipelines for dynamic retail data

---

## 📬 Contact

Feel free to connect or reach out if you're interested in discussing data, SQL, or collaborating on future projects!
