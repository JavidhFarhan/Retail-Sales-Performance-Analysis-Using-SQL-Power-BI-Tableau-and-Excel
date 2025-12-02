create schema retailsales;
use retailsales;
select * from retail_sales;

-- 1. Product Level Analysis
-- A. Top Revenue Products
SELECT 
    Description, ROUND(SUM(Sales), 2) AS TotalRevenue
FROM
    retail_sales
GROUP BY Description
ORDER BY TotalRevenue DESC
LIMIT 10;

-- B. Low Performing Products
SELECT 
    Description, SUM(Quantity) AS UnitsSold
FROM
    retail_sales
GROUP BY Description
ORDER BY UnitsSold asc
limit 10;

-- 2. Customer Analysis
-- A. Most Valuable Customers (High Spend)
SELECT 
    CustomerID, ROUND(SUM(Quantity * Price), 2) AS TotalSpent
FROM
    retail_sales
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;

-- B. Customer Purchase Frequency 
SELECT 
    CustomerID, COUNT(DISTINCT Invoice) AS PurchaseCount
FROM
    retail_sales
GROUP BY CustomerID
ORDER BY PurchaseCount Desc
Limit 10;

-- C. Average Order Value per Customer
SELECT 
    CustomerID, ROUND(AVG(Quantity * Price), 2) AS AvgOrderValue
FROM
    retail_sales
GROUP BY CustomerID
ORDER BY AvgOrderValue Asc
LIMIT 10;

-- 3. Geographic Analysis
--  A. Revenue by Country
SELECT 
    Country, Round(SUM(Quantity * Price),2) AS CountryRevenue
FROM
    retail_sales
GROUP BY Country
ORDER BY CountryRevenue ASC
Limit 10;

-- B. Top/Least Products Sold by country
SELECT 
    Country, Description, ROUND(SUM(Quantity), 2) AS UnitsSold
FROM
    retail_sales
GROUP BY Country , Description
ORDER BY UnitsSold Asc
Limit 10;

-- C. Country-wise Sales Volume 
SELECT 
    Country, ROUND(SUM(Quantity), 2) AS UnitsSold
FROM
    retail_sales
GROUP BY Country
ORDER BY UnitsSold ASC
LIMIT 10;


-- 4. Geographic Analysis
-- A. Daily Sales Trend
SELECT DATE(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS Day,
       ROUND(SUM(Sales),2) AS DailyRevenue
FROM retail_sales
WHERE InvoiceDate IS NOT NULL
GROUP BY Day
ORDER BY DailyRevenue Asc
Limit 10;

-- B. Monthly Analysis
SELECT 
    DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%d-%m-%Y'), '%Y-%m') AS SaleMonth,
    ROUND(SUM(Sales), 2) AS MonthlyRevenue
FROM retail_sales
WHERE InvoiceDate IS NOT NULL
GROUP BY SaleMonth
ORDER BY MonthlyRevenue Asc
LIMIT 10;

-- C. Quarterly Analysis
SELECT 
    CONCAT(YEAR(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')),
            '-Q',
            QUARTER(STR_TO_DATE(InvoiceDate, '%d-%m-%Y'))) AS SaleQuarter,
    ROUND(SUM(Sales), 2) AS QuarterlyRevenue
FROM
    retail_sales
WHERE
    InvoiceDate IS NOT NULL
GROUP BY SaleQuarter
ORDER BY QuarterlyRevenue ASC
LIMIT 10;  

-- D.  Yearly Analysis
SELECT 
    YEAR(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS SaleYear,
    ROUND(SUM(Sales), 2) AS YearlyRevenue
FROM
    retail_sales
WHERE
    InvoiceDate IS NOT NULL
GROUP BY SaleYear
ORDER BY YearlyRevenue;

-- E. Hourly Analysis
SELECT 
    HOUR(STR_TO_DATE(InvoiceTime, '%H:%i:%s')) AS SaleHour,
    ROUND(SUM(Sales), 2) AS HourlyRevenue
FROM
    retail_sales
WHERE
    InvoiceTime IS NOT NULL
GROUP BY SaleHour
ORDER BY SaleHour;

-- F. Sales Distribution Across Time Blocks
SELECT 
    CASE 
        WHEN HOUR(STR_TO_DATE(InvoiceTime, '%H:%i:%s')) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(InvoiceTime, '%H:%i:%s')) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(STR_TO_DATE(InvoiceTime, '%H:%i:%s')) BETWEEN 18 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS TimeBlock,
    ROUND(SUM(Sales),2) AS Revenue
FROM retail_sales
GROUP BY TimeBlock
ORDER BY Revenue DESC;

--  G. Weekday vs Weekend Behavior
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,
    ROUND(SUM(Sales), 2) AS TotalRevenue,
    COUNT(DISTINCT STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS Number_of_Days
FROM retail_sales
GROUP BY DayType;

-- 5.Quantity / Price Distribution
SELECT 
    CASE 
        WHEN Quantity BETWEEN 1 AND 10 THEN 'Small'
        WHEN Quantity BETWEEN 11 AND 25 THEN 'Medium'
        WHEN Quantity BETWEEN 26 AND 40 THEN 'Large'
        ELSE 'Very Large'
    END AS QuantitySegment,
    ROUND(SUM(Sales),2) AS Revenue,
    COUNT(*) AS NumOrders
FROM retail_sales
GROUP BY QuantitySegment;

-- 6. Inventory/ Stock Movement
-- A. Fast-Moving vs Slow-Moving Products
SELECT 
    StockCode,
    Description,
    SUM(Quantity) AS TotalSoldQty,
    COUNT(DISTINCT Invoice) AS NumOrders
FROM retail_sales
WHERE Quantity > 0
GROUP BY StockCode, Description
ORDER BY TotalSoldQty ASC
Limit 10;

-- B. Products Frequently Bought Together (Basket Analysis)
SELECT 
    Invoice, 
    -- GROUP_CONCAT(DISTINCT REPLACE(Description, 'Product_', '')) AS ProductsBought,
    COUNT(DISTINCT Description) AS TotalProductsBought
FROM retail_sales
GROUP BY Invoice
order by TotalProductsBought asc
Limit 10;


-- 7. Sales Growth Rate (Month-over-Month)
SELECT 
    SaleMonth,
    MonthlyRevenue,
    LAG(MonthlyRevenue) OVER (ORDER BY SaleMonth) AS PrevMonthRevenue,
    ROUND(
        ((MonthlyRevenue - LAG(MonthlyRevenue) OVER (ORDER BY SaleMonth)) 
        / LAG(MonthlyRevenue) OVER (ORDER BY SaleMonth)) * 100, 2
    ) AS MoM_Growth_Percent
FROM (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%d-%m-%Y'), '%Y-%m') AS SaleMonth,
        Round(SUM(Sales),2) AS MonthlyRevenue
    FROM retail_sales
    GROUP BY SaleMonth
) AS MonthlySales
ORDER BY SaleMonth;
