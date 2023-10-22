USE classicmodels;

-- No. 1
SELECT c.customerName, p.productName, py.paymentDate, o.status
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN payments py
ON c.customerNumber = py.customerNumber
WHERE
	p.productName LIKE '%Ferrari%' AND
	o.status = 'Shipped' AND
	c.customerName LIKE '%Signal%';

	
-- No.2
-- a. Data nama customer, tanggal pembayaran, dan nama karyawan
SELECT DISTINCT c.customerName AS 'Nama Customer', 
	py.paymentDate AS 'Tanggal Pembayaran', 
	CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', 
	py.amount
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN payments py USING (customerNumber)
JOIN employees ep
ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = '11';

-- b. Pelanggan dengan transaksi terbesar pada bulan November
SELECT DISTINCT c.customerName AS 'Nama Customer', 
	py.paymentDate AS 'Tanggal Pembayaran', 
	CONCAT(ep.firstName, ' ', ep.lastName) AS 'Nama Karyawan', 
	py.amount AS 'Total Transaksi'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN payments py USING (customerNumber)
JOIN employees ep
ON ep.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTH(py.paymentDate) = '11'
ORDER BY py.amount DESC
LIMIT 1;

-- c. Data nama customer dan nama produk yang dibeli
SELECT c.customerName AS 'Nama Customer', p.productName AS 'Nama Produk'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE c.customerNumber = 321;

-- d. Produk yang dibeli oleh pelanggan dengan transaksi terbanyak
SELECT c.customerName AS 'Nama Customer', GROUP_CONCAT(p.productName) AS 'Nama Produk'
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
WHERE c.customerNumber = 321;


SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM payments;

-- No.3
SELECT c.customerName AS 'Nama Customer', o.orderDate AS 'Tanggal Order', o.shippedDate AS 'Tanggal Pengiriman', 
COALESCE(DATEDIFF(o.shippedDate, o.orderDate), 0) AS 'Lama Menunggu (hari)'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE c.customerName = 'GiftsForHim.com';


-- No. 4
USE world;

SELECT * FROM country;

SELECT NAME AS 'Nama Negara'
FROM country
WHERE CODE LIKE 'C%K' AND LifeExpectancy IS NOT NULL;


--- Soal tambahan
-- No.5
SELECT * FROM orders;
DESCRIBE orders;
ALTER TABLE orders
ADD Jasa_Pengantar VARCHAR(50);

UPDATE orders
SET Jasa_Pengantar = 
CASE 
	WHEN comments LIKE '%DHL%' THEN 'DHL'
	WHEN comments LIKE '%Negotiate'THEN 'FedEx'
	WHEN comments IS NULL THEN 'XPO Logistic'
	ELSE 'UPS'
END;

-- No.6
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM customers;
SELECT SUBSTR(UPPER (c.customerName), 1, 3) AS 'Inisial Customer', LOWER(p.productName) AS 'Nama Produk', o.comments AS 'Komentar', o.Jasa_Pengantar AS 'Jasa Pengantar'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
ORDER BY o.Jasa_Pengantar ASC; 