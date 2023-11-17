USE classicmodels;
-- Nomor 1

SELECT LEFT(orderDate, 4) AS 'tahun', COUNT(orderNumber) AS 'jumlah pesanan', case
	when COUNT(orderNumber) > 150 then 'banyak'
	when COUNT(orderNumber) < 75 then 'sedikit'
	ELSE 'Sedang' END 'kategori pesanan'
FROM orders
GROUP BY YEAR(orderDate);

-- Nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama pegawai', SUM(p.amount) AS 'gaji', case
	when SUM(p.amount) > (SELECT AVG(total) FROM (SELECT SUM(amount) AS 'total' FROM customers
								 								 JOIN payments USING (customerNumber)
								 								 JOIN employees ON employeeNumber = salesRepEmployeeNumber
								 								 GROUP BY employeeNumber)a) 
			then 'di atas rata-rata total gaji karyawan'
	ELSE 'di bawah rata-rata total gaji karyawan' END 'kategori gaji'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p USING (customerNumber)
GROUP BY e.employeeNumber
ORDER by SUM(p.amount) ASC;

-- Nomor 3

(	SELECT c.customerName AS 'Pelanggan', 
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ',') AS 'Tahun_Pembuatan', 
			 COUNT(p.productCode) AS 'Jumlah Produk', 
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 1'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 2'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION
(	SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 3'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 4'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION
(	SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 5'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 6'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
	ORDER BY `Pelanggan` DESC;
	
	#soal tambahan
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Lengkap', CONCAT(ep.firstName, ' ', ep.lastName) AS 'Penanggung Jawab',
CASE
   WHEN e.reportsTo = (SELECT employeeNumber FROM employees WHERE jobTitle LIKE "%APAC%") THEN 'Asia-Pasifik'
   WHEN e.reportsTo = (SELECT employeeNumber FROM employees WHERE jobTitle LIKE "%EMEA%") THEN 'Eropa, Timur Tengah dan Afrika'
   WHEN e.reportsTo = (SELECT employeeNumber FROM employees WHERE jobTitle LIKE "%(NA)%") THEN 'Amerika Utara'
	ELSE 'Non-Regional'
	END AS 'Region Tanggung Jawab',
o.city AS 'Lokasi Kantor'
FROM employees e
JOIN offices o USING (officeCode)
LEFT JOIN employees ep
ON e.reportsTo = ep.employeeNumber
GROUP BY e.employeeNumber
ORDER BY e.employeeNumber;
