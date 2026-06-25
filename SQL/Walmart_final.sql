use nancy
go
select*
from Walmart

--HOLIDAY VS NON-HOLIDAY AVERAGE SALES
select Holiday_flag,
Avg(weekly_sales) as
Avg_weekly_sales
FROM Walmart
group by holiday_flag

--STORE RANKING
SELECT Store,
SUM(Weekly_Sales) AS Total_Sales
FROM Walmart
GROUP BY Store

-- Top 5 Stores
WITH StoreSales AS (
SELECT Store,
SUM(Weekly_Sales) AS Total_Sales,
RANK() OVER (
ORDER BY SUM (Weekly_Sales)
desc ) As Sales_Rank
From Walmart
GROUP BY Store )
select *
FROM StoreSales
WHERE Sales_Rank <= 5

--BOTTOM 5 STORES
WITH StoreSales AS (
SELECT Store,
SUM(Weekly_Sales) AS Total_Sales,
RANK() OVER (
ORDER BY SUM (Weekly_Sales)
Asc ) As Sales_Rank
From Walmart
GROUP BY Store )
select *
FROM StoreSales
WHERE Sales_Rank <= 5

--MONTH-OVER-MONTH SALES GROWTH 
--Convert weekly data into monthly sales
WITH MonthlySales As (
SELECT YEAR(DATE) AS Sales_Year,
Month(Date) As Sales_Month,
SUM(Weekly_Sales) As Monthly_Sales
FROM Walmart
GROUP BY YEAR(Date),
Month(Date) )
SELECT *
FROM MonthlySales

--Using lag
WITH MonthlySales As (
SELECT YEAR(DATE) AS Sales_Year,
Month(Date) As Sales_Month,
SUM(Weekly_Sales) As Monthly_Sales
FROM Walmart
GROUP BY YEAR(Date),
Month(Date) )
SELECT 
Sales_Year,
Sales_Month,
Monthly_Sales,
LAG(Monthly_Sales) OVER (
ORDER BY Sales_Year, Sales_Month )
AS Previous_Month_Sales,
ROUND( (Monthly_Sales -
LAG(Monthly_Sales) OVER(
ORDER BY Sales_Year, Sales_Month ) ) /
LAG(Monthly_Sales) OVER (
ORDER BY Sales_Year, Sales_Month ) * 100, 2 )
AS Growth_Percent
FROM MonthlySales





