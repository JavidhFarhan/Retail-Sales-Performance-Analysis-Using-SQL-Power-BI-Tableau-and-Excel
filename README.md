# Retail-Sales-Performance-Analysis-Using-SQL-Power-BI-Tableau-and-Excel
### https://drive.google.com/drive/folders/1As-_T1OQEPwNy07R9pEe0kTcCqc7JhLX?usp=sharing
## Objective:
Conduct a comprehensive analysis of retail sales performance using SQL, Power BI, Tableau, and Excel, apply RFM segmentation to uncover customer behaviour patterns, and deliver actionable insights that strengthen retention, boost revenue, and guide strategic decision-making.

## Core skills take away

•	SQL: Writing queries to extract and analyze sales data from databases.

•	Power BI: Building dynamic reports and dashboards to visualize sales insights.

•	Excel: Data cleaning, pivot tables, and trend analysis for decision-making.

•	Business Intelligence: Understanding key metrics for retail performance analysis.

•	Data-Driven Decision Making: Applying data analytics for strategic improvements.

## Approach:

## Phase 1: Data Collection and Preprocessing

•	Extract raw sales data from an SQL database.

•	Clean and preprocess the data using SQL and Excel (handle missing values, remove duplicates, standardize data formats).

## Phase 2: Exploratory Data Analysis (EDA)

•	Conduct a descriptive analysis using SQL queries.

•	Use Excel to create pivot tables for initial insights.

•	Generate visualizations in Power BI and Tableau to explore trends in sales, customer demographics, and product performance.

## Phase 3: Data Modeling and Dashboard Creation

•	Build an interactive dashboard in Power BI for real-time sales tracking.

•	Apply filtering and drill-down options for deeper insights.

•	Develop KPI indicators for revenue, profit margins, and customer retention.

## Phase 4: Forecasting and Business Recommendations

•	Use time-series analysis to predict future sales trends.

•	Provide actionable recommendations for inventory management, marketing strategies, and pricing models.

•	Create final reports summarizing findings and strategic business suggestions.

## Obtain the Dataset:

•	Access and retrieve the dataset from the specified source link.

•	Perform an initial assessment of the dataset, focusing on column definitions, data types, and data completeness.

## Data Set Shape:

Rows:525001 ( Including Header)

Columns: 8

Dataset Columns: Invoice, Stock Code, Description, Quantity, Invoice Date, Price, Customer ID, Country

## Data Preparation and Transformation Steps

1. Apply ABS Function:

    Convert negative values in the Quantity and Price columns to positive using the ABS function.

2. Create Sales Column:

    Add a new column calculating Sales as the product of Quantity × Price.

3. Data Quality Checks:

    Identify and handle duplicates, null values, and blank entries to ensure dataset integrity.

4. Standardize Country Names:

    Update the Country column by replacing “EIRE” with “Eire” and verify consistency with case sensitivity.

5. Split Invoice Date:

    Separate the Invoice Date column into two fields: Invoice Date and Invoice Time. Confirm appropriate data types for both date and time.

6. Customer Segmentation:

     Introduce a Customer Segment column based on Order Quantity:

• 	≤10 → Basic

• 	≤20 → Standard

• 	≤30 → Premium

• 	≤40 → Super Premium

• 	≥41 → Bulk

7. Rearrange Columns for Accessibility:

   Organize the dataset in the following order for easier analysis:

Invoice Date, Invoice Time, Invoice, Customer ID, Country, Stock Code, Description, Quantity, Price, Sales, Customer Segment.

•	Business Impact: They reveal top products, loyal customers, seasonal peaks, and geographic strengths.

•	Dashboard KPIs: Feed directly into Power BI/Tableau visuals (Revenue by Country, Customer Segments, Daily Trends).

•	Strategic Insights: Help optimize pricing, inventory, and marketing campaigns.

## Exploratory Data Analysis (EDA) Using SQL

Import the data into Sql

create schema retailsales;

use retailsales;

select * from retail_sales;

<img width="1038" height="348" alt="image" src="https://github.com/user-attachments/assets/041725ea-0069-4b5c-b780-00b6f700eea0" />

 

Data info: 52500 rows returned.

## Descriptive Analysis

1.Product Level Analysis:

A. Top Revenue Products

SELECT 
    
    Description, ROUND(SUM(Sales), 2) AS TotalRevenue

FROM
    
    retail_sales

GROUP BY Description

ORDER BY TotalRevenue DESC

LIMIT 10;

<img width="290" height="303" alt="image" src="https://github.com/user-attachments/assets/f624cb9a-cf08-4dcf-b2c2-0148aff26261" />


B. Low Performing Products

SELECT 
    
    Description, SUM(Quantity) AS UnitsSold

FROM
    
    retail_sales

GROUP BY Description

ORDER BY UnitsSold asc

limit 10;

<img width="254" height="308" alt="image" src="https://github.com/user-attachments/assets/c79f90eb-b314-44d2-b1b4-d63537987457" />

2.Customer Analysis:

A. Most Valuable Customers (High Spend)

SELECT 
    
    CustomerID, ROUND(SUM(Quantity * Price), 2) AS TotalSpent

FROM
    
    retail_sales

GROUP BY CustomerID

ORDER BY TotalSpent DESC

LIMIT 10;

