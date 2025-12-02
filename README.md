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

