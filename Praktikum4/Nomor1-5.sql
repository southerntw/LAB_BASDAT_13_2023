USE classicmodels;

-- No.1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > '2004-12-31'
ORDER BY paymentDate ASC;

-- No.2
SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
INNER JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

-- No.3
DESCRIBE products;
SELECT * FROM products;
SELECT * FROM orders;

ALTER TABLE products
ADD STATUS VARCHAR(20);

UPDATE products p
JOIN orderdetails od
ON p.productCode = od.productCode
SET p.status = 'Best Selling'
WHERE od.quantityOrdered = 97;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products p
INNER JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY od.quantityOrdered DESC
LIMIT 1;

-- No.4
ALTER TABLE 'orders'
DROP FOREIGN KEY 'orders_ibfk_1';

ALTER TABLE orders
ADD CONSTRAINT 'orders_ibfk_1' FOREIGN KEY ('customerNumber') REFERENCES customers ('customerNumber') ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE 'orderdetails'
DROP FOREIGN KEY 'orderdetails_ibfk_1',
DROP FOREIGN KEY 'orderdetails_ibfk_1';

ALTER TABLE 'orderdetails'
ADD CONSTRAINT 'orderdetails_ibfk_1' FOREIGN KEY ('orderNumber') REFERENCES 'orders' ('orderNumber') ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT 'orderdetails_ibfk_2' FOREIGN KEY ('productCode') REFERENCES 'products' ('productCode') ON UPDATE CASCADE ON DELETE CASCADE;

DELETE FROM classicmodels.orders 
WHERE STATUS = 'Cancelled';

SELECT * FROM orders
WHERE STATUS = 'Cancelled';


-- saol tambahan
SELECT o.orderNumber AS 'Nomor Order', c.customerName AS 'Nama Customer', o.shippedDate AS 'Tanggal Pengiriman', o.status AS 'Status Pengiriman', c.country AS 'Asal Customer', c.phone AS 'Nomor Telepon Customer', e.email AS 'Email Penanggung Jawab'
FROM orders o
JOIN customers c
ON o.customerNumber = c.customerNumber
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.status = 'Shipped'
ORDER BY o.shippedDate DESC
LIMIT 10;