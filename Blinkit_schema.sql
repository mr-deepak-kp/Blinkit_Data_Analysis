CREATE DATABASE blinkit_DB;
USE blinkit_DB;

--  Creating Table 

CREATE TABLE blinkit_data (
    item_fat_content VARCHAR(40),
    item_identifier VARCHAR(40),
    item_type VARCHAR(60),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(30),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(20),
    outlet_type VARCHAR(30),
    item_visibility DOUBLE(10,2),
    item_weight DOUBLE(10,2),
    total_sales DOUBLE(10,2),
    rating DOUBLE(10,2)
);

DROP TABLE IF EXISTS blinkit_data;
-- Data import  throw normal cmd 
/* 
 
mysql --local-infile=1 -u root -p
SET GLOBAL local_infile = 1;	
SHOW GLOBAL VARIABLES LIKE 'local_infile';    -- ON 
Exit
USE coffee_sales_db;

LOAD DATA LOCAL INFILE 'C:\Data Analysis\Blinkit_Data\BlinkIT Grocery Data.csv'   
IF ERROR :  File 'C:Data AnalysisBlinket_DataBlinkIT Grocery Data.csv' not found (No such file or directory)   means Mysql needs to be / 0r \\ insted of \
INTO TABLE blinkit_data 
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;    */

--  Problem After inserting Data   Warnings 


TRUNCATE TABLE blinkit_data;

SELECT item_weight 
FROM blinkit_data 
WHERE item_weight IS NULL LIMIT 10;

SELECT count(*)
FROM blinkit_data 
WHERE item_weight = 0 ;


--  Data Cleaning 
--  Change data in item_fat_content column

UPDATE blinkit_data 
SET item_fat_content = 'Low Fat' 
WHERE item_fat_content = 'LF';

-- Disable safe mode temporarily
SET SQL_SAFE_UPDATES = 0;

-- Update all variations to standard values (With multiple conditions) 
UPDATE blinkit_data 
SET item_fat_content = CASE
    WHEN item_fat_content IN ('LF', 'Lf', 'low fat', 'Low Fat') THEN 'Low Fat'
    WHEN item_fat_content IN ('reg', 'REG', 'regular') THEN 'Regular'
    ELSE item_fat_content
END;

-- Re-enable safe mode
SET SQL_SAFE_UPDATES = 1;

/* //  What is safe mode 
Safe mode is a security feature in MySQL prevents accidentally updating or deleting an entire table.
What does Safe Mode do?
When Safe mode is ON, MySQL BLOCKS these types of queries:
UPDATE without a WHERE clause
DELETE without a WHERE clause
UPDATE/DELETE where the WHERE clause doesn't use a KEY column (like PRIMARY KEY)   */ 

-- let's check
SELECT  DISTINCT(item_fat_content) 
FROM blinkit_data;

-- 
SELECT *
from blinkit_data ;











