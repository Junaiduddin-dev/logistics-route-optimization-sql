-- 1. For each order, list the last checkpoint and time:
SELECT
  Order_ID,
  MAX(Checkpoint) AS Last_Checkpoint,
  MAX(Checkpoint_Time) AS Last_Checkpoint_Time
FROM ShipmentTracking
GROUP BY Order_ID;

-- 2.  the most common delay reasons (excluding 'None'):
SELECT Delay_Reason,
       COUNT(*) AS Occurrences
FROM ShipmentTracking
WHERE Delay_Reason != 'None'
GROUP BY Delay_Reason
ORDER BY Occurrences DESC;

-- 3.orders with more than 2 delayed checkpoints (delay reason NOT 'None'):
SELECT Order_ID,
       COUNT(*) AS Delayed_Checkpoints
FROM ShipmentTracking
WHERE Delay_Reason != 'None'
GROUP BY Order_ID
HAVING Delayed_Checkpoints > 2;

