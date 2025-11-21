-- 1.For each route, calculate: Average delivery time (in days) / average traffic delay / Distance-to-time efficiency ratio
SELECT 
    r.Route_ID,
    AVG(DATEDIFF(o.Actual_Delivery_Date, o.Order_Date)) AS Avg_Delivery_Days,
    AVG(r.Traffic_Delay_Min) AS Avg_Traffic_Delay_Min,
    (r.Distance_KM / r.Average_Travel_Time_Min) AS Efficiency_Ratio
FROM Routes r
LEFT JOIN Orders o 
    ON r.Route_ID = o.Route_ID
GROUP BY r.Route_ID;

-- 2. Identify 3 routes with the worst efficiency ratio:
SELECT Route_ID,
       Distance_KM / Average_Travel_Time_Min AS Efficiency_Ratio
FROM Routes
ORDER BY Efficiency_Ratio ASC
LIMIT 3;

-- 3. Find routes with over 20% delayed shipments:
SELECT o.Route_ID,
       COUNT(*) AS Total_Shipments,
       SUM(CASE WHEN o.Delivery_Status='Delayed' THEN 1 ELSE 0 END)/COUNT(*)*100 AS Delayed_Percentage
FROM Orders o
GROUP BY o.Route_ID
HAVING Delayed_Percentage > 20;

-- 4 Recommend potential routes for optimization
SELECT
    Route_ID,
    Distance_KM,
    Average_Travel_Time_Min,
    Traffic_Delay_Min
FROM
    routes
WHERE
    Average_Travel_Time_Min > (SELECT AVG(Average_Travel_Time_Min) FROM routes)
    OR Traffic_Delay_Min > (SELECT AVG(Traffic_Delay_Min) FROM routes)
ORDER BY
    Average_Travel_Time_Min DESC,
    Traffic_Delay_Min DESC;



