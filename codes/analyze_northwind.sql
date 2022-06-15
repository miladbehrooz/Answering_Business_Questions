-- connect to the database
\c northwind

-- 1.Get the names and the quantities in stock for each product.

SELECT productName,unitsInStock 
FROM products;

-- 2.Get a list of current products (Product ID and name).
SELECT ProductID,productName
FROM products
WHERE unitsInStock <> 0;

-- 3.Get a list of the most and least expensive products (name and unit price).

SELECT productName, unitPrice 
FROM products
ORDER BY unitPrice DESC
LIMIT 5;

SELECT productName, unitPrice 
FROM products
ORDER BY unitPrice ASC
LIMIT 5;


-- 4.Get products that cost less than $20.
SELECT productName, unitPrice
FROM products
WHERE unitPrice < 20;

-- 5.Get products that cost between $15 and $25.
SELECT productName,unitPrice
FROM products
WHERE unitPrice BETWEEN 15 AND 25
ORDER BY unitPrice DESC;

-- 6.Get products above average price.
SELECT productName,unitPrice
FROM products
WHERE unitPrice > (SELECT AVG(unitPrice) FROM products)
ORDER BY unitPrice DESC;

-- 7.Find the ten most expensive products.
SELECT productName,unitPrice
FROM products
ORDER BY unitPrice DESC
LIMIT 10;

-- 8.Get a list of discontinued products (Product ID and name).
SELECT ProductID,productName
FROM products
WHERE discounted = TRUE;

-- 9.Count current and discontinued products.
SELECT ProductID,productName
FROM products
WHERE unitsInStock <> 0 AND discounted = TRUE;

-- 10.Find products with less units in stock than the quantity on order.
SELECT ProductID,productName,unitsInStock, unitsOnOrder
FROM products
WHERE unitsInStock < unitsOnOrder;

-- 11.Find the customer who had the highest order amount
CREATE VIEW rjoin_view_orders_orderdetails AS
SELECT orders.orderID, orders.customerID, order_details.quantity 
FROM orders
RIGHT JOIN order_details
ON orders.orderID = order_details.orderID;

SELECT  customerID, quantity
FROM rjoin_view_orders_orderdetails
ORDER BY quantity DESC
LIMIT 1; 

-- 12.Get orders for a given employee and the according customer
CREATE VIEW rjoin_view_employee_orders AS
SELECT employees.employeeID, orders.customerID, orders.orderID 
FROM employees
RIGHT JOIN orders
ON employees.employeeID = orders.employeeID;

SELECT employeeID, orderID ,customerID
FROM rjoin_view_employee_orders
WHERE employeeID=1; 

-- 13.Find the hiring age of each employee
SELECT firstName,lastName, hireDate-birthDate AS hiring_age
FROM employees;

-- 14.Create views and/or named queries for some of these queries

CREATE VIEW rjoin_view_employee_orders AS
SELECT e.employeeID, o.customerID, o.orderID 
FROM employees AS e
RIGHT JOIN orders AS o 
ON e.employeeID = o.employeeID;