create database if not exists manufacturerdb;
use manufacturerdb;

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;


INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);
Drop table manufacturers, products;


-- 1.1 Select the names of all the products in the store.
select Name from Products;

-- 1.2 Select the names and the prices of all the products in the store.
Select Name, Price from Products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
Select name, price from products where price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
Select name, price from products where price between 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
Select name, price * 100 as Price_in_Cents from products; 
Select * from products;

-- 1.6 Compute the average price of all the products.
Select avg(price) as Average_of_Products from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
Select avg(price) from products where code = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
Select count(*) from products where price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
Select name, price from products where price >= 180 order by price desc;
Select name, price from products where price >= 180 order by name asc;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
Select p.code, p.name, p.price, p.manufacturer, m.name as Manufacturerboss
from products p join manufacturers m
on m.Code = p.manufacturer;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
Select p.name as Product_Name, p.price as Product_Price, m.name as Manufacturer_Name
from manufacturers m join products p
on m.code = p.manufacturer;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
Select manufacturer, avg(price) as Avg_Price
from products
Group by Manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
Select name as Manufacturers_Name, avg(price) as Avg_Price
from Products
Group by name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
Select Manufacturers.Name from Manufacturers 
right join products 
on Manufacturers.code = Products.manufacturer
Group by Manufacturers.name
Having avg(products.price) >= 150;

-- 1.15 Select the name and price of the cheapest product.
Select name, price from products order by price asc limit 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
Select m.name as Manufacturer_Name, p.name as Product_Name, p.price from Manufacturers m
right join Products p 
on m.code = p.manufacturer
order by price desc limit 1;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
Insert into products(Code,Name,Price,Manufacturer) Values(11,"Loudspeakers",70,2);

-- 1.18 Update the name of product 8 to "Laser Printer".
Update products set Name="Laser Printer" where Code=8;

-- 1.19 Apply a 10% discount to all products.
Select Name, Price, (Price - (Price * 0.1)) as Discount_Price from Products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
Select Name, Price, (Price - (Price * 0.1)) as Discount_Price from Products where price >= 120;











