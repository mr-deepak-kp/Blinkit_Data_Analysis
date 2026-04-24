# 🛒 Blinkit Grocery Sales & Performance Analysis


![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Python](https://img.shields.io/badge/Python-Analysis-yellow)
![PowerBI](https://img.shields.io/badge/Dashboard-PowerBI-orange)
![Excel](https://img.shields.io/badge/Dashboard-Excel-brightgreen)
![Level](https://img.shields.io/badge/Level-Intermediate--Advanced-green)
![Queries](https://img.shields.io/badge/Queries-15-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![GitHub last commit](https://img.shields.io/github/last-commit/mr-deepak-kp/blinkit_analysis)
![GitHub repo size](https://img.shields.io/github/repo-size/mr-deepak-kp/blinkit_analysis)
![GitHub stars](https://img.shields.io/github/stars/mr-deepak-kp/blinkit_analysis?style=social)
![GitHub forks](https://img.shields.io/github/forks/mr-deepak-kp/blinkit_analysis?style=social)

--- 

## 📌 Project Overview    
This project performs a comprehensive analysis of Blinkit's Grocery Sales dataset to extract meaningful business insights and answer real-world KPI-driven questions.

The analysis covers total sales, average sales, number of items, and customer ratings — segmented by fat content, item type, outlet size, outlet location, and outlet type — helping understand Blinkit's sales performance, customer satisfaction, and inventory distribution.

The insights are visualized through an interactive Power BI Dashboard and an Excel Dashboard, both featuring filter panels, KPI cards, donut charts, bar charts, and a comprehensive outlet-type breakdown table.


---

## 🔗 Links

| Resource | Link |
|----------|------|
| 📊 Live Dashboard | [View](https://1drv.ms/x/c/85a2d415c17d6802/IQD_Pl6jcF0BR6OoJ4TwVB1KAXmXjau2b8KfTVJhB-wBGt8?e=OB8sTS) |
| 🌐 Live Demo | [View](https://blinkit-data-analysis-omega.vercel.app/) |

---


🎯 Objectives   
- 💰 Calculate total sales, average sales, number of items, and average rating KPIs  
- 🥗 Analyze the impact of fat content on total sales and other metrics  
- 🏪 Compare sales performance across outlet types, sizes, and locations   
- 📅 Evaluate how outlet establishment year influences total sales   
- 📊 Measure percentage contribution of each outlet size to total sales   
- 🔍 Identify top-performing item types by revenue and quantity   

---


📁 Project Structure
```    
Blinkit-Analysis/
│
├── 📄 BlinkIT_Grocery_Data.csv          # Raw dataset
├── 📄 BlinkIT_Grocery_Data.xlsx         # Excel version of raw data
│
├── 🗄️ Blinkit_schema.sql               # Database schema & data cleaning scripts
├── 🗄️ Blinkit_query__solutions.sql     # KPI queries & business requirement solutions
│
├── 🐍 Blinkit_Analysis_in_python.ipynb  # Python EDA notebook (Jupyter)
│
├── 📊 BlinkIT_DashBoard_in_Excel.xlsx   # Excel Dashboard
├── 📊 Blinkit_dashboard.pbix            # Power BI Dashboard
│
├── 🖼️ DashBoard_image1.png             # Power BI dashboard screenshot 1
├── 🖼️ DashBoard_image2.png             # Excel dashboard screenshot 2
│
├── 📑 Blinkit_KPIs_Requirement.pdf      # Business requirements document
├── 📑 Blinkit_KPIs_Requirements.pptx   # KPI requirements presentation
└── 📝 Query_Doc.docx                    # Query documentation
```


# 🧠 Skills Demonstrated 
Skill	Description   
- SQL (Intermediate Level)	Aggregations, filtering, grouping   
- KPI Calculations	Total Sales, Average Sales, Item Count, Average Rating   
- Window Functions	Sales percentage using SUM() OVER()   
- CASE Statements	Pivot-style fat content breakdown by outlet   
- COALESCE	Handling null values in conditional aggregations   
- Data Cleaning	Standardizing fat content labels with UPDATE + CASE   
- CAST & DECIMAL	Precise numeric formatting    
- Python (Pandas)	Data loading, cleaning, and exploratory analysis   
- Power BI	Interactive dashboard with slicers and KPI cards   
- Excel	Dashboard with charts, filters, and KPI summary   
- Business Problem Solving	Translating business questions into SQL and visuals   

---
🏗️ Database Schema
```sql
CREATE DATABASE blinkit_DB;
USE blinkit_DB;

CREATE TABLE blinkit_data (
    item_fat_content          VARCHAR(40),
    item_identifier           VARCHAR(40),
    item_type                 VARCHAR(60),
    outlet_establishment_year INT,
    outlet_identifier         VARCHAR(30),
    outlet_location_type      VARCHAR(50),
    outlet_size               VARCHAR(20),
    outlet_type               VARCHAR(30),
    item_visibility           DOUBLE(10,2),
    item_weight               DOUBLE(10,2),
    total_sales               DOUBLE(10,2),
    rating                    DOUBLE(10,2)
);
```
🧹 Data Cleaning Steps
```sql
-- Disable safe mode temporarily
SET SQL_SAFE_UPDATES = 0;

-- Standardize all fat content label variations
UPDATE blinkit_data
SET item_fat_content = CASE
    WHEN item_fat_content IN ('LF', 'Lf', 'low fat', 'Low Fat') THEN 'Low Fat'
    WHEN item_fat_content IN ('reg', 'REG', 'regular')           THEN 'Regular'
    ELSE item_fat_content
END;

-- Re-enable safe mode
SET SQL_SAFE_UPDATES = 1;
```

---


📋 Business Problems & Solutions — 15 SQL Queries
---

🔢 A. KPI Queries
---
Q1. Total Sales (All Items)
```sql
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data;
```

Objective: Calculate the overall revenue generated from all sold items.
--- 
Q2. Total Sales — Regular Fat Content Only
```sql
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data
WHERE item_fat_content = 'Regular';
```

Objective: Find total revenue contributed specifically by Regular fat content items.
---
Q3. Total Sales — Outlets Established in 2022
```sql
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data
WHERE outlet_establishment_year = 2022;
```

Objective: Measure total sales for outlets that were established in the year 2022.
---
Q4. Average Sales per Item
```sql
SELECT CAST(AVG(total_sales) AS DECIMAL(10,2)) AS Avg_sales
FROM blinkit_data;
```

Objective: Calculate the average revenue generated per individual sale.
---
Q5. Total Number of Items Sold
```sql
SELECT COUNT(*) AS Num_Of_Items
FROM blinkit_data;
```

Objective: Find the total count of all items sold across all outlets.
---
Q6. Average Customer Rating
```sql
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data;
```

Objective: Calculate the average customer satisfaction rating across all items sold.
---
📊 B. Granular Requirements
---
Q7. Total Sales by Fat Content
```sql
SELECT item_fat_content,
       CAST(SUM(total_sales)  AS DECIMAL(10,2)) AS Total_sales,
       CAST(AVG(total_sales)  AS DECIMAL(10,1)) AS Avg_sales,
       COUNT(*)                                 AS Num_Of_Items,
       CAST(AVG(Rating)       AS DECIMAL(10,2)) AS Avg_rating
FROM blinkit_data
GROUP BY item_fat_content
ORDER BY Total_sales DESC;
```

Objective: Analyze the impact of fat content on total sales, average sales, item count, and average rating.
---
Q8. Fat Content Analysis — Outlets Established in 2022
```sql
SELECT item_fat_content,
       CAST(SUM(total_sales)  AS DECIMAL(10,2)) AS Total_sales,
       CAST(AVG(total_sales)  AS DECIMAL(10,2)) AS Avg_sales,
       COUNT(*)                                 AS Num_Of_Items,
       CAST(AVG(Rating)       AS DECIMAL(10,2)) AS Avg_rating
FROM blinkit_data
WHERE outlet_establishment_year = 2022
GROUP BY item_fat_content
ORDER BY Total_sales DESC;
```

Objective: Same fat content breakdown filtered specifically for outlets established in 2022.
---
Q9. Total Sales by Item Type (Top 5)
```sql
SELECT item_type,
       CAST(SUM(total_sales)  AS DECIMAL(10,2)) AS Total_sales,
       CAST(AVG(total_sales)  AS DECIMAL(10,2)) AS Avg_sales,
       COUNT(*)                                 AS Num_Of_Items,
       CAST(AVG(Rating)       AS DECIMAL(10,2)) AS Avg_rating
FROM blinkit_data
GROUP BY item_type
ORDER BY Total_sales DESC
LIMIT 5;
```

Objective: Identify the top 5 best-performing item types by total sales and related KPIs.
---
Q10. Fat Content by Outlet Location (Detailed)
```sql
SELECT outlet_location_type,
       item_fat_content,
       CAST(SUM(total_sales)  AS DECIMAL(10,2)) AS Total_sales,
       CAST(AVG(total_sales)  AS DECIMAL(10,2)) AS Avg_sales,
       COUNT(*)                                 AS Num_Of_Items,
       CAST(AVG(Rating)       AS DECIMAL(10,2)) AS Avg_rating
FROM blinkit_data
GROUP BY outlet_location_type, item_fat_content
ORDER BY Total_sales ASC;
```

Objective: Compare total sales across outlet locations segmented by fat content.
---
Q11. Fat Content by Outlet Location (Pivot View)
```sql
SELECT
    Outlet_Location_Type,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Low Fat'  THEN Total_Sales ELSE 0 END), 0) AS Low_Fat,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Regular'  THEN Total_Sales ELSE 0 END), 0) AS Regular
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;
```

Objective: Display Low Fat vs Regular sales side-by-side for each outlet location type.
---
Q12. Total Sales by Outlet Establishment Year
```sql
SELECT outlet_establishment_year,
       CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
       COUNT(*)                                AS Num_Of_Items
FROM blinkit_data
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year ASC;
```

Objective: Evaluate how the age or year of outlet establishment influences total sales over time.
---
Q13. Percentage of Sales by Outlet Size
```sql
SELECT
    Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;
```

Objective: Analyze the correlation between outlet size and its percentage contribution to total sales.
---
Q14. Sales by Outlet Location
```sql
SELECT Outlet_Location_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;
```

Objective: Assess the geographic distribution of sales across Tier 1, Tier 2, and Tier 3 locations.
---
Q15. All Metrics by Outlet Type
```sql
SELECT Outlet_Type,
       CAST(SUM(Total_Sales)       AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales)       AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*)                                      AS No_Of_Items,
       CAST(AVG(Rating)            AS DECIMAL(10,2)) AS Avg_Rating,
       CAST(AVG(Item_Visibility)   AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
```

---  

🐍 Python Analysis  
- [x] The Jupyter Notebook covers:  
- [x] Data loading & cleaning  
- [x] Univariate and bivariate analysis  
- [x] Sales distribution by fat content, item type, outlet type  
- [x] Visualizations using Matplotlib & Seaborn   
Open `Blinkit_Analysis_in_python.ipynb` or view the static report at `Blinkit_Analysis_in_python.html`.  

---

 📊 **Dashboard Highlights:**

- **KPI Cards** — Total Sales ($1.20M), Avg Sales ($141), No of Items (8523), Avg Rating (3.9) 
- **Filter Panel** — Slice all visuals by Outlet Location Type, Outlet Size, and Item Type  
- **Fat Content** — Donut chart (Low Fat 65% | Regular 35%)  
- **Fat by Outlet** — Grouped bar chart comparing Low Fat vs Regular across Tier 1, 2, 3  
- **Item Type** — Horizontal bar chart ranking all product categories by revenue  
- **Outlet Establishment** — Line/area chart showing sales trend from 1998 to 2022  
- **Outlet Size** — Donut chart (High $508K | Medium $249K | Small $445K)  
- **Outlet Location** — Bar chart (Tier 3: $472K | Tier 2: $393K | Tier 1: $336K)   
- **Outlet Type Table** — Full breakdown of Total Sales, Avg Sales, No of Items, Avg Rating, Item Visibility


---

📊**Key Insights**
💰 Total Sales reached $1.20M with an average sale value of $141 across 8,523 items   
🥗 Low Fat items account for ~65% of total sales vs ~35% for Regular fat items  
🏪 Supermarket Type1 is the highest-performing outlet type with $787.55K in total sales   
📍 Tier 3 locations lead in revenue at $472K, followed by Tier 2 ($393K) and Tier 1 ($336K)  
📦 Fruits & Vegetables and Snack Foods are the top-selling item categories   
📅 Outlets established around 2018 show peak sales of $205K — the highest across all years  

---

📌 Future Improvements   
- [ ] Add customer segmentation based on purchase patterns and ratings  
- [ ] Perform product affinity analysis (frequently bought together)   
- [ ] Build automated monthly KPI report using SQL stored procedures   
- [ ] Add sales forecasting by outlet type and location   
- [ ] Optimize queries using indexing on outlet_type and item_fat_content   
- [ ] Expand Python analysis with machine learning for sales prediction   

---

🤝 Connect With Me  

![GitHub](https://img.shields.io/badge/GitHub-mr--deepak--kp-181717?style=for-the-badge&logo=github)    
![LinkedIn](https://img.shields.io/badge/LinkedIn-deepak--kumar--prasad-0A66C2?style=for-the-badge&logo=linkedin)  

---
Blinkit Grocery Sales Analysis · MySQL · Python · Power BI · Excel · Business Intelligence
