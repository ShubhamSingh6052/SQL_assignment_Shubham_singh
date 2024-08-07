Create Schema warehouse2;
Use warehouse2;

CREATE TABLE Warehouses (
   Code INTEGER NOT NULL,
   Location VARCHAR(255) NOT NULL ,
   Capacity INTEGER NOT NULL,
   PRIMARY KEY (Code)
 );
CREATE TABLE Boxes (
    Code CHAR(4) NOT NULL,
    Contents VARCHAR(255) NOT NULL ,
    Value REAL NOT NULL ,
    Warehouse INTEGER NOT NULL,
    PRIMARY KEY (Code),
    FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
 ) ENGINE=INNODB;
 
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);
  
-- 3.1 Select all warehouses.
Select * from warehouses;
  
-- 3.2 Select all boxes with a value larger than $150.
Select * from boxes where value > 150;
  
-- 3.3 Select all distinct contents in all the boxes.
Select distinct contents from boxes;
  
-- 3.4 Select the average value of all the boxes.
Select avg(Value) as Average_Value from Boxes;
  
-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
Select Warehouses.code as Warehouse_Code, avg(value) as Average_Value from Boxes join Warehouses
on warehouses.code = Boxes.warehouse
Group by Warehouses.code
having avg(value);
  
-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
Select Warehouses.code as Warehouse_Code, avg(value) as Average_Value from Boxes join Warehouses
on warehouses.code = Boxes.warehouse
Group by Warehouses.code
having avg(value) > 150;

-- 3.7 Select the code of each box, along with the name of the city the box is located in. 
Select Boxes.Code as Box_Code, Warehouses.Location as City_Name from warehouses join 
Boxes on warehouses.code = Boxes.warehouse;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
SELECT W.Code AS WarehouseCode, COUNT(B.Code) AS NumberOfBoxes
FROM Warehouses W JOIN Boxes B ON W.Code = B.Warehouse
GROUP BY W.Code;

-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
Select W.Code from Warehouses W Join Boxes B
on W.code = B.warehouse
Group by W.Code, W.Capacity
Having count(B.Code) > W.Capacity;

-- 3.10 Select the codes of all the boxes located in Chicago.
Select Code, Warehouse from Boxes where Warehouse = 1;

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
Insert into Warehouses(Code,Location,Capacity) Values(6,'New York',3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
Insert into Boxes(Code,Contents,Value,Warehouse) Values("H5RT","Papers","200","2");
  
-- 3.13 Reduce the value of all boxes by 15%.
Select Code,Contents,Warehouse,Value,(Value - (Value * 0.15)) as Discount_Value from Boxes;

-- 3.14 Remove all boxes with a value lower than $100.
Delete from boxes where Value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
Delete from Boxes where warehouse in (select * from(select Code from Warehouses where Capacity < (select count(*) from Boxes where warehouse = warehouses.code))as delete_box);

-- 3.16 Add Index for column "Warehouse" in table "boxes"
Create Index idx_warehouse on Boxes(Warehouse);

-- 3.17 Print all the existing indexes
Show index from boxes;

-- 3.18 Remove (drop) the index you added just
Drop index idx_warehouse on boxes;