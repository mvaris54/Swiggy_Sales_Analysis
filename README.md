# Swiggy Sales Analysis – SQL Project

This project is an end-to-end SQL analysis of Swiggy food delivery data.  
I worked on cleaning the raw dataset, building a proper star schema, loading fact and dimension tables, and then performing different business analyses to understand ordering patterns, restaurant performance, pricing behavior, and category trends.

The goal of this project was to practice real-world SQL skills and analyze how food delivery platforms use data to make decisions.

---

## What I Did in This Project

### ✔ Data Cleaning
The raw data had some issues, so I started by:
- Checking for NULL values  
- Finding blank or missing fields  
- Detecting and removing duplicate rows using `ROW_NUMBER()`  

This step ensured the dataset was clean before building the model.

---

### ✔ Star Schema Modeling
To make the analysis structured and easy to query, I created a star schema with the following dimension tables:

- `dim_date`  
- `dim_location`  
- `dim_restaurant`  
- `dim_category`  
- `dim_dish`  

And one fact table:
- `fact_swiggy_orders`

The fact table stores the main metrics like **price, rating, rating count**, and links to all dimensions.

---

### ✔ Loading the Data
I inserted all unique values into the dimension tables and then populated the fact table by joining the source data with each dimension.  
This allowed me to build a clean analytics-ready model.

---

## Key KPIs and Insights

I used SQL to calculate important business metrics such as:

- **Total Orders**  
- **Total Revenue**  
- **Average Dish Price**  
- **Average Rating**

I also analyzed:

- Monthly and quarterly order trends  
- Day-of-week patterns  
- Top cities and states  
- Best performing restaurants  
- Most ordered dishes  
- Category-wise orders  

---

## Advanced Analysis

To make the project closer to real industry work, I also added some advanced SQL analysis:

- **Price elasticity (demand sensitivity based on price)**  
- **Restaurant performance segmentation**  
- **Price bucket analysis**  
- **Weighted ratings (better than simple averages)**  
- **City-wise top restaurant using window functions**  
- **Outlier detection using Z-score**  
- **Category profitability (price × demand)**  

These types of queries are commonly used in real analytics teams to support business decisions.

---

## What I Learned

This project helped me strengthen:

- Data cleaning skills  
- Dimensional modelling  
- Writing optimized SQL queries  
- Understanding business KPIs  
- Working with real-world style datasets  
- Analytical thinking  

Overall, this project improved both my SQL and my data analysis approach.

---

## Files Included

- Full SQL script containing cleaning, modelling, loading, KPIs, and advanced analytics  
- Dataset (Swiggy data)  
- ERD/Star Schema (optional if added)

---

## About Me

I am continuously improving my SQL and data analysis skills, and this project is part of my learning journey toward data analytics and business intelligence.

If you liked this project, feel free to ⭐ the repository!

