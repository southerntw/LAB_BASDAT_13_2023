USE classicmodels;

DROP DATABASE classicmodels;
 
-- No.1
SELECT * FROM orders;
SELECT * FROM orderdetails;
SELECT * FROM employees;
SELECT * FROM customers;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Employee', GROUP_CONCAT(DISTINCT(o.orderNumber) SEPARATOR ';') AS 'Nomor Orderan',
		od.quantityOrdered AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
HAVING (od.quantityOrdered) > 10;
 
 
-- No.2
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
JOIN orders o
ON od.orderNumber = o.orderNumber
GROUP BY p.productCode
HAVING (p.quantityInStock) > 5000
ORDER BY o.orderDate ASC;
 
-- No.3
SELECT * FROM offices;
SELECT * FROM employees;
SELECT * FROM customers;

SELECT oc.addressLine1 AS 'Alamat',
		CONCAT(SUBSTR(oc.phone, 1, 10), '*****') AS 'Nomor Telp',
		COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		ROUND(AVG(py.amount), 2) AS 'Rata-Rata Penghasilan'
FROM offices oc
LEFT JOIN employees e
ON oc.officeCode = e.officeCode
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py
ON c.customerNumber = py.customerNumber
GROUP BY oc.addressLine1
ORDER BY oc.phone;

-- No.4
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT c.customerName, YEAR(o.orderDate) AS 'Tahun Order', MONTHNAME(o.orderDate) AS 'Bulan Order', 
		COUNT(od.quantityOrdered) AS 'Jumlah Pesanan', SUM(od.quantityOrdered * od.priceEach) AS 'Uang Total Penjualan'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, YEAR(o.orderDate), MONTH(o.orderDate);
-- HAVING YEAR(o.orderDate) = 2003;


-- Soal Tambahan
-- No.5
SELECT * FROM payments;
SELECT * FROM orderdetails;
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'EmployeeName', COALESCE(SUM(py.amount), 0) AS 'TotalSales'
FROM employees e
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py
ON c.customerNumber = py.customerNumber
GROUP BY CONCAT(e.firstName, ' ', e.lastName);
ORDER BY py.amount DESC;


-- No.6
SELECT * FROM products;

SELECT p.productName, od.quantityOrdered
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY od.quantityOrdere
SELECT p.productLine, SUM(od.priceEach * od.quantityOrdered) AS 'TotalSales', CONCAT(p.productName, ' ', '(',  MAX(quantityOrdered * od.priceEach), ')') AS 'BestSellingProduct'
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
GROUP BY p.productLine;

