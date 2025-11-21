-- 1. Rank agents (per route) by on-time delivery percentage: 
SELECT
  da.Agent_ID,
  da.Route_ID,
  da.On_Time_Percentage,
  RANK() OVER (
    PARTITION BY da.Route_ID
    ORDER BY da.On_Time_Percentage DESC
  ) AS Agent_Rank
FROM DeliveryAgents da;

-- 2. Find agents with on-time % less than 80%:
SELECT Agent_ID,
       On_Time_Percentage
FROM DeliveryAgents
WHERE On_Time_Percentage < 80;

-- 3. Compare average speed of top 5 vs bottom 5 agents using subqueries:
-- Top 5 agents by average speed
SELECT AVG(Avg_Speed_KM_HR) AS Top5_AvgSpeed
FROM (
  SELECT Avg_Speed_KM_HR
  FROM DeliveryAgents
  ORDER BY Avg_Speed_KM_HR DESC
  LIMIT 5
) AS TopAgents;

-- Bottom 5 agents by average speed
SELECT AVG(Avg_Speed_KM_HR) AS Bottom5_AvgSpeed
FROM (
  SELECT Avg_Speed_KM_HR
  FROM DeliveryAgents
  ORDER BY Avg_Speed_KM_HR ASC
  LIMIT 5
) AS BottomAgents;
