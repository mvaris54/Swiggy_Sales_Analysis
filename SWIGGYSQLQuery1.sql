/* RAW DATA */
SELECT * FROM swiggy_data;



/* DATA VALIDATION & CLEANING */

-- Null check
SELECT
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END) AS null_restaurant,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END) AS null_dish,
    SUM(CASE WHEN Price_INR IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END) AS null_rating_count
FROM swiggy_data;

-- Blank value check
SELECT *
FROM swiggy_data
WHERE
    State = '' OR City = '' OR Restaurant_Name = '' OR Location = '' 
    OR Category = '' OR Dish_Name = ''
    OR Price_INR = '' OR Rating = '' OR Rating_Count = '';

-- Duplicate rows check
SELECT
    State, City, order_date, restaurant_name, location, category,
    dish_name, price_INR, rating, rating_count,
    COUNT(*) AS CNT
FROM swiggy_data
GROUP BY
    State, City, order_date, restaurant_name, location, category,
    dish_name, price_INR, rating, rating_count
HAVING COUNT(*) > 1;

-- Remove duplicates
WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY State, City, order_date, restaurant_name, location, category,
                         dish_name, price_INR, rating, rating_count
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM swiggy_data
)
DELETE FROM CTE WHERE rn > 1;



/* STAR SCHEMA SETUP */

-- Dimension tables
CREATE TABLE dim_date (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    Full_Date DATE,
    Year INT,
    Month INT,
    Month_Name VARCHAR(20),
    Quarter INT,
    Day INT,
    Week INT
);

CREATE TABLE dim_location (
    location_id INT IDENTITY(1,1) PRIMARY KEY,
    State VARCHAR(100),
    City VARCHAR(100),
    Location VARCHAR(200)
);

CREATE TABLE dim_restaurant (
    restaurant_id INT IDENTITY(1,1) PRIMARY KEY,
    Restaurant_Name VARCHAR(200)
);

CREATE TABLE dim_category (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    Category VARCHAR(200)
);

CREATE TABLE dim_dish (
    dish_id INT IDENTITY(1,1) PRIMARY KEY,
    Dish_Name VARCHAR(200)
);

-- Fact table
CREATE TABLE fact_swiggy_orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    Price_INR DECIMAL(10,2),
    Rating DECIMAL(4,2),
    Rating_Count INT,
    location_id INT,
    restaurant_id INT,
    category_id INT,
    dish_id INT,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    FOREIGN KEY (restaurant_id) REFERENCES dim_restaurant(restaurant_id),
    FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
    FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id)
);



/* INSERT DATA INTO DIMENSIONS */

INSERT INTO dim_date (Full_Date, Year, Month, Month_Name, Quarter, Day, Week)
SELECT DISTINCT
    Order_Date,
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date),
    DATEPART(QUARTER, Order_Date),
    DAY(Order_Date),
    DATEPART(WEEK, Order_Date)
FROM swiggy_data
WHERE Order_Date IS NOT NULL;

INSERT INTO dim_location (State, City, Location)
SELECT DISTINCT State, City, Location
FROM swiggy_data;

INSERT INTO dim_restaurant (Restaurant_Name)
SELECT DISTINCT Restaurant_Name
FROM swiggy_data;

INSERT INTO dim_category (Category)
SELECT DISTINCT Category
FROM swiggy_data;

INSERT INTO dim_dish (Dish_Name)
SELECT DISTINCT Dish_Name
FROM swiggy_data;



/* LOAD FACT TABLE */

INSERT INTO fact_swiggy_orders (
    date_id, Price_INR, Rating, Rating_Count,
    location_id, restaurant_id, category_id, dish_id
)
SELECT
    dd.date_id,
    s.Price_INR,
    s.Rating,
    s.Rating_Count,
    dl.location_id,
    dr.restaurant_id,
    dc.category_id,
    dsh.dish_id
FROM swiggy_data s
JOIN dim_date dd ON dd.Full_Date = s.Order_Date
JOIN dim_location dl ON dl.State = s.State AND dl.City = s.City AND dl.Location = s.Location
JOIN dim_restaurant dr ON dr.Restaurant_Name = s.Restaurant_Name
JOIN dim_category dc ON dc.Category = s.Category
JOIN dim_dish dsh ON dsh.Dish_Name = s.Dish_Name;



