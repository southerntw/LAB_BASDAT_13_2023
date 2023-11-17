-- P3rtemuan 05
-- Nomor1
SELECT customers.customerName,products.productName,payments.paymentDate,orders.`status`
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE "%Ferrari%" AND orders.`status` = "Shipped";
-- =================================================================

-- Nomor2
-- 2a
SELECT customers.customerName,payments.paymentDate,employees.lastName,employees.firstName
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
INNER JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE MONTH(payments.paymentDate)> 10 AND MONTH(payments.paymentDate) < 12
-- =================================================================
-- 2b
SELECT customers.customerName,payments.paymentDate,CONCAT(employees.firstName," ",employees.lastName)AS namaEmployees,payments.amount
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
INNER JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE MONTH(payments.paymentDate)> 10 AND MONTH(payments.paymentDate) < 12
ORDER BY payments.amount DESC
LIMIT 1;

-- 2c
SELECT customers.customerName,products.productName
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE MONTH(payments.paymentDate)> 10 AND MONTH(payments.paymentDate) < 12 
AND customers.customerName = "Corporate Gift Ideas Co.";

-- =================================================================
-- 2d
SELECT * FROM products;
SELECT customers.customerName,GROUP_CONCAT(DISTINCT products.productName) AS namaProducts
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE MONTH(payments.paymentDate)> 10 AND MONTH(payments.paymentDate) < 12 
AND customers.customerName = "Corporate Gift Ideas Co.";
-- =================================================================
-- nomor3
SELECT * FROM orders;
SELECT customers.customerName,orders.orderDate,orders.shippedDate,COALESCE(orders.shippedDate - orders.orderDate, 0) AS Hari
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE customers.customerName = "GiftsForHim.com"
ORDER BY hari DESC;
-- =================================================================
-- nomor4
-- 4a
SELECT * FROM country;
SELECT Code FROM country
WHERE COde LIKE "c%k" AND LifeExpectancy IS NOT NULL;


-- Nomor 5
SELECT * FROM orders
ALTER TABLE orders
ADD jasaPengantar VARCHAR(20);

SELECT * FROM orders

UPDATE orders
SET jasaPengantar = 'DHL'
WHERE comments LIKE "%DHL%";

UPDATE orders
SET jasaPengantar = 'FedEx'
WHERE comments LIKE "%Negotiate%";

UPDATE orders
SET jasaPengantar = 'UPS'
WHERE comments NOT LIKE "%DHL%" AND comments NOT LIKE "%Negotiate%";

UPDATE orders
SET jasaPengantar = 'XPO Logistics'
WHERE comments IS NULL ;

-- No 6
-- RIGHT(customers.customerName,3)
SELECT UPPER(LEFT(customers.customerName,3)) AS inisialCustomers,products.productName AS namaProduk,orders.comments AS komentar,orders.jasaPengantar 
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE orders.jasaPengantar = 'DHL';
