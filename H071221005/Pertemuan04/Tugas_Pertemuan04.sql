-- Tugas Praktikum 4
-- Nomor 1
USE classicmodels;
SELECT customers.customerName AS 'namaCustomer',customers.country AS 'negara',payments.paymentDate AS 'tanggal'
FROM customers
INNER JOIN payments
ON customers.customerNumber = payments.customerNumber
WHERE paymentDate >= "2005-01-01" 
ORDER BY paymentDate ASC;
-- ======================================================================

-- Nomor 2
SELECT DISTINCT customers.customerName AS 'namaCustomer',products.productName,products.productDescription AS 'textDescription'
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber=orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE productName = "The Titanic";
-- ======================================================================

-- Nomor 3
ALTER TABLE products
ADD status VARCHAR(20);

SELECT  products.productCode,products.productName,orderdetails.quantityOrdered,products.status
FROM products
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode
SET products.`status`='Best Selling'
WHERE products.productCode='S12_4675' AND orderdetails.quantityOrdered=97;

SELECT * FROM products;
-- ======================================================================

-- Nomor 4 
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM orders
WHERE STATUS = 'Cancelled';

ALTER TABLE orders DROP CONSTRAINT orders_ibfk_1;
ALTER TABLE orderdetails DROP CONSTRAINT orderdetails_ibfk_1;
ALTER TABLE payments DROP CONSTRAINT payments_ibfk_1;
DELETE orders 
FROM orders
WHERE orders.`status` = 'Cancelled';
-- ======================================================================

-- Nomor 5
SELECT orders.orderNumber AS 'Nomor order',customers.customerName AS 'Nama customers',orders.shippedDate AS 'Tanggal Pengiriman',orders.`status` AS 'status Pengiriman',customers.country AS 'Asal Customers',customers.phone AS'Nomor Telepon Cutomers',employees.email AS ' Email Penanggung Jawab'
FROM orders 
INNER JOIN customers
ON orders.customerNumber = customers.customerNumber
INNER JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE orders.`status` = 'Shipped'
ORDER BY orders.shippedDate DESC
LIMIT 10;

-- ========================================================================
