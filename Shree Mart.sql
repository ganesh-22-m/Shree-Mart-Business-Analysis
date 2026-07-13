
-- Project : Shree Mart
-- Module  : SQL Database
-- Author  : Ganesh Mahajan
-- 

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Mobile VARCHAR(15),
    Password VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    Pincode VARCHAR(10)
);

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(100) NOT NULL,
    Brand VARCHAR(100),
    Category_ID INT,
    Price DECIMAL(10,2),
    Stock INT,
    Unit VARCHAR(20),
    FOREIGN KEY (Category_ID)
    REFERENCES Category(Category_ID)
); 

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    Payment_Mode VARCHAR(30),
    Order_Status VARCHAR(30),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10,2),

    FOREIGN KEY (Order_ID)
    REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
);

INSERT INTO Customer
(Full_Name, Email, Mobile, Password, Address, City, Pincode)
VALUES
('Rahul Sharma','rahul@gmail.com','9876543210','rahul123','Baner','Pune','411045'),
('Priya Patil','priya@gmail.com','9876543211','priya123','Kothrud','Pune','411038'),
('Amit Joshi','amit@gmail.com','9876543212','amit123','Nashik Road','Nashik','422001'),
('Sneha Kulkarni','sneha@gmail.com','9876543213','sneha123','Satpur','Nashik','422007'),
('Rohit Deshmukh','rohit@gmail.com','9876543214','rohit123','Shivaji Nagar','Pune','411005');

INSERT INTO Category
(Category_Name, Description)
VALUES
('Fruits','Fresh Fruits'),
('Vegetables','Fresh Vegetables'),
('Dairy','Milk Products'),
('Snacks','Packed Snacks'),
('Beverages','Cold Drinks');

SELECT * FROM Customer;

SELECT * FROM Category;

INSERT INTO Product
(Product_Name, Category_ID, Price, Stock, Unit)
VALUES
('Apple',1,180,100,'Kg'),
('Banana',1,60,200,'Dozen'),
('Tomato',2,40,150,'Kg'),
('Potato',2,30,300,'Kg'),
('Milk',3,65,120,'Liter'),
('Cheese',3,250,80,'Pack'),
('Chips',4,20,500,'Pack'),
('Biscuits',4,30,400,'Pack'),
('Coca Cola',5,40,250,'Bottle'),
('Pepsi',5,40,250,'Bottle');
SELECT * FROM Product;

INSERT INTO Orders
(Customer_ID, Order_Date, Total_Amount, Payment_Mode, Order_Status)
VALUES
(1,'2026-07-01',240,'UPI','Delivered'),
(2,'2026-07-02',150,'Cash','Delivered'),
(3,'2026-07-03',320,'Card','Processing'),
(4,'2026-07-04',180,'UPI','Delivered'),
(5,'2026-07-05',450,'Card','Pending');

SELECT * FROM Orders;

INSERT INTO Order_Details
(Order_ID, Product_ID, Quantity, Price)
VALUES
(1,1,2,180),
(1,7,3,20),

(2,3,5,40),
(2,8,2,30),

(3,6,1,250),
(3,10,2,40),

(4,5,2,65),
(4,2,1,60),

(5,1,1,180),
(5,9,3,40);

SELECT * FROM Order_Details;

SELECT
C.Full_Name,
O.Order_ID,
O.Order_Date,
O.Total_Amount,
O.Order_Status
FROM Customer C
INNER JOIN Orders O
ON C.Customer_ID = O.Customer_ID;

SELECT
O.Order_ID,
P.Product_Name,
OD.Quantity,
OD.Price
FROM Order_Details OD
INNER JOIN Orders O
ON OD.Order_ID = O.Order_ID
INNER JOIN Product P
ON OD.Product_ID = P.Product_ID;

SELECT
C.Full_Name,
P.Product_Name,
OD.Quantity,
OD.Price,
O.Order_Date,
O.Payment_Mode,
O.Order_Status
FROM Customer C
INNER JOIN Orders O
ON C.Customer_ID = O.Customer_ID
INNER JOIN Order_Details OD
ON O.Order_ID = OD.Order_ID
INNER JOIN Product P
ON OD.Product_ID = P.Product_ID;

SELECT
SUM(Total_Amount) AS Total_Revenue
FROM Orders;

SELECT
AVG(Total_Amount) AS Average_Order_Value
FROM Orders;

SELECT
MAX(Total_Amount) AS Highest_Order
FROM Orders;

SELECT
COUNT(*) AS Total_Orders
FROM Orders;

SELECT
C.Category_Name,
COUNT(P.Product_ID) AS Total_Products
FROM Category C
INNER JOIN Product P
ON C.Category_ID = P.Category_ID
GROUP BY C.Category_Name;
