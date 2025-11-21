-- 1.Find duplicate:
SELECT Order_ID, COUNT(*) AS cnt
FROM Orders
GROUP BY Order_ID
HAVING cnt > 1;
-- 1.1 remove Duplicates:
DELETE o1
FROM Orders o1
JOIN Orders o2
  ON o1.Order_ID = o2.Order_ID
 AND o1.id > o2.id;

-- 2 Replace null Traffic_Delay_Min with average delay for that route:
UPDATE Routes
SET Traffic_Delay_Min = (
  SELECT AVG(Traffic_Delay_Min)
  FROM Routes AS r2
  WHERE r2.Route_ID = Routes.Route_ID
)
WHERE Traffic_Delay_Min IS NULL;

-- 3 Convert all date columns into YYYY-MM-DD format:
SELECT DATE_FORMAT(Order_Date, '%Y-%m-%d') AS Order_Date,
       DATE_FORMAT(Expected_Delivery_Date, '%Y-%m-%d') AS Expected_Delivery_Date,
       DATE_FORMAT(Actual_Delivery_Date, '%Y-%m-%d') AS Actual_Delivery_Date
FROM Orders;

-- 4 Flag any actual delivery dates before order dates:
SELECT Order_ID, Order_Date, Actual_Delivery_Date
FROM Orders
WHERE Actual_Delivery_Date < Order_Date;
