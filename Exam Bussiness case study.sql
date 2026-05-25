CREATE DATABASE RetailDB;
USE RetailDB;

CREATE TABLE RetailTransactions (
    TransactionID INT PRIMARY KEY,
    Date DATE,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Region VARCHAR(20),
    SalesChannel VARCHAR(20),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    PaymentMode VARCHAR(30),
    CustomerID INT
);

INSERT INTO RetailTransactions
(TransactionID, Date, ProductName, Category, Region, SalesChannel, Quantity, UnitPrice, TotalAmount, PaymentMode, CustomerID)
VALUES
(1001, '2025-01-05', 'Laptop', 'Electronics', 'East', 'Online', 2, 55000.00, 110000.00, 'Credit Card', 501),

(1002, '2025-01-06', 'Mobile Phone', 'Electronics', 'West', 'Offline', 3, 20000.00, 60000.00, 'UPI', 502),

(1003, '2025-01-07', 'T-Shirt', 'Fashion', 'North', 'Online', 5, 800.00, 4000.00, 'Cash', 503),

(1004, '2025-01-08', 'Refrigerator', 'Home Appliances', 'South', 'Offline', 1, 30000.00, 30000.00, 'Net Banking', 504),

(1005, '2025-01-09', 'Shoes', 'Fashion', 'East', 'Online', 4, 2500.00, 10000.00, 'UPI', 505),

(1006, '2025-01-10', 'Tablet', 'Electronics', 'West', 'Offline', 2, 15000.00, 30000.00, 'Credit Card', 506),

(1007, '2025-01-11', 'Washing Machine', 'Home Appliances', 'North', 'Online', 1, 25000.00, 25000.00, 'Net Banking', 507),

(1008, '2025-01-12', 'Headphones', 'Electronics', 'South', 'Online', 6, 1500.00, 9000.00, 'Cash', 508),

(1009, '2025-01-13', 'Jeans', 'Fashion', 'East', 'Offline', 3, 1800.00, 5400.00, 'UPI', 509),

(1010, '2025-01-14', 'Microwave', 'Home Appliances', 'West', 'Online', 2, 12000.00, 24000.00, 'Credit Card', 510),

(1011, '2025-02-01', 'Laptop', 'Electronics', 'North', 'Offline', 1, 56000.00, 56000.00, 'Net Banking', 511),

(1012, '2025-02-02', 'Mobile Phone', 'Electronics', 'South', 'Online', 4, 22000.00, 88000.00, 'Credit Card', 512),

(1013, '2025-02-03', 'T-Shirt', 'Fashion', 'East', 'Offline', 8, 700.00, 5600.00, 'Cash', 513),

(1014, '2025-02-04', 'Shoes', 'Fashion', 'West', 'Online', 5, 2600.00, 13000.00, 'UPI', 514),

(1015, '2025-02-05', 'Air Conditioner', 'Home Appliances', 'North', 'Offline', 1, 40000.00, 40000.00, 'Net Banking', 515),

(1016, '2025-02-06', 'Tablet', 'Electronics', 'South', 'Online', 2, 16000.00, 32000.00, 'Credit Card', 516),

(1017, '2025-02-07', 'Headphones', 'Electronics', 'East', 'Offline', 7, 1700.00, 11900.00, 'UPI', 517),

(1018, '2025-02-08', 'Jeans', 'Fashion', 'West', 'Online', 4, 2000.00, 8000.00, 'Cash', 518),

(1019, '2025-02-09', 'Microwave', 'Home Appliances', 'North', 'Offline', 2, 11000.00, 22000.00, 'Credit Card', 519),

(1020, '2025-02-10', 'Smart Watch', 'Electronics', 'South', 'Online', 3, 5000.00, 15000.00, 'UPI', 520);

select * from RetailTransactions ;

-- 1. Total Sales Amount Per Region for Last Quarter --
SELECT 
    Region,
    SUM(TotalAmount) AS TotalSales
FROM RetailTransactions
WHERE QUARTER(Date) = QUARTER(CURDATE()) - 1
GROUP BY Region;

-- 2. Top 5 Best-Selling Products (By Revenue) --

SELECT 
    ProductName,
    SUM(TotalAmount) AS Revenue
FROM RetailTransactions
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 5;

-- 3. Monthly Sales Trend Across All Regions --

SELECT 
    MONTH(Date) AS Month,
    SUM(TotalAmount) AS MonthlySales
FROM RetailTransactions
GROUP BY MONTH(Date)
ORDER BY Month;

-- 4. Region-wise Contribution to Total Sales (%) --

SELECT 
    Region,
    ROUND(
        SUM(TotalAmount) * 100 /
        (SELECT SUM(TotalAmount) FROM RetailTransactions),
        2
    ) AS ContributionPercentage
FROM RetailTransactions
GROUP BY Region;

-- 5. Compare Online vs Offline Sales Across Months --

SELECT 
    MONTH(Date) AS Month,
    SalesChannel,
    SUM(TotalAmount) AS Sales
FROM RetailTransactions
GROUP BY MONTH(Date), SalesChannel
ORDER BY Month;

-- 6. Sales Trend by Category --

SELECT 
    MONTH(Date) AS Month,
    Category,
    SUM(TotalAmount) AS Sales
FROM RetailTransactions
GROUP BY MONTH(Date), Category
ORDER BY Month;

-- 7. Customers Who Purchased More Than 10 Times --

SELECT 
    CustomerID,
    COUNT(TransactionID) AS TotalPurchases
FROM RetailTransactions
GROUP BY CustomerID
HAVING COUNT(TransactionID) > 10;

CREATE TABLE RegionSales AS
SELECT 
    Region,
    SUM(TotalAmount) AS TotalSales
FROM RetailTransactions
GROUP BY Region;

select * from RegionSales;

CREATE TABLE TopProducts AS
SELECT 
    ProductName,
    SUM(TotalAmount) AS Revenue
FROM RetailTransactions
GROUP BY ProductName
ORDER BY Revenue DESC
LIMIT 5;

select * from TopProducts;

CREATE TABLE MonthlySales AS
SELECT 
    MONTH(Date) AS Month,
    SUM(TotalAmount) AS Sales
FROM RetailTransactions
GROUP BY MONTH(Date);

select * from MonthlySales;