<img width="259" height="295" alt="image" src="https://github.com/user-attachments/assets/b0d36df7-4113-477f-b047-64c46e05fd13" />


B. Customer Purchase Frequency

SELECT 
    
    CustomerID, COUNT(DISTINCT Invoice) AS PurchaseCount

FROM
    
    retail_sales

GROUP BY CustomerID

ORDER BY PurchaseCount Asc/Desc

Limit 10;

<img width="310" height="301" alt="image" src="https://github.com/user-attachments/assets/a557e5fe-182a-483b-a385-8e862ac8ec53" />
<img width="296" height="306" alt="image" src="https://github.com/user-attachments/assets/ea214691-c4bd-457c-8fbc-cbef58f2f7b2" />


C. Average Order Value per Customer

SELECT 
    
    CustomerID, ROUND(AVG(Quantity * Price), 2) AS AvgOrderValue

FROM
    
    retail_sales

GROUP BY CustomerID

ORDER BY AvgOrderValue DESC/ ASC

LIMIT 10;
  
<img width="296" height="304" alt="image" src="https://github.com/user-attachments/assets/d4ac285b-55d2-4033-bb0b-c15086ee41f5" />
<img width="296" height="304" alt="image" src="https://github.com/user-attachments/assets/14b1e051-1b94-470b-a516-5153931eaa76" />


3. Geographic Analysis

A. Revenue by Country

SELECT 
   
    Country, Round(SUM(Quantity * Price),2) AS CountryRevenue

FROM
    
    retail_sales

GROUP BY Country

ORDER BY CountryRevenue DESC/ASC

Limit 10;

  <img width="360" height="303" alt="image" src="https://github.com/user-attachments/assets/d3ace350-e532-46f5-9256-2f429dfcfcca" />
  <img width="341" height="303" alt="image" src="https://github.com/user-attachments/assets/f665e22e-75fe-4a87-bbe3-561945ea1025" />

B. Top Products by country

SELECT 
    
    Country, Description, ROUND(SUM(Quantity), 2) AS UnitsSold

FROM
   
    retail_sales

GROUP BY Country , Description

ORDER BY UnitsSold DESC/ASC

Limit 10;
  
<img width="404" height="301" alt="image" src="https://github.com/user-attachments/assets/285db363-d8b6-4b52-b74c-9d1b30608fa7" />
<img width="423" height="300" alt="image" src="https://github.com/user-attachments/assets/f07d647b-7cee-4835-a8b5-e14e1015938a" />

C. Country-wise Sales Volume

SELECT 
    
    Country, ROUND(SUM(Quantity), 2) AS UnitsSold

FROM
    
    retail_sales

GROUP BY Country

ORDER BY UnitsSold DESC/ASC

LIMIT 10;

<img width="321" height="301" alt="image" src="https://github.com/user-attachments/assets/7974a997-49a7-4534-b9cc-ccfce582b001" />

<img width="259" height="303" alt="image" src="https://github.com/user-attachments/assets/101c52a6-b5d6-456b-bf37-0c37934452b5" />

  
4. Time Based Analysis

A. Daily Sales Trend

