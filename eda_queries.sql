CREATE TABLE retail_sales (
    Invoice_ID INTEGER,
    Invoice_Date TEXT,
    Invoice_Time TEXT,
    City TEXT,
    Store_Format TEXT,
    Category TEXT,
    Brand TEXT,
    Channel TEXT,
    Payment_Mode TEXT,
    Units INTEGER,
    Cost_Price REAL,
    Selling_Price REAL,
    Revenue REAL,
    Cost REAL,
    Margin REAL,
    Margin_Percent REAL,
    Stock_On_Hand INTEGER,
    Reorder_Level INTEGER,
    Lead_Time_Days INTEGER,
    Customer_Age INTEGER,
    Customer_Gender TEXT,
    Loyalty_Flag INTEGER
);

-- Query 1: High-Level summary
-- =========================================================================
SELECT
    COUNT(*) as Total_Records,
    COUNT(DISTINCT Invoice_ID) as Unique_Invoices,
    COUNT(DISTINCT City) as Unique_Cities,
    COUNT(DISTINCT Category) as Unique_Categories,
    COUNT(DISTINCT Brand) as Unique_Brands,
    COUNT(DISTINCT Store_Format) as Unique_Store_Formats,
    COUNT(DISTINCT Channel) as Unique_Channels,
    COUNT(DISTINCT Payment_Mode) as Unique_Payment_Modes
FROM retail_sales;


-- Query 2: Descriptive Stats
-- =========================================================================
SELECT
    'Units' as Column_Name, MIN(Units) as Min_Val, MAX(Units) as Max_Val, AVG(Units) as Avg_Val FROM retail_sales
UNION ALL
SELECT
    'Cost_Price', MIN(Cost_Price), MAX(Cost_Price), AVG(Cost_Price) FROM retail_sales
UNION ALL
SELECT
    'Selling_Price', MIN(Selling_Price), MAX(Selling_Price), AVG(Selling_Price) FROM retail_sales
UNION ALL
SELECT
    'Revenue', MIN(Revenue), MAX(Revenue), AVG(Revenue) FROM retail_sales
UNION ALL
SELECT
    'Cost', MIN(Cost), MAX(Cost), AVG(Cost) FROM retail_sales
UNION ALL
SELECT
    'Margin', MIN(Margin), MAX(Margin), AVG(Margin) FROM retail_sales
UNION ALL
SELECT
    'Margin_Percent', MIN(Margin_Percent)*100, MAX(Margin_Percent)*100, AVG(Margin_Percent)*100 FROM retail_sales
UNION ALL
SELECT
    'Stock_On_Hand', MIN(Stock_On_Hand), MAX(Stock_On_Hand), AVG(Stock_On_Hand) FROM retail_sales
UNION ALL
SELECT
    'Reorder_Level', MIN(Reorder_Level), MAX(Reorder_Level), AVG(Reorder_Level) FROM retail_sales
UNION ALL
SELECT
    'Lead_Time_Days', MIN(Lead_Time_Days), MAX(Lead_Time_Days), AVG(Lead_Time_Days) FROM retail_sales
UNION ALL
SELECT
    'Customer_Age', MIN(Customer_Age), MAX(Customer_Age), AVG(Customer_Age) FROM retail_sales WHERE Customer_Age IS NOT NULL;


-- Query 3: Monthly Sales Trends
-- =========================================================================
SELECT
    CASE substr(Invoice_Date, 4, 2)
        WHEN '01' THEN '01 - January'
        WHEN '02' THEN '02 - February'
        WHEN '03' THEN '03 - March'
        WHEN '04' THEN '04 - April'
        WHEN '05' THEN '05 - May'
        WHEN '06' THEN '06 - June'
        WHEN '07' THEN '07 - July'
        WHEN '08' THEN '08 - August'
        WHEN '09' THEN '09 - September'
        WHEN '10' THEN '10 - October'
        WHEN '11' THEN '11 - November'
        WHEN '12' THEN '12 - December'
        ELSE 'Unknown'
    END as Month_Name,
    COUNT(*) as Transaction_Count,
    SUM(Units) as Total_Units_Sold,
    SUM(Revenue) as Total_Revenue,
    SUM(Margin) as Total_Profit,
    AVG(Margin_Percent)*100 as Avg_Margin_Percent
FROM retail_sales
GROUP BY substr(Invoice_Date, 4, 2)
ORDER BY substr(Invoice_Date, 4, 2);


