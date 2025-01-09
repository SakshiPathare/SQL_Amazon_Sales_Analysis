# SQL Amazon Sales Analysis Project

## Aim: 
- Aim of this project is to gain insight into the sales data of Amazon to understand the different factors that affect sales of the different branches.

## About the Data: 
- This dataset contains sales transactions from three different branches of Amazon, respectively located in Mandalay, Yangon and Naypyitaw.

## Dataset
- Records: 1000 rows
- Attributes: 17 attributes like, invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time, payment, cogs, gross_margin_percentage,       gross_income, rating

## Tools and Technologies
- Language: SQL
- Database: PostgreSQL

## Analysis Performed
- Product Analysis
    - Analyze different product lines to identify:
        - Best-performing product lines.
        - Underperforming product lines that require improvement.

- Sales Analysis
    - Examine sales trends to:
        - Measure the effectiveness of sales strategies.
        - Identify areas of improvement to increase sales.

- Customer Analysis
    - Segment customers to understand:
        - Purchase behaviors.
        - Profitability of each customer segment.

## Approach Used
- Data Wrangling
    - Inspected the dataset for missing or NULL values.
- Steps:
    - Built a database and inserted the dataset into a table.
    - Filtered and validated the data.
- Feature Engineering
    - Generated new columns to gain additional insights:
        - timeofday: Categorized sales as Morning, Afternoon, or Evening.
        - dayname: Extracted the day of the week (Mon, Tue, Wed, etc.).
        - monthname: Extracted the month of the year (Jan, Feb, Mar, etc.).
- Exploratory Data Analysis (EDA)
    - Conducted EDA to answer key questions and meet the project objectives.
