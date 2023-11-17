USE classicmodels;

DESCRIBE orderdetails;
-- no.1
SELECT c.customerName AS 'Nama Customer' , c.country AS 'Negara' , p.paymentDate AS 'tanggal'
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01' ORDER BY p.paymentDate ASC;

-- no, 2
SELECT DISTINCT c.customerName AS 'Nama Customer' , p.productName , pl.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON  o.orderNumber = od.orderNumber
JOIN products p
ON  od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE productName = 'The Titanic';

-- no. 3
ALTER TABLE products
ADD STATUS VARCHAR(20);

SELECT * FROM orderdetails;

UPDATE products
SET STATUS = 'Best Selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`STATUS` 
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY quantityOrdered DESC LIMIT 1;

-- no. 4
ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE FROM orders
WHERE STATUS = 'cancelled'

SELECT * FROM orders