USE classicmodels;

#1
SELECT c.customerName AS 'Nama Customer' , c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers c
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY tanggal ASC ;

#2
SELECT DISTINCT c.customerName AS 'Nama Customer' , p.productName, pl.textDescription AS "text Description"
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productLines pl
ON p.productLine = pl.productLine
WHERE p.productName = "The Titanic" ;


#3
ALTER TABLE products 
ADD status VARCHAR(20);

UPDATE products
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status` 
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY quantityOrdered DESC
LIMIT 1;

SELECT * FROM orders;

#4

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_2;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) references orders (orderNumber) ON DELETE CASCADE;

DELETE FROM orders
WHERE 'status' = 'cancelled';

SELECT * FROM orders;

#soal_tambahan

SELECT o.orderNumber AS 'Nomor order' , c.customerName AS 'Nama Customer', o.shippedDate AS 'Tanggal Pengiriman', o.status AS 'status pengiriman', c.country AS 'asal customer',c.phone AS "nomor telepon customer", e.email AS  "email penanggung jawab" 
FROM orders o
JOIN customers c
ON o.customerNumber = c.customerNumber
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.STATUS = 'shipped'
ORDER BY o.shippedDate DESC
LIMIT 10;


