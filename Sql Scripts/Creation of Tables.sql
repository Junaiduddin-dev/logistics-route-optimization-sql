CREATE TABLE Orders (
  Order_ID VARCHAR(10) PRIMARY KEY,
  Customer_ID VARCHAR(10),
  Warehouse_ID VARCHAR(10),
  Route_ID VARCHAR(10),
  Order_Date DATE,
  Expected_Delivery_Date DATE,
  Actual_Delivery_Date DATE,
  Delivery_Status VARCHAR(20)
);

CREATE TABLE Routes (
  Route_ID VARCHAR(10) PRIMARY KEY,
  Start_Location VARCHAR(100),
  End_Location VARCHAR(100),
  Distance_KM FLOAT,
  Average_Travel_Time_Min INT,
  Traffic_Delay_Min INT
);

CREATE TABLE Warehouses (
  Warehouse_ID VARCHAR(10) PRIMARY KEY,
  Location VARCHAR(100),
  Processing_Time_Min INT,
  Dispatch_Time TIME
);

CREATE TABLE DeliveryAgents (
  Agent_ID VARCHAR(10) PRIMARY KEY,
  Route_ID VARCHAR(10),
  Shift_Hours INT,
  Avg_Speed_KM_HR INT,
  On_Time_Percentage FLOAT
);

CREATE TABLE ShipmentTracking (
  Shipment_ID VARCHAR(10) PRIMARY KEY,
  Order_ID VARCHAR(10),
  Checkpoint VARCHAR(50),
  Checkpoint_Time DATE,
  Delay_Reason VARCHAR(100)
);