SELECT DATE(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS Day,
       
       ROUND(SUM(Sales),2) AS DailyRevenue

FROM retail_sales

WHERE InvoiceDate IS NOT NULL

GROUP BY Day

ORDER BY DailyRevenue Desc/Asc

Limit 10;
  
<img width="284" height="296" alt="image" src="https://github.com/user-attachments/assets/22144f16-4fba-4319-b5d2-8943407fcb9a" />
<img width="296" height="301" alt="image" src="https://github.com/user-attachments/assets/06eb3add-9159-4bdb-b98c-5fbe4fe9b693" />

B. Monthly Analysis

SELECT 

    DATE_FORMAT(STR_TO_DATE(InvoiceDate, '%d-%m-%Y'), '%Y-%m') AS SaleMonth,
    ROUND(SUM(Sales), 2) AS MonthlyRevenue

FROM retail_sales

WHERE InvoiceDate IS NOT NULL

GROUP BY SaleMonth

ORDER BY MonthlyRevenue Desc/Asc

LIMIT 10;
  
<img width="309" height="308" alt="image" src="https://github.com/user-attachments/assets/1a983bd0-9092-407e-9ff8-ada935a77206" />
<img width="303" height="301" alt="image" src="https://github.com/user-attachments/assets/45e89d3b-43c1-4c68-9373-32c9e5d743fd" />

C. Quarterly Analysis

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

ORDER BY QuarterlyRevenue DESC/ASC

LIMIT 10;

<img width="328" height="303" alt="image" src="https://github.com/user-attachments/assets/39afb638-b33a-445b-8882-9f7c5c83c8db" />

<img width="321" height="300" alt="image" src="https://github.com/user-attachments/assets/f7ef308d-0052-43e2-8dcc-3475268cd262" />



D.  Yearly Analysis

SELECT 

    YEAR(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS SaleYear,
    ROUND(SUM(Sales), 2) AS YearlyRevenue

FROM

    retail_sales

WHERE

    InvoiceDate IS NOT NULL

GROUP BY SaleYear

ORDER BY YearlyRevenue;
 
<img width="278" height="110" alt="image" src="https://github.com/user-attachments/assets/ea9eb61c-9067-437d-a354-2b165520e3a1" />

E. Hourly Analysis

SELECT 

    HOUR(STR_TO_DATE(InvoiceTime, '%H:%i:%s')) AS SaleHour,
    ROUND(SUM(Sales), 2) AS HourlyRevenue

FROM

    retail_sales

WHERE

    InvoiceTime IS NOT NULL

GROUP BY SaleHour

ORDER BY SaleHour;

<img width="258" height="670" alt="image" src="https://github.com/user-attachments/assets/d8d35846-d850-481d-9983-9c16a7fb57c6" />
 

F. Sales Distribution Across Time Blocks

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

 <img width="279" height="140" alt="image" src="https://github.com/user-attachments/assets/dc089ba3-32c9-44ff-b9f6-4592e78db026" />

G. Weekday vs Weekend Behavior

SELECT 

    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,
    ROUND(SUM(Sales), 2) AS TotalRevenue,
    COUNT(DISTINCT STR_TO_DATE(InvoiceDate, '%d-%m-%Y')) AS Number_of_Days

FROM retail_sales

GROUP BY DayType;
 
<img width="484" height="96" alt="image" src="https://github.com/user-attachments/assets/f47280a5-c453-41fb-845a-cd632e575a61" />

5.Quantity / Price Distribution

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

 <img width="458" height="141" alt="image" src="https://github.com/user-attachments/assets/7f73a300-566a-4e7a-908e-5a3228ba2c14" />



6. Inventory/ Stock Movement

A. Fast-Moving vs Slow-Moving Products

SELECT 

    StockCode,
    Description,
    SUM(Quantity) AS TotalSoldQty,
    COUNT(DISTINCT Invoice) AS NumOrders

FROM retail_sales

WHERE Quantity > 0

GROUP BY StockCode, Description

ORDER BY TotalSoldQty DESC

Limit 10;

  <img width="408" height="323" alt="image" src="https://github.com/user-attachments/assets/399ac50f-32a0-4608-aead-7740faf739de" />
<img width="383" height="326" alt="image" src="https://github.com/user-attachments/assets/c90674ee-d23c-4190-b955-e9671f576083" />

B. Products Frequently Bought Together (Basket Analysis)

SELECT 

    Invoice, 
    GROUP_CONCAT(DISTINCT REPLACE(Description, 'Product_', '')) AS ProductsBought,
    COUNT(DISTINCT Description) AS TotalProductsBought

FROM retail_sales

GROUP BY Invoice

order by TotalProductsBought desc/asc

Limit 10;

 <img width="301" height="291" alt="image" src="https://github.com/user-attachments/assets/52a4045f-266f-4d52-9afc-a569b1ceedfd" />
 <img width="295" height="294" alt="image" src="https://github.com/user-attachments/assets/154081ed-83d9-4588-b186-e33e22b9b65b" />

7. Sales Growth Rate (Month-over-Month)

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

 <img width="666" height="678" alt="image" src="https://github.com/user-attachments/assets/1e6c8d14-e49a-4c39-be42-51e649f91d7e" />

## Exploratory Data Analysis (EDA) Using Excel

Pivot Tables for Summary Views

•	Total Quantity Sold: 12393249 units

•	Total Revenue: ₹6200097188

•	Average Revenue per Unit: ₹500.28

1.Top 10 Selling Products
A. Revenue based on Quantity Volume

 
<img width="334" height="289" alt="image" src="https://github.com/user-attachments/assets/fb9f1e1a-ee41-4b82-97da-ee6ad5912ded" />
 

<img width="1043" height="615" alt="image" src="https://github.com/user-attachments/assets/15869079-30a5-468a-bc14-26fbbcec8684" />

Business Insights: 

1.High Quantity ≠ Highest Revenue

•	Product_2694 sold the most units (2129) but ranks #4 in revenue.

•	Product_1193 sold fewer units (1956) but generated the highest revenue.

2.Top Revenue Drivers

•	Product_1193, Product_394, Product_4591, Product_6332 all crossed ₹1 million in revenue.

•	These products are ideal for premium positioning or bundling strategies.

3.Revenue per Unit Analysis

•	Product_1193 leads with ₹558.27 per unit — highest among all.

•	Product_118 has the lowest revenue per unit (₹432.57), despite high volume.

Actionable Tip: Consider price optimization or upselling for low-margin high-volume products like Product_118.

4.Balanced Performers

•	Product_175, Product_4208, Product_4591 show strong balance between quantity and revenue.

•	These are ideal for core product campaigns or cross-selling anchors.

5.Grand Total Overview

•	Total Quantity Sold: 20,001 units

•	Total Revenue: ₹9,855,174.33

•	Average Revenue per Unit: ₹492.73

B. Quantity based on Revenue Volume


<img width="308" height="289" alt="image" src="https://github.com/user-attachments/assets/f79ce1e1-f424-4f55-9b82-7bb3794c7ee3" />

 
<img width="911" height="571" alt="image" src="https://github.com/user-attachments/assets/6307e23a-6267-47a8-a683-56ad0de273d6" />

Business Insights: 

1.Premium Products Drive Revenue

•	Product_2981 has the highest revenue per unit at ₹624.01, despite lower quantity.

•	Product_4076 and Product_7711 also show strong per-unit revenue (₹586+).

These are likely premium-priced items — ideal for margin-focused strategies

2.Balanced Revenue Contributors

•	Product_1193, Product_4210, Product_2529 have solid quantity and strong revenue per unit (₹550–₹560 range).

•	These are core performers — consistent sellers with healthy margins.

3.Volume vs Value

•	Product_2694 sold the most units (2129) but has the lowest revenue per unit (₹479.78).

4.Grand Totals

•	Total Quantity: 19,110 units

•	Total Revenue: ₹10,508,915.20

•	Average Revenue per Unit: ₹549.99

Strategic Actions

• 	Promote high-margin products like Product_2981 and Product_4076 in premium campaigns.

• 	Bundle low-margin high-volume products like Product_2694 to increase basket size.

• 	Use RFM segmentation to target customers who buy high-revenue products frequently.

• 	Visualize this data with bar charts (Revenue vs Product) or scatter plots (Quantity vs Revenue per Unit) for dashboard storytelling.

2.Top 10 Revenue by Country


<img width="522" height="289" alt="image" src="https://github.com/user-attachments/assets/4af71313-e4f6-4481-ac09-82456202f3b1" />

 
<img width="728" height="452" alt="image" src="https://github.com/user-attachments/assets/aece8f5e-ac39-4a81-a286-f89db491db89" />


Business Insights: 

1.High-Volume Market

•	United Kingdom dominates with 4.34B

2.Premium Efficiency Markets

•	Denmark has the highest revenue per unit (₹508.78) despite lower quantity.

•	Germany, Japan, Korea, Nigeria also show above-average efficiency (₹501–505 per unit).

3.Balanced Performers

•	United Arab Emirates, Eire hover around ₹498 per unit.

•	Stable contributors, but not standout in either volume or margin

4.Lower Efficiency Markets

•	Iceland (₹495.35) and France (₹497.76) are slightly below average.

5.Benchmark

•	Global Average Revenue per Unit ≈ ₹500

Strategic Actions

•	UK → Push volume campaigns (bundles, loyalty programs).

•	Denmark, Germany, Japan → Focus on premium positioning and upselling.

•	Iceland, France → Investigate pricing/cost structure to improve margins.

•	UAE, Eire → Maintain steady contribution, explore growth opportunities.

3.Customer Segmentation

A. Based on Orders Frequency 


<img width="299" height="265" alt="image" src="https://github.com/user-attachments/assets/d2a59b27-f75d-45c6-9b6d-394a72d2fc11" />
<img width="764" height="423" alt="image" src="https://github.com/user-attachments/assets/04872cb3-dfa7-4611-a1f3-fa7129e6157e" />

 
B. Based on Total Spend


<img width="299" height="289" alt="image" src="https://github.com/user-attachments/assets/bc08d165-b32a-40be-ae38-68bc8183b5ab" />
<img width="752" height="452" alt="image" src="https://github.com/user-attachments/assets/6a96b8f1-7760-46d7-a843-83a00560db5e" />


 
Business Insights: 

1.High-Frequency Customers (Table 1)

•	Customer 17481: Highest frequency (121) with spend ₹1.42M.

•	Customers 16258, 16381, 12607: Frequency ~117–120, spend ~₹1.4–1.47M.

•	Customer 13789: Frequency 117 but lower spend (₹1.21M).

2. High-Spend Customers (Table 2)

•	Customer 18282: Spend ₹1.68M with frequency 114.

•	Customer 16715: Spend ₹1.63M with frequency 114.

•	Customer 16099: Spend ₹1.56M with frequency 106.

•	Customer 15661: Appears in both lists (frequency 119, spend ₹1.56M).

3. Overlap Customers

•	Customer 15661: Present in both lists → true champion (high frequency + high spend).

•	Customer 12607: High frequency (117) and strong spend (~₹1.47M).

Strategic Actions

•	For High-Frequency Customers

-	Upsell & Cross-sell, Personalized offers, Retention focus 

•	For High-Spend Customers 

-	Exclusive perks, Relationship building, Risk management- Churn 

•	For Overlap Customers (Champions)

-	Protect & reward

4.Monthly Sales Trend


<img width="400" height="337" alt="image" src="https://github.com/user-attachments/assets/0d0335f2-37b5-49c9-a8f9-6fee40bff249" />

 <img width="896" height="537" alt="image" src="https://github.com/user-attachments/assets/7763bdbe-136f-448a-9615-016920c8dffe" />

Business Insights: 

1. Overall Stability

•	Revenue stays in the ₹474M–₹532M range.

•	Order quantity is consistently around 1.0M–1.06M orders.

•	Indicates a steady demand cycle with predictable monthly performance.

2. Seasonal Peaks

•	July & October are the highest months (Revenue ~₹531M, Orders ~1.06M).

•	May also strong (~₹530M).

•	These are natural demand peaks — possibly linked to seasonal promotions, festivals, or product launches.

3. Seasonal Dips

•	February is the weakest month (Revenue ~474M, Orders ~949K).

•	June & September slightly lower (~507M, ~1.01M orders).

•	These are slow months — likely post-holiday or mid-year dips.

4. Revenue per Order Efficiency

•	Average ≈ 503–505 per order.

•	October & July slightly higher efficiency (~504–505).

•	February lowest (~499).

Strategic Actions

-For Peak Months (May, July, October) 

•	Maximize marketing spend during these months to ride natural demand.

•	Upsell premium products to increase average order value.

•	Inventory planning: ensure stock availability to avoid lost sales.

-For Low Months (February, June, September)

•	Stimulate demand with targeted promotions, discounts, or loyalty rewards.

•	Customer reactivation campaigns: personalized offers to bring back inactive buyers.

•	Cross-sell strategies: push complementary products to increase basket size.

For Overall Growth

•	Maintain consistent pricing strategy — revenue per order is stable.

•	Explore new product launches in low months to balance demand.

•	Use predictive analytics to forecast inventory and staffing needs.

5.RFM Analysis

<img width="242" height="193" alt="image" src="https://github.com/user-attachments/assets/d8a0928c-4dc6-45aa-b8b1-3b54b3abf00d" />
<img width="847" height="546" alt="image" src="https://github.com/user-attachments/assets/5fa6d921-aa0e-4b8c-a6af-90459ee240df" />
<img width="847" height="452" alt="image" src="https://github.com/user-attachments/assets/88523d2c-4fac-4fcb-addb-bf6589366132" />

Business Insights: 

1.Majority are “Others” (57.7%)

•	Most customers are average performers. They represent untapped potential.

•	This group can be nudged toward Loyalists or Champions with targeted engagement.

2. Healthy Loyalist base (16.4%)

•	Nearly 1 in 6 customers are frequent buyers.

•	Strong foundation for retention and advocacy programs.

3. Champions are small but powerful (6%)

•	These 361 customers likely drive disproportionate revenue.

•	Protect and reward them — losing even a few could hurt.

4. At Risk + Hibernating = ~20%

•	1 in 5 customers are slipping away.

•	Signals churn risk if not addressed.

5. Big Spenders are rare (0.4%)

•	Only 24 customers spend heavily.

•	They need personalized attention to increase frequency.1. 

Strategic Actions

-For Champions (361)

•	VIP programs

•	Retention focus

-For Loyalists (986)

•	Upsell & cross-sell

•	Community building

- For Others (3462)

•	Personalized nudges

•	Segmentation within “Others”

- For At Risk (596)

•	Win-back campaigns

•	Feedback loop

- For Hibernating (571)

•	Low-cost re-engagement

•	Dormant strategy

- For Big Spenders (24)

•	Concierge service

•	Frequency push

## Data Visualization & Dashboard Creation Using Power BI

1.Regional Sales Performance

A. Top 5:

Business Insights: 

1. UK Leads Strongly: The UK brings in the most sales by far, showing it's your top-performing market.

2. Others Are Similar: UAE, Iceland, Germany, and Japan all have similar, much lower sales figures.

3. Heavy Dependence on UK: Relying mostly on UK sales is risky—other regions need attention.

4. Room to Grow: The four lower-performing regions could grow with better marketing or local strategies.

5. Rethink Investment Split: Consider shifting resources—optimize UK operations and boost efforts in weaker regions.
 
<img width="940" height="404" alt="image" src="https://github.com/user-attachments/assets/18b01dc6-1d08-4a43-a579-5fcc65efaca2" />

B. Bottom 5:

1. Low Sales Range: All five countries—Switzerland, Thailand, Poland, Cyprus, and Belgium—have sales between 44M and 46M.

2. Minimal Differences: The gap between them is very small, showing similar performance levels.

3. Underperforming Zones: These regions may need fresh strategies to boost sales—like better marketing or local partnerships.

4. Potential for Growth: With focused efforts, these markets could be turned around and contribute more to overall revenue.

 <img width="856" height="424" alt="image" src="https://github.com/user-attachments/assets/2af7d436-38b4-4361-b4e2-a377bb638e82" />

Strategic Actions
1. UK is the Growth Anchor
With sales over 4300M, the UK is your core market. It deserves continued investment—but also efficiency reviews to avoid overspending.
2. Other Top Regions Need Activation
UAE, Iceland, Germany, and Japan show similar sales (~49M), far below UK. These are stable but under-leveraged markets—ideal for targeted growth campaigns.
3. Bottom 5 Regions Show Latent Potential
Switzerland, Thailand, Poland, Cyprus, and Belgium all sit just below 46M. Their performance is close to mid-tier regions, suggesting room for uplift with minimal effort.
4. Risk of Overdependence
Heavy reliance on UK sales creates vulnerability. A dip in UK performance could severely impact overall revenue—diversification is key.
5. Strategic Focus Zones
Group UAE–Japan and Switzerland–Belgium as “growth clusters.” Tailor regional strategies—like localized offers, channel expansion, or digital outreach—to unlock incremental gains.

2.Revenue Trend Analysis

A. Yearly Insights:

2009–2011 Sales: Revenue is steady but slightly declining (2009: 2082 M; 2010: 2066 M; 2011: 2051M).

<img width="889" height="181" alt="image" src="https://github.com/user-attachments/assets/10d8a486-5001-4fcb-8a05-157a33604ae0" />

Business View: Growth has plateaued; focus should shift to innovation or new markets to reverse the slow decline.

B. Quarter Insights:

• Q4 Leads: Highest sales (1567M), followed closely by Q3 (1563M).

• Q1 Lowest: At 1524M, Q1 consistently underperforms.

Business View: End-of-year (Q4) is strongest—likely due to festive or year-end demand. Q1 needs targeted campaigns to balance performance.

 <img width="940" height="189" alt="image" src="https://github.com/user-attachments/assets/b9fa750c-c21e-4560-9eec-be2f31be97dc" />

C. Month Insights:
<img width="909" height="340" alt="image" src="https://github.com/user-attachments/assets/b2755971-d310-40e9-9c9a-a048290ea25f" />

• Top Months: October, July, May, and January drive the highest sales (>527M each).

• Weakest Month: February (474M), consistently lower than others.

• Business View: Seasonal peaks in mid-year and year-end; February is a clear weak spot requiring promotional boosts.

D. Day-wise Insights:

<img width="940" height="326" alt="image" src="https://github.com/user-attachments/assets/3d45f7e2-a39f-4ec2-9a4c-1bb954d2187b" />

Top Performers:

• Tuesday & Thursday lead with the highest sales (~893M each).

• These days show strong customer activity—ideal for promotions or product launches.

Mid Performers:

• Friday & Saturday (~886M–884M) maintain solid sales, reflecting weekend buying behavior.

• Good days for campaigns tied to leisure or lifestyle spending.

Lower Performers:

• Monday, Sunday, Wednesday (~880M–882M) are slightly weaker.

• These days may need targeted offers or engagement strategies to lift performance.
 
Strategic Actions

Yearly

• Revenue is steady across years with only small declines → business is stable, low volatility.

• Focus on innovation or new markets to push growth beyond the plateau.

Quarterly

• Q2 & Q3 show natural boosts → good windows for campaigns and product launches.

• Q4 is the strongest quarter → leverage festive and year-end demand.

• Q1 is weaker → needs targeted promotions to balance performance.

Monthly

• Strong months: March, June, September, December, October, July, May, January → align launches and marketing here.

• Weak month: February → use discounts or special offers to lift sales.

• Month-end surges → plan logistics, staffing, and campaigns to capture demand spikes.

Day of Week

• Tuesday & Thursday → highest sales, ideal for marketing pushes.

• Friday & Saturday → strong weekend demand, good for lifestyle promotions.

• Monday, Sunday, Wednesday → weaker days, can be boosted with loyalty programs or special deals.

3.Product Wise Performance

A. Top 5 Product Insights:

<img width="940" height="855" alt="image" src="https://github.com/user-attachments/assets/02b4a207-7628-467c-8cd6-d2cac1b0ce1a" />

• Product 4076: Highest sales, strong demand - best performer.

• Product 1193: Most orders - very popular.

• Product 2981: Good revenue with fewer orders - likely premium.

• Product 4210: Balanced sales and orders - steady performer.

• Product 394: Most orders but lower sales - may need price adjustment.
 


B. Bottom 5 Product Insights:

<img width="871" height="906" alt="image" src="https://github.com/user-attachments/assets/50694493-9ea2-4ace-b8ac-9a595cc8a9b3" />

• Low Sales Range: All five products have sales between ₹2.4L and ₹2.75L — much lower than top performers.

• Moderate Orders: Order counts range from 656 to 940, showing some demand but not translating into strong revenue.

• Product 8034: Highest sales and orders among the bottom group → potential for improvement with better pricing or visibility.

• Product 385: Lowest sales despite decent order volume → may need a pricing review or product repositioning.

• Overall Insight: These products are underperforming in revenue. They may benefit from better marketing, bundling, or pricing strategies.
 


Strategic Actions

Top Products 

• Keep them well-stocked to avoid shortages.

• Promote best sellers (4076, 1193) in campaigns.

• Bundle popular items (394) with others to grow basket size.

• Position premium products (2981) for higher margins.

• Maintain visibility with seasonal offers and loyalty programs.

Bottom Products 

• Adjust pricing or reposition products like 385.

• Increase visibility for 8034 and 6747 to tap demand.

• Bundle weaker items with top sellers to lift sales.

Revamp or phase out consistently weak ones (6968, 9830).

• Collect customer feedback to understand underperformance.

Overall Strategic Takeaway

• Strengthen winners with inventory, promotions, and premium positioning.

• Fix or phase out laggards through pricing, visibility, bundling, or redesign.

• Balance portfolio by leveraging strong products while improving or replacing weak ones.


4. RFM Segment Customer Behavior

1. Others (58%)

• Largest segment but unclear engagement patterns.

2. Loyalists (16%)

• Reliable and consistently engaged contributors.

3. At Risk (10%)

• Previously active but showing signs of disengagement.

4. Hibernating (10%)

• Low activity and long-term disengagement.

5. Champions (6%)

• Highly engaged, top-performing individuals.

6. Big Spenders (0%)

• Very few high-impact contributors.

<img width="940" height="587" alt="image" src="https://github.com/user-attachments/assets/4e867f6d-3438-45cb-bfaf-1648fd348eed" />

Strategic Actions

• Invest in Loyalists and Champions to drive strong performance.

• Reconnect with At Risk and Hibernating groups using personalized outreach.

• Review the large Others segment to uncover untapped potential or refine segmentation.

• Create a focused recognition and retention strategy for high-value contributors.

5. Customer Segment Performance
 
 <img width="834" height="459" alt="image" src="https://github.com/user-attachments/assets/2bba8a4f-bf05-48de-9afc-7810feb4d047" />

<img width="821" height="488" alt="image" src="https://github.com/user-attachments/assets/cf8339b3-778f-4dde-a9e9-c499d5520715" />

<img width="940" height="448" alt="image" src="https://github.com/user-attachments/assets/5ba6a2bf-9b05-4272-aa20-3c5ce0889733" />
 
<img width="1278" height="151" alt="image" src="https://github.com/user-attachments/assets/89b2c359-fcbb-4ea6-9c50-d8dd500e9300" />


Segment-Wise Strategic Actions

Basic (High frequency, low value)

• Action: Introduce small-value bundles or loyalty rewards to increase basket size.

• Goal: Convert frequent buyers into higher spenders.

Standard (Mid-level buyers)

• Action: Upsell with add-ons or tiered pricing.

• Goal: Move them toward Premium behavior.

Premium (Consistent mid-tier buyers)

• Action: Offer exclusive deals or early access to products.

• Goal: Retain and nurture for long-term value.

Super Premium (High quantity, high value)

• Action: Provide personalized service, premium support, and VIP programs.

Goal: Strengthen loyalty and prevent churn.

Bulk (Highest value, fewer transactions)

• Action: Lock in with volume-based contracts or subscription models.

• Goal: Secure recurring revenue and long-term partnerships.


6. Customer Operational Optimization Report

 <img width="940" height="538" alt="image" src="https://github.com/user-attachments/assets/09dcf914-3f07-4bc3-bcc1-1f75ea2e933b" />

 <img width="951" height="276" alt="image" src="https://github.com/user-attachments/assets/f667c0f3-bd25-48a9-87c4-24bc7c082cc4" />

 <img width="905" height="294" alt="image" src="https://github.com/user-attachments/assets/90030370-2e5c-4ca9-845a-968406c7b3d3" />

 
Business Insights

Consistent Demand: All days show similar order volumes (~74K–75K), indicating stable daily engagement.

Peak Days:

• Thursday has the highest total orders (75,662) → ideal for major campaigns.

• Tuesday and Friday follow closely → good for mid-week promotions.

Time Segment Trends:

• Night has the highest overall orders (131,496) → peak engagement time.

• Afternoon, Morning, and Evening are nearly equal (~131K each) → balanced demand across the day.

Strategic Actions

Optimize Night Operations:

• Ensure staffing, inventory, and system readiness for night-time peaks.

• Schedule flash sales or push notifications during night hours.

• Target High-Volume Days:

• Launch new products or offers on Thursday, Tuesday, and Friday.

• Use these days for email campaigns and influencer drops.

 Balance Resources:

•Since demand is steady across time slots, maintain consistent service levels throughout the day.

• Avoid overloading any single shift spread logistics and support evenly.

Test Promotions on Low Days:

• Slightly lower volumes on Sunday and Wednesday, test engagement strategies or exclusive deals.


7. Revenue Forecast Analysis

A. Forecast Performance Analysis of Revenue over the Years

 <img width="905" height="333" alt="image" src="https://github.com/user-attachments/assets/f7639601-3302-4893-8cce-23f7dfd0f96d" />


Revenue Trend (2009–2011 Actuals)

• 2009: ₹2082 Cr

• 2010: ₹2066 Cr

• 2011: ₹2051 Cr

Forecast (2012–2013)

• 2012 Forecast: ₹2082 Cr (same as 2009 baseline)

• 2013 Forecast: ₹2066 Cr (same as 2010 baseline)

• Confidence Bounds: High, low, and forecast values are identical → stable but no growth expected.

Strategic Takeaways

• Stable Base: Revenue is consistent, low volatility—business is steady.

• Growth Challenge: No forecasted increase; risk of stagnation.

Action Points:

• Introduce new products/services to break the plateau.

• Strengthen marketing in weaker periods (Q1, February).

• Diversify customer segments to reduce reliance on existing patterns.

B. Forecast Analysis of Quarterly Revenue Performance

 <img width="944" height="439" alt="image" src="https://github.com/user-attachments/assets/433ac93b-c87d-44ca-9c1d-2e684ddbef8c" />

Revenue Trend (2009–2011 Actuals)

• 2009: Revenue grew steadily across quarters (Q1: ₹515M → Q4: ₹526M).

• 2010: Slight dip in Q1 (₹506M), recovery in Q3 (₹526M), ending stable in Q4 (₹520M).

• 2011: Lower Q1 (₹503M), moderate growth through Q2–Q4 (₹520M).

Forecast (2012–2014)

2012:

•Q1 forecast: ~₹499M (low bound ~492M, high bound ~506M).

• Q2–Q4 forecast: gradual rise to ~₹515–516M.

Insight: Stable growth expected after weak Q1.

2013:

• Q1 forecast: ~₹495M (low bound ~487M, high bound ~503M).

• Q2–Q4 forecast: ~₹502M–512M, showing moderate recovery.

Insight: Similar seasonal pattern, with Q3–Q4 stronger.

2014:

• Q1 forecast: ~₹492M (low bound ~483M, high bound ~501M).

• Q2 forecast: ~₹499M.

Insight: Continued stability, but Q1 remains the weakest quarter.

Strategic Takeaways

• Seasonal Weakness in Q1: Revenue consistently dips in Q1- plan promotions, product launches, or customer engagement early in the year to offset.

• Q3–Q4 Strength: Leverage natural demand peaks in late quarters for major campaigns, festive offers, and inventory pushes.

• Stable Forecast Range: Confidence bounds are narrow, showing predictable performance → low volatility but limited growth.

• Growth Lever: To break the plateau, introduce new products/services or expand into untapped customer segments during weaker quarters.

C. Monthly Forecast Analysis of Revenue Performance

 <img width="949" height="444" alt="image" src="https://github.com/user-attachments/assets/37ec917a-0b99-4a10-b09a-c3a0b1f7557d" />

Revenue Trend (2009–2011 Actuals)

Peak Months:

• January, March, May, July, October, December consistently show higher sales (₹173M–179M).

Weak Month:

• February is consistently the lowest (₹154M–160M).

Forecast (2012)

• January: ~₹172M (confidence 166M–178M) → strong start.

• February: ~₹156M (confidence 150M–162M) → weakest month, consistent with past.

• March–May: ~₹171M–174M → stable mid-year growth.

• June–August: ~₹166M–173M → moderate demand.

• September–October: ~₹167M–175M → seasonal uplift.

• November–December: ~₹170M–172M → year-end strength.

Insight: Forecast confirms seasonal peaks in Jan, Mar, May, Jul, Oct, Dec and consistent dip in Feb.

Strategic Takeaways

• Boost February: Introduce promotions, discounts, or campaigns to lift the weakest month.

• Leverage Peak Months: Align product launches and marketing pushes with Jan, Mar, May, Jul, Oct, Dec.

• Operational Planning: Ensure inventory and staffing are optimized for peak months, while balancing resources in mid-year.

• Predictable Stability: Use the narrow confidence bounds to plan budgets and supply chains with low risk.

D. Forecast Analysis of Revenue Over the Period

 <img width="1040" height="516" alt="image" src="https://github.com/user-attachments/assets/96d9f60c-3770-4402-87aa-75c2859680a8" />

Strategic Actions

• Boost Weak Quarters: Focus on Q1 with targeted campaigns, discounts, or product launches to offset dips.

• Leverage Seasonal Peaks: Align marketing pushes and inventory planning with strong months (Jan, Mar, May, Jul, Oct, Dec).

• Operational Efficiency: Use predictable patterns to optimize staffing, logistics, and supply chain.

• Growth Lever: Introduce new offerings or expand customer base during weaker months to break the plateau.

CUSTOMER BEHAVIOUR AND RETAIL SALES ANALYSIS DASHBOARD

 <img width="1055" height="819" alt="image" src="https://github.com/user-attachments/assets/49152946-90d2-4b6a-80ae-f57bc0df41ff" />

## Business Recommendation Framework

1.Regional Sales Performance

•	High-Performing Regions: Enhance distribution networks, reinforce loyalty initiatives, and emphasize premium product positioning to sustain growth.

•	Low-Performing Regions: Deploy localized promotions, refine pricing strategies, and strengthen partnerships with regional channels to stimulate demand.

•	Seasonal Outlook: Anticipate peak activity during festive periods (Oct–Dec in India, summer in Western markets) and align marketing campaigns, inventory, and customer engagement accordingly.

2.Revenue Trend Analysis

•	Boost Q1: Launch new products or aggressive promotions to offset early-year weakness.

•	Maximize Q3–Q4: Align inventory and marketing with natural demand peaks.

•	Seasonal View: Strong months are Jan, Mar, May, Jul, Oct, Dec. Weakest is February.

3.Product-Wise Performance

•	Top products: Keep them stocked, promote heavily, bundle with weaker items.

•	Bottom products: Reprice, reposition, or phase out.

•	Seasonal View: Push top products during peak months; test weaker ones during low-demand periods.

4. RFM Segment Customer Behaviour

•	Champions & Loyalists: Reward with VIP programs, personalized offers.

•	At Risk & Hibernating: Re-engage with targeted campaigns.

•	Others: Segment further to uncover hidden potential.

•	Seasonal View: Engage Champions during festive seasons; re-target At Risk customers during off-peak months.

5. Customer Segment Performance

•	Bulk: Secure contracts, subscription models.

•	Basic: Upsell with bundles and loyalty rewards.

•	Premium & Super Premium: Offer exclusivity and personalized service.

•	Seasonal View: Bulk demand peaks in festive seasons; Basic buyers can be nudged during off-peak months.

6. Customer Operational Optimization Report

•	Operations: Staff and stock more during night shifts and peak weekdays.

•	Marketing: Schedule campaigns mid-week and at night for maximum impact.

•	Seasonal View: Align logistics with Q3–Q4 demand surges.

7. Revenue Forecast Analysis

•	Strategic Planning: Use forecasts to plan budgets and supply chains with confidence.

•	Growth Strategy: Introduce new products or expand customer base to break plateau.

•	Seasonal View: Plan inventory for Jan, Mar, May, Jul, Oct, Dec peaks; offset Feb dip with promotions.

## Overall Improvements & Marketing Strategies

•	Seasonal Campaigns: Align promotions with strong months and festive seasons.

•	Customer-Centric Marketing: Personalize offers for Champions, Loyalists, and Premium segments.

•	Product Bundling: Pair top sellers with weaker products to lift overall sales.

•	Operational Efficiency: Optimize staffing and logistics for night-time and mid-week peaks.

•	Innovation Push: Launch new products/services in weak months (Feb, Q1) to stimulate demand.

•	Retention Programs: Loyalty rewards, VIP clubs, and subscription models for high-value customers.