-- Query 4: Category Performance
-- =========================================================================
SELECT
    Category,
    COUNT(*) as Transactions,
    SUM(Units) as Total_Units_Sold,
    SUM(Revenue) as Total_Revenue,
    SUM(Margin) as Total_Profit,
    AVG(Margin_Percent)*100 as Avg_Margin_Percent
FROM retail_sales
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- Query 5: Brand Performance (Top 10)
-- =========================================================================
SELECT
    Brand,
    COUNT(*) as Transactions,
    SUM(Units) as Total_Units,
    SUM(Revenue) as Total_Revenue,
    SUM(Margin) as Total_Profit,
    AVG(Margin_Percent)*100 as Avg_Margin_Percent
FROM retail_sales
GROUP BY Brand
ORDER BY Total_Revenue DESC
LIMIT 10;


-- Query 6: City Performance
-- =========================================================================
SELECT
    City,
    COUNT(*) as Transactions,
    SUM(Revenue) as Total_Revenue,
    SUM(Margin) as Total_Profit,
    AVG(Margin_Percent)*100 as Avg_Margin_Percent
FROM retail_sales
GROUP BY City
ORDER BY Total_Revenue DESC;


-- Query 7: Store Format and Channel Performance
-- =========================================================================
SELECT
    Store_Format,
    Channel,
    COUNT(*) as Transactions,
    SUM(Revenue) as Total_Revenue,
    AVG(Margin_Percent)*100 as Avg_Margin_Percent
FROM retail_sales
GROUP BY Store_Format, Channel
ORDER BY Store_Format, Total_Revenue DESC;


-- Query 8: Age Group Analysis
-- =========================================================================
SELECT
    CASE
        WHEN Customer_Age IS NULL THEN 'Unknown'
        WHEN Customer_Age < 20 THEN 'Under 20'
        WHEN Customer_Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Customer_Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Customer_Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Customer_Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Customer_Age >= 60 THEN '60+'
    END as Age_Group,
    COUNT(*) as Transaction_Count,
    SUM(Revenue) as Total_Revenue,
    AVG(Revenue) as Avg_Spend_Per_Tx
FROM retail_sales
GROUP BY Age_Group
ORDER BY
    CASE
        WHEN Customer_Age IS NULL THEN 7
        WHEN Customer_Age < 20 THEN 1
        WHEN Customer_Age BETWEEN 20 AND 29 THEN 2
        WHEN Customer_Age BETWEEN 30 AND 39 THEN 3
        WHEN Customer_Age BETWEEN 40 AND 49 THEN 4
        WHEN Customer_Age BETWEEN 50 AND 59 THEN 5
        WHEN Customer_Age >= 60 THEN 6
    END;


-- Query 9: Gender representation
-- =========================================================================
SELECT
    COALESCE(Customer_Gender, 'Unknown') as Gender,
    COUNT(*) as Transaction_Count,
    SUM(Revenue) as Total_Revenue,
    AVG(Revenue) as Avg_Spend_Per_Tx
FROM retail_sales
GROUP BY Gender
ORDER BY Transaction_Count DESC;


-- Query 10: Loyalty analysis
-- =========================================================================
SELECT
    CASE Loyalty_Flag
        WHEN 1 THEN 'Loyal Customer (Flag=1)'
        WHEN 0 THEN 'Regular Customer (Flag=0)'
        ELSE 'Unknown'
    END as Loyalty_Status,
    COUNT(*) as Transaction_Count,
    SUM(Units) as Total_Units_Purchased,
    SUM(Revenue) as Total_Revenue,
    AVG(Revenue) as Avg_Spend_Per_Tx,
    AVG(Units) as Avg_Units_Per_Tx
FROM retail_sales
GROUP BY Loyalty_Flag;


-- Query 11: Inventory Insights
-- =========================================================================
SELECT
    Category,
    AVG(Stock_On_Hand) as Avg_Stock_On_Hand,
    AVG(Reorder_Level) as Avg_Reorder_Level,
    AVG(Lead_Time_Days) as Avg_Lead_Time_Days,
    SUM(CASE WHEN Stock_On_Hand <= Reorder_Level THEN 1 ELSE 0 END) as In_Stock_Deficit_Occurrences
FROM retail_sales
GROUP BY Category
ORDER BY Avg_Stock_On_Hand DESC;
