--SQL AMAZON SALES ANALYSIS PROJECT

-- AIM: Aim is to gain insight into the sales data of Amazon to understand the different 
		--factors that affect sales of the different branches.
		
*************************************************************************************************		

-- 01 Data Wrangling

-- Table creation
CREATE TABLE amazon (
    invoice_id VARCHAR(30),
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10, 2),
    quantity INT,
    vat DECIMAL(6, 4),
    total DECIMAL(10, 2),
    date DATE,
    time TIME,
    payment VARCHAR(50),
    cogs DECIMAL(10, 2),
    gross_margin_percentage DECIMAL(11, 9),
    gross_income DECIMAL(10, 2),
    rating DECIMAL(2, 1)
);

select * from amazon;

ALTER TABLE amazon ALTER COLUMN rating TYPE DECIMAL(3,1);

COPY amazon
FROM 'C://Program Files//PostgreSQL//17//Amazon.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM amazon;

***************************************************************************************************

-- 02 Feauture Engineering

-- Adding new columns like (timeofday, dayname, monthname)

-- 1 TimeofDay
ALTER TABLE amazon ADD COLUMN timeofday VARCHAR(50);

UPDATE amazon
SET timeofday = CASE
    WHEN EXTRACT(HOUR FROM time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
END;

-- 2 DayName
ALTER TABLE amazon ADD COLUMN dayname VARCHAR(20);

UPDATE amazon
SET dayname = TO_CHAR(date, 'Day');

-- 3 MonthName
ALTER TABLE amazon ADD COLUMN monthname VARCHAR(15);

UPDATE amazon
SET monthname = TO_CHAR(date, 'Month')

SELECT * FROM amazon;

*************************************************************************************************************

-- 03 Exploratory Data Analysis answering Business Questions:


-- Q1 What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT city) FROM amazon;

-- Q2 For each branch, what is the corresponding city?
SELECT branch, city from amazon;

-- Q3 What is the count of distinct product lines in the dataset?
SELECT COUNT(DISTINCT product_line) as distinct_pl 
FROM amazon;

-- Q4 Which payment method occurs most frequently?
SELECT payment, COUNT(*) AS frequency
FROM amazon
GROUP BY payment
ORDER BY frequency DESC
LIMIT 1;

-- Q5 Which product line has the highest sales?
SELECT product_line, SUM(total) as Highest_sales
FROM amazon
GROUP BY product_line
ORDER BY Highest_sales DESC
LIMIT 1;

-- Q6 How much revenue is generated each month?
SELECT monthname,SUM(total) as Revenue
FROM amazon
GROUP BY monthname;

-- Q7 In which month did the cost of goods sold reach its peak?
SELECT monthname, MAX(cogs) as Peak_cogs
FROM amazon
GROUP BY monthname;

-- Q8 Which product line generated the highest revenue?
SELECT product_line, SUM(total) as Highest_Revenue
FROM amazon
GROUP BY product_line
ORDER BY Highest_Revenue DESC
LIMIT 1;

-- Q9 In which city was the highest revenue recorded?
SELECT city, SUM(total) as Highest_Revenue
FROM amazon
GROUP BY city
ORDER BY Highest_Revenue DESC
LIMIT 1;

-- Q10 Which product line incurred the highest Value Added Tax?
SELECT product_line, SUM(vat) as Highest_vat
FROM amazon
GROUP BY product_line
ORDER BY Highest_vat DESC
LIMIT 1;

-- Q11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
WITH avg_sales AS(
	SELECT AVG(total) as avg_revenue
	FROM amazon
)
SELECT product_line, total,
	CASE
		WHEN total > (SELECT avg_revenue FROM avg_sales) THEN 'Good'
		ELSE 'Bad'
	END AS Performance
FROM amazon;

-- Q12 Identify the branch that exceeded the average number of products sold.
WITH CTE AS(
SELECT AVG(quantity) AS avg_psold
FROM amazon
)
SELECT branch FROM amazon
WHERE quantity > (SELECT avg_psold FROM CTE);

--Q13 Which product line is most frequently associated with each gender?
SELECT gender, product_line, COUNT(*) AS frequency
FROM amazon
GROUP BY gender, product_line
ORDER BY frequency DESC;

--Q14 Calculate the average rating for each product line.
SELECT product_line, AVG(rating) AS avg_rating
FROM amazon
GROUP BY product_line
ORDER BY avg_rating;

--Q15 Count the sales occurrences for each time of day on every weekday.
SELECT dayname, timeofday, COUNT(*) AS sales_count
FROM amazon
GROUP BY dayname, timeofday
ORDER BY dayname, timeofday;

--Q16 Identify the customer type contributing the highest revenue.
SELECT customer_type, SUM(total) as Highest_revenue
FROM amazon
GROUP BY customer_type
ORDER BY Highest_revenue DESC
LIMIT 1;

--Q17 Determine the city with the highest VAT percentage.
SELECT city, MAX(vat) as High_vat
FROM amazon
GROUP BY city;

--Q18 Identify the customer type with the highest VAT payments.
SELECT customer_type, MAX(vat) AS Highest_vat_pay
FROM amazon
GROUP BY customer_type
ORDER BY Highest_vat_pay DESC
LIMIT 1;

--Q19 What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT customer_type) AS distinct_count
FROM amazon;

--Q20 What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT payment) AS distinct_pay_count
FROM amazon;

--Q21 Which customer type occurs most frequently?
SELECT customer_type, COUNT(*) AS frequency
FROM amazon
GROUP BY customer_type
ORDER BY frequency DESC;

--Q22 Identify the customer type with the highest purchase frequency.
SELECT customer_type, COUNT(*) AS high_purchase
FROM amazon
GROUP BY customer_type
ORDER BY high_purchase DESC
LIMIT 1;

--Q23 Determine the predominant gender among customers.
SELECT gender, COUNT(*) AS gender_cnt
FROM amazon
GROUP BY gender
ORDER BY gender_cnt DESC;

--Q24 Examine the distribution of genders within each branch.
SELECT branch, gender, COUNT(*) AS gender_cnt
FROM amazon
GROUP BY branch, gender;

--Q25 Identify the time of day when customers provide the most ratings.
SELECT timeofday, COUNT(rating) AS ratings_count
FROM amazon
WHERE rating IS NOT NULL
GROUP BY timeofday
ORDER BY ratings_count DESC;

--Q26 Determine the time of day with the highest customer ratings for each branch.
SELECT timeofday,branch, COUNT(rating) AS ratings_count
FROM amazon
WHERE rating IS NOT NULL
GROUP BY timeofday, branch
ORDER BY ratings_count DESC;

--Q27 Identify the day of the week with the highest average ratings.
SELECT dayname, AVG(rating) AS Highest_avg_rating
FROM amazon
GROUP BY dayname
ORDER BY Highest_avg_rating DESC
LIMIT 1;

--Q28 Determine the day of the week with the highest average ratings for each branch.
SELECT dayname, branch, AVG(rating) AS Highest_avg_rating
FROM amazon
GROUP BY dayname, branch
ORDER BY Highest_avg_rating DESC
LIMIT 1;
*******************************************************************************************************

--THANKYOU!
