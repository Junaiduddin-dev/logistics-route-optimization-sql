-- 1: Delivery Delay (in days) for Each Order
SELECT Order_ID,
       Order_Date,
       Expected_Delivery_Date,
       Actual_Delivery_Date,
       DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delivery_Delay_Days
FROM Orders;

-- 2: Top 10 Delayed Routes Based on Average Delay Days
SELECT o.Route_ID,
       AVG(DATEDIFF(o.Actual_Delivery_Date, o.Expected_Delivery_Date)) AS Avg_Delay_Days
FROM Orders o
GROUP BY o.Route_ID
ORDER BY Avg_Delay_Days DESC
LIMIT 10;

-- 3: Rank All Orders by Delay Within Each Warehouse
SELECT
    Order_ID,
    Warehouse_ID,
    DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delivery_Delay_Days,
    RANK() OVER (
        PARTITION BY Warehouse_ID
        ORDER BY DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) DESC
    ) AS Delay_Rank
FROM Orders;
