# 🍽️ Swiggy Sales Analysis – End-to-End SQL Project

This project presents a complete **SQL-based data analysis** of Swiggy food delivery data, including **data cleaning**, **data validation**, **dimensional modelling (Star Schema)**, **fact table creation**, and **advanced business analytics** such as price elasticity, restaurant performance scoring, category profitability, and more.

This is a **real-world style analytics project** similar to what data teams use in companies like **Swiggy, Zomato, Uber Eats, Amazon Food**.

---

## 📌 Project Highlights

### ✔ Complete Data Cleaning  
- Handled **NULL values**, **blank strings**, and **duplicate records**  
- Performed **data validation** before modelling  

### ✔ Dimensional Modelling (Star Schema)  
Created clean dimension tables:  
- `dim_date`  
- `dim_location`  
- `dim_restaurant`  
- `dim_category`  
- `dim_dish`  

And a central **fact table**:  
- `fact_swiggy_orders` containing measures like *Price, Rating, Rating Count*  

### ✔ Data Transformation  
All dimension keys mapped to the fact table ensuring referential integrity.

### ✔ KPI Development  
- Total Orders  
- Total Revenue  
- Average Rating  
- Average Dish Price  

### ✔ Business Insights  
Includes analysis of:  
- Monthly, Quarterly, and Day-of-Week trends  
- Top-performing cities, states, restaurants  
- Category & cuisine insights  
- Dish-level performance  

### ✔ Advanced Analytics (Industry Level)
- Price Elasticity (Demand Sensitivity)  
- Restaurant Performance Segmentation  
- Price Bucket Analysis  
- Weighted Rating (IMDb rating formula logic)  
- Z-score based Outlier Detection  
- City-wise Top Restaurant using Window Functions  

These advanced queries showcase strong analytical thinking for real business use-cases.

---

## 📂 Project Structure
📁 Swiggy-SQL-Analysis
│── 📄 README.md
│── 📄 swiggy_data.csv
│── 📁 SQL Scripts
│ ├── 01_data_cleaning.sql
│ ├── 02_star_schema.sql
│ ├── 03_fact_dimension_load.sql
│ ├── 04_business_kpis.sql
│ ├── 05_advanced_analytics.sql

You can optionally split queries like above or keep everything in one master file.

---

## 🧹 Data Cleaning Steps

- Checked and handled missing values  
- Identified blank text fields  
- Found and removed exact duplicates using `ROW_NUMBER()`  
- Standardized data formats  

These steps ensure data quality before modelling and analysis.

---

## ⭐ Star Schema Overview

**Fact Table:**  
`fact_swiggy_orders`  
- Measures → Price, Rating, Rating Count  
- Foreign Keys → date_id, location_id, restaurant_id, category_id, dish_id  

**Dimension Tables:**  
- `dim_date`  
- `dim_location`  
- `dim_restaurant`  
- `dim_category`  
- `dim_dish`  

This structure improves query performance and makes analytics smooth.

---

## 📊 Key Business Questions Answered

### 🔶 Sales & Revenue  
- Total revenue generated  
- Higher-earning periods  
- Monthly & quarterly growth  

### 🔶 Customer Behavior  
- Pricing sensitivity  
- Spending distribution  
- Rating patterns  

### 🔶 Restaurant Insights  
- Top revenue generators  
- High-rated restaurants  
- Performance segmentation  

### 🔶 Product (Dish) Insights  
- Most popular dishes  
- Category-wise demand  
- Best performing cuisines  

---

## 🚀 Advanced Features (to impress recruiters)

### ✔ Price Elasticity  
Understand which dishes have demand sensitive to price.

### ✔ Weighted Ratings  
Avoid misleading high ratings with fewer votes.

### ✔ Outlier Detection  
Detect unusually high/low priced menu items (Z-score method).

### ✔ City-wise Top Restaurant  
Using `RANK()` window function.

### ✔ Category Profitability Matrix  
Combines price × demand to evaluate performance.

These analytics are exactly what real food delivery companies use.

---

## 📑 Full SQL Script  
The complete combined SQL script is included in:  
`swiggy_full_project.sql`

It contains everything in one place from raw data cleaning → star schema → KPIs → advanced analytics.

---

## 📝 Conclusion

This SQL project demonstrates:  
- Strong SQL foundations  
- Data cleaning & modelling skills  
- Business thinking  
- Real-world analytical problem solving  
- Ability to work with large transactional datasets  

Perfect for resumes, GitHub portfolios, and analytics interviews.

---

## 👨‍💻 Developer  
**Varis**  

---

If you like this project, ⭐ star the repo on GitHub!