/* KPI ANALYSIS */

-- Total orders
SELECT COUNT(*) AS Total_Orders FROM fact_swiggy_orders;

-- Total revenue
SELECT FORMAT(SUM(CONVERT(FLOAT,price_INR))/1000000, 'N2') + ' INR Million' AS Total_Revenue
FROM fact_swiggy_orders;

-- Avg price
SELECT FORMAT(AVG(CONVERT(FLOAT,price_INR)), 'N2') + ' INR' AS Average_Dish_Price
FROM fact_swiggy_orders;

-- Avg rating
SELECT AVG(Rating) AS Avg_Rating
FROM fact_swiggy_orders;



/* TREND ANALYSIS */

-- Monthly orders
SELECT d.year, d.month, d.month_name, COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- Quarterly trend
SELECT d.year, d.quarter, COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.quarter
ORDER BY Total_Orders DESC;

-- Weekday orders
SELECT DATENAME(WEEKDAY, d.full_date) AS day_name, COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY DATENAME(WEEKDAY, d.full_date), DATEPART(WEEKDAY, d.full_date)
ORDER BY DATEPART(WEEKDAY, d.full_date);



/* LOCATION ANALYSIS */

-- Top cities
SELECT TOP 10 l.city, COUNT(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN dim_location l ON l.location_id = f.location_id
GROUP BY l.city
ORDER BY Total_Orders DESC;

-- State revenue
SELECT l.state, SUM(f.price_INR) AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_location l ON l.location_id = f.location_id
GROUP BY l.state
ORDER BY Total_Revenue DESC;



/* RESTAURANT ANALYSIS */

-- Top restaurants
SELECT TOP 10 r.restaurant_name, SUM(f.price_INR) AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_restaurant r ON f.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Total_Revenue DESC;

-- Restaurant performance
SELECT 
    r.Restaurant_Name,
    SUM(f.Price_INR) AS Total_Revenue,
    AVG(f.Rating) AS Avg_Rating,
    CASE 
        WHEN AVG(f.Rating) >= 4 AND SUM(f.Price_INR) > (SELECT AVG(Price_INR) FROM fact_swiggy_orders)
            THEN 'Top Performer'
        WHEN AVG(f.Rating) >= 4 THEN 'High Rated'
        WHEN SUM(f.Price_INR) > (SELECT AVG(Price_INR) FROM fact_swiggy_orders)
            THEN 'High Revenue'
        ELSE 'Low Performer'
    END AS Performance_Category
FROM fact_swiggy_orders f
JOIN dim_restaurant r ON f.restaurant_id = r.restaurant_id
GROUP BY r.Restaurant_Name
ORDER BY Total_Revenue DESC;



/* CATEGORY & DISH ANALYSIS */

-- Top categories
SELECT c.category, COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_category c ON f.category_id = c.category_id
GROUP BY c.category
ORDER BY total_orders DESC;

-- Most ordered dishes
SELECT d.dish_name, COUNT(*) AS order_count
FROM fact_swiggy_orders f
JOIN dim_dish d ON f.dish_id = d.dish_id
GROUP BY d.dish_name
ORDER BY order_count DESC;





-- Price range
SELECT
    CASE
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100 - 199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200 - 299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300 - 499'
        ELSE '500+'
    END AS price_range,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders
GROUP BY
    CASE
        WHEN price_inr < 100 THEN 'Under 100'
        WHEN price_inr BETWEEN 100 AND 199 THEN '100 - 199'
        WHEN price_inr BETWEEN 200 AND 299 THEN '200 - 299'
        WHEN price_inr BETWEEN 300 AND 499 THEN '300 - 499'
        ELSE '500+'
    END
ORDER BY total_orders DESC;

-- Price elasticity
SELECT TOP 10
    d.dish_name,
    AVG(f.price_inr) AS avg_price,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) / AVG(f.price_inr), 2) AS price_elasticity_score
FROM fact_swiggy_orders f
JOIN dim_dish d ON f.dish_id = d.dish_id
GROUP BY d.dish_name
ORDER BY price_elasticity_score DESC;
