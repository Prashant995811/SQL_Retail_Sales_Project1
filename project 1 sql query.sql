create table Retail_Price(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(20),
	quantiy	INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

SELECT * FROM Retail_Price

select * from Retail_Price 
where "transactions_id" is null
or "sale_date" is null
or "sale_time" is null
or "customer_id" is null
or "gender" is null
or "age" is null
or "category" is null
or "quantity" is null
or "price_per_unit" is null
or "cogs" is null
or "total_sale" is null

ALTER TABLE Retail_Price RENAME COLUMN "quantiy" TO "quantity";

delete from Retail_Price
where "transactions_id" is null
or "sale_date" is null
or "sale_time" is null
or "customer_id" is null
or "gender" is null
or "age" is null
or "category" is null
or "quantity" is null
or "price_per_unit" is null
or "cogs" is null
or "total_sale" is null

-- Data Analysis
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM Retail_Price
where "sale_date" = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * FROM Retail_Price 
where "category" = 'Clothing'
and "quantity" > 2
and to_char("sale_date",'YYYY-MM') = '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM Retail_Price
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(avg("age"),2) as "average" 
from Retail_Price where "category" = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Retail_Price where "total_sale" > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select "gender", "category", count(*) as total_transn from Retail_Price group by 1,2 order by 1 desc

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select distinct extract(Year from "sale_date") as "year", extract(month from "sale_date") as "Month" from Retail_Price
select * from Retail_Price

SELECT "year", "month", "average_sale"
from(
SELECT EXTRACT(YEAR FROM "sale_date") AS "year",
	EXTRACT(MONTH FROM "sale_date") AS "month",
	round(avg(total_sale)::numeric,5) as "average_sale",
	rank() over(PARTITION BY EXTRACT(YEAR FROM "sale_date") ORDER BY round(avg(total_sale)::numeric,5) DESC) AS "rank"
FROM Retail_Price
group by 1,2
order by 1 , 3 desc
) as "t1"
where "rank" = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select "customer_id",
	SUM("total_sale") as "total_sales"
from Retail_Price
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select "category", COUNT(distinct "customer_id") as "unique_id_no"
FROM Retail_Price
group by "category"

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
Select * from Retail_Price
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM Retail_Price
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift








