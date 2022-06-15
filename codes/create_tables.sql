
--CREATE DATABASE northwind;
-- \c northwind

-- create tables

-- regions
CREATE TABLE regions(regionID INT,regionDescription VARCHAR(30));
INSERT INTO regions(regionID,regionDescription)                    
VALUES(1,'Eastern'),
(2,'Western'),
(3,'Northen'),
(4,'Southern');

-- employee_territories 
CREATE TABLE employee_territories(employeeID INT,territoryID INT);
\copy employee_territories FROM '../data/employee_territories.csv' CSV HEADER;

-- categories
CREATE TABLE categories(categoryID SERIAL PRIMARY KEY,categoryName VARCHAR,description VARCHAR,picture BYTEA);
\copy categories FROM '../data/categories.csv' CSV HEADER;

-- customers 
CREATE TABLE customers(customerID VARCHAR ,companyName VARCHAR,contactName VARCHAR,contatTitle VARCHAR,address VARCHAR,city VARCHAR, region VARCHAR, postalCode VARCHAR, country VARCHAR, phone VARCHAR, fax VARCHAR);
\copy customers FROM '../data/customers.csv' CSV HEADER;

-- employees
CREATE TABLE employees(employeeID SERIAL PRIMARY KEY ,lastName VARCHAR,firstName VARCHAR,title VARCHAR,titleOfCourtesy VARCHAR,birthDate TIMESTAMP,hireDate TIMESTAMP ,address VARCHAR, city VARCHAR ,region VARCHAR, postalCode VARCHAR, country VARCHAR, homephone VARCHAR,extension VARCHAR ,photo BYTEA,notes TEXT, reportsTo VARCHAR,photoPATH TEXT);
\copy employees FROM '../data/employees.csv' CSV HEADER;

-- orders
CREATE TABLE orders(orderId INT PRIMARY KEY, customerID VARCHAR,employeeID INT, orderDate TIMESTAMP , requiredDate TIMESTAMP , shippedDate TIMESTAMP ,shipVia INT, freight FLOAT, ShipName VARCHAR, ShipAddress VARCHAR, ShipCity VARCHAR, ShipRegion VARCHAR, ShipPostalCode VARCHAR, ShipCountry VARCHAR,
FOREIGN KEY(employeeID)
REFERENCES employees(employeeID) ON DELETE CASCADE
);
\copy orders FROM '../data/orders.csv' CSV NULL AS 'NULL' HEADER; 

-- order_details
CREATE TABLE order_details(orderId INT, ProductID INT, unitPrice FLOAT, quantity INT, discount FLOAT,
FOREIGN KEY(orderId)
REFERENCES orders(orderId) ON DELETE CASCADE
);
\copy order_details FROM '../data/order_details.csv' CSV HEADER;

-- products
CREATE TABLE products(ProductID SERIAL PRIMARY KEY, productName VARCHAR, supplierID INT, categoryID INT, quantitiyPerUnit VARCHAR, unitPrice FLOAT, unitsInStock INT, unitsOnOrder INT, reorderLevel INT, discounted BOOLEAN);
\copy products FROM '../data/products.csv' CSV HEADER;

-- shippers
CREATE TABLE shippers(ShipperID SERIAL PRIMARY KEY, compnayName VARCHAR, phone VARCHAR);
\copy shippers FROM '../data/shippers.csv' CSV HEADER;

-- suppliers
CREATE TABLE suppliers(supplierID SERIAL PRIMARY KEY, compnayName VARCHAR, contactName VARCHAR, contactTitle VARCHAR, address VARCHAR, city VARCHAR, region VARCHAR, postalCode VARCHAR, country VARCHAR, phone VARCHAR, fax VARCHAR, homePage VARCHAR);
\copy suppliers FROM '../data/suppliers.csv' CSV NULL AS 'NULL' HEADER;

-- territories
CREATE TABLE territories(territoryID INT, territoryDescription VARCHAR , regionID INT);
\copy territories FROM '../data/territories.csv' CSV NULL AS 'NULL' HEADER;

-- Count the number of products in the products table.
SELECT COUNT(productName) AS count FROM products;

-- Count separate numbers for currently available and discontinued products.
SELECT COUNT(productname) AS count_avail FROM products WHERE unitsinstock > 0;
SELECT COUNT(productname) AS count_discounted FROM products WHERE discounted=TRUE;

-- Count which product got ordered how many times.
SELECT productname, reorderLevel FROM products WHERE unitsOnOrder>0;

-- Calculate the percentage of a product on the total number of orders.
-- Verify that the sum of percentages is 100%.

CREATE VIEW view_precentage AS
SELECT productID, ((SUM(quantity) * 100.00 )/ (SELECT SUM(quantity) FROM order_details )) AS precentage FROM order_details GROUP BY productID ORDER BY precentage;

SELECT SUM(precentage) FROM view_precentage; 
-- From the Customers table, retrieve all rows containing your country.
SELECT * FROM customers WHERE country LIKE 'GERMANY';


