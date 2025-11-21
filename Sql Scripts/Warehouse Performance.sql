-- 1. the top 3 warehouses with the highest average processing time:
SELECT Warehouse_ID,
       AVG(Processing_Time_Min) AS Avg_Processing_Time
FROM Warehouses
GROUP BY Warehouse_ID
ORDER BY Avg_Processing_Time DESC
LIMIT 3;

-- 2.  total vs. delayed shipments for each warehouse:
SELECT w.Warehouse_ID,
       COUNT(o.Order_ID) AS Total_Shipments,
       SUM(CASE WHEN o.Delivery_Status = 'Delayed' THEN 1 ELSE 0 END) AS Delayed_Shipments
FROM Warehouses w
LEFT JOIN Orders o ON w.Warehouse_ID = o.Warehouse_ID
GROUP BY w.Warehouse_ID;

-- 3.  CTEs to find bottleneck warehouses where processing time > global average:
WITH AvgTime AS (
    SELECT AVG(Processing_Time_Min) AS Global_Avg
    FROM Warehouses
)
SELECT w.Warehouse_ID,
       w.Processing_Time_Min
FROM Warehouses w, AvgTime
WHERE w.Processing_Time_Min > AvgTime.Global_Avg;
 
-- 4. Rank warehouses based on on-time delivery percentage:
SELECT o.Warehouse_ID,
       ROUND(SUM(CASE WHEN o.Delivery_Status = 'On Time' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS OnTime_Percentage,
       RANK() OVER (ORDER BY ROUND(SUM(CASE WHEN o.Delivery_Status = 'On Time' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) DESC) AS Delivery_Rank
FROM Orders o
GROUP BY o.Warehouse_ID;
