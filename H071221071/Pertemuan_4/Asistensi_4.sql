USE classicmodels
SELECT * FROM customers 
SELECT * FROM products
SELECT * FROM orderdetails
SELECT * FROM orders
-- 1
SELECT c.customerName 'Nama Customer', c.country 'Negara', p.paymentDate 'Tanggal'
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE paymentDate > '2004-12-31'
ORDER BY paymentDate ;

-- 2
SELECT DISTINCT c.customerName, p.productname, pl.textDescription
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
JOIN productlines pl ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

-- 3
ALTER TABLE products 
ADD status VARCHAR (20);

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC 

UPDATE products
SET status = 'best selling'
WHERE productCode = 'S12_4675'

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
JOIN orderdetails od
ON od.productCode = p.productCode 
ORDER BY quantityOrdered DESC 
LIMIT 1; 

-- 4
SELECT * FROM orders
WHERE status = 'cancelled';
SELECT * FROM orderdetails;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE FROM orders
WHERE status = 'cancelled';

-- 5
SELECT* FROM orders
SELECT* FROM customers 
SELECT* FROM employees

SELECT o.orderNumber 'Nomor Order', c.customerName 'Nama Customer', o.orderDate 'Tanggal Pengiriman', o.status 'Status Pengiriman', c.country 'Asal Customer', c.phone ' Nomor Telpon Customer', e.email 'Email Penanggung jawab'
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE STATUS = 'Shipped'
ORDER BY  orderdate DESC 
LIMIT 10;