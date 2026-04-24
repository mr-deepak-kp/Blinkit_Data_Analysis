--  Problem Statment 
/*
              Key Performance Indicators (KPIs)
              
To measure success and performance, the following metrics have been established:
-- Total Sales: The overall revenue generated from all sold items.
-- Average Sales: The average revenue generated per individual sale.
-- Number of Items: The total count of distinct items sold.
-- Average Rating: The average customer rating for the items sold.

BUSINESS REQUIREMENT
-- Granular Requirements
1. Total Sales by Fat Content:
	Objective: Analyze the impact of fat content on total sales.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
    
2. Total Sales by Item Type:
	Objective: Identify the performance of different item types in terms of total sales.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
    
3. Fat Content by Outlet for Total Sales:
	Objective: Compare total sales across different outlets segmented by fat content.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
    
4. Total Sales by Outlet Establishment:
	Objective: Evaluate how the age or type of outlet establishment influences total sales.
    
5. Percentage of Sales by Outlet Size:
	Objective: Analyze the correlation between outlet size and total sales.
    
6. Sales by Outlet Location:
	Objective: Assess the geographic distribution of sales across different locations.
    
7. All Metrics by Outlet Type:
	Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of 	Items, Average Rating) broken down by different outlet types.
*/


       --  Key Performance Indiactors (KPIs)
       
-- Total Sales: The overall revenue generated from all sold items.
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data;

-- Toatal Particular regular items sales in fat Content 
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data
WHERE item_fat_content = 'Regular';

--  Toatal sales Estiblished in 2022
SELECT CAST(SUM(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data
WHERE outlet_establishment_year = 2022;


-- Average Sales: The average revenue generated per individual sale.
SELECT CAST(AVG(total_sales) AS DECIMAL(10,2)) AS Avg_sales
FROM blinkit_data;

--  Average sales Estiblished in 2022
SELECT CAST(AVG(total_sales)/1000000 AS DECIMAL(10,2)) AS Total_sales_Millions
FROM blinkit_data
WHERE outlet_establishment_year = 2022;

-- Number of Items: The total count of distinct items sold.
SELECT  COUNT(*) AS Num_Of_Items
FROM blinkit_data;

-- Number of Items: The total count of distinct items sold.
SELECT  COUNT(*) AS Num_Of_Items
FROM blinkit_data
WHERE outlet_establishment_year = 2022;

-- Average Rating: The average customer rating for the items sold.
SELECT CAST(AVG(Rating) AS DECIMAL(10,2))  AS Avg_Rating  
FROM blinkit_data;


                        --  Granular Requirements  -- 

-- 1. Toatal Sales By  Fat Content Analysis
-- Objective: Analyze how fat content impacts total sales.
-- Metrics: Assess variations in Average Sales, Number of Items, and Average Rating based on fat content.

SELECT  item_fat_content, 
           CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
           CAST(AVG(total_sales) AS DECIMAL(10,1)) AS Avg_sales_per_row,
           COUNT(*) AS Num_Of_Items,
           CAST(AVG(Rating) AS DECIMAL(10,2)) As Avg_rating          
FROM  blinkit_data
GROUP BY 1
ORDER BY total_sales DESC;


--  Outlet stablished in 2020

SELECT  item_fat_content, 
           CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
           CAST(AVG(total_sales) AS DECIMAL(10,2)) AS Avg_sales_per_row,
           COUNT(*) AS Num_Of_Items,
           CAST(AVG(Rating) AS DECIMAL(10,2)) As Avg_rating          
FROM  blinkit_data
WHERE outlet_establishment_year = 2022
GROUP BY 1
ORDER BY total_sales DESC;

/* 
2. Total Sales by Item Type:
	Objective: Identify the performance of different item types in terms of total sales.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.  
*/

SELECT  item_type, 
           CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
           CAST(AVG(total_sales) AS DECIMAL(10,2)) AS Avg_sales_per_row,
           COUNT(*) AS Num_Of_Items,
           CAST(AVG(Rating) AS DECIMAL(10,2)) As Avg_rating          
FROM  blinkit_data
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;

/*
3. Fat Content by Outlet for Total Sales:
	Objective: Compare total sales across different outlets segmented by fat content.
	Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content. 
*/

SELECT  outlet_location_type,item_fat_content, 
           CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
           CAST(AVG(total_sales) AS DECIMAL(10,2)) AS Avg_sales_per_row,
           COUNT(*) AS Num_Of_Items,
           CAST(AVG(Rating) AS DECIMAL(10,2)) As Avg_rating          
FROM  blinkit_data
GROUP BY 1,2                --  1 is Refered to First  column(outlet_location_type) &  2nd is column item_fat_content
ORDER BY total_sales ASC;    

-- Or 
SELECT 
    Outlet_Location_Type,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END), 0) AS Low_Fat,
    COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END), 0) AS Regular
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

/*
4. Total Sales by Outlet Establishment:
	Objective: Evaluate how the age or type of outlet establishment influences total sales.
*/

SELECT outlet_establishment_year,
                  CAST(SUM(total_sales) AS DECIMAL(10,2)) AS Total_sales,
                    COUNT(*) AS Num_Of_Items
FROM blinkit_data 
GROUP BY 1
ORDER BY outlet_establishment_year ASC;   --  For the order according to outlet_establishment_year

/*
5. Percentage of Sales by Outlet Size:
	Objective: Analyze the correlation between outlet size and total sales.
*/

SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

/* 
6. Sales by Outlet Location:
	Objective: Assess the geographic distribution of sales across different locations.
*/
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

/* 
7. All Metrics by Outlet Type:
	Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of 	Items, Average Rating) broken down by different outlet types.
*/

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


---  END 


SELECT  * FROM blinkit_data;