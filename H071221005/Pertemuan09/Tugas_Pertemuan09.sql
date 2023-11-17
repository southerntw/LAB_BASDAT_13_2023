-- Pertemuan 09
--Nomor1
SELECT * FROM orders
SELECT YEAR(orderdate) AS tahun,COUNT(ordernumber) AS jumlahPesanan,CASE
																	when COUNT(ordernumber) > 150 then 'Banyak'
																	when COUNT(ordernumber) < 75 then 'Sedikit'
																	ELSE 'Sedang'
																	END
																	AS 'kategori pesanan'
																	FROM orders
GROUP BY tahun

--------

-- nomor2

SELECT CONCAT(employees.firstName,' ',employees.lastName)AS namaPegawai,SUM(payments.amount) AS gaji ,case 
																																		when SUM(payments.amount) > (SELECT AVG(total) FROM (SELECT SUM(payments.amount) AS total 
																																													 FROM employees
																																													 JOIN customers ON employees.employeenumber = customers.salesRepEmployeeNumber
																																													 JOIN payments USING (customernumber)
																																													 GROUP BY employees.employeenumber ) AS tabel) then 'diatas rata-rata'
																																		ELSE 'dibawah rata-rata'
																																		END 
																																		AS 'kategori gaji' 
FROM employees
JOIN customers ON employees.employeenumber = customers.salesRepEmployeeNumber
JOIN payments USING (customernumber)
GROUP BY employees.employeenumber
ORDER BY SUM(payments.amount) DESC

-- Nomor 3
SELECT * FROM products
SELECT * FROM orders
SELECT SUBSTRING(productname,1,4) FROM products

SELECT customers.customername,GROUP_CONCAT(LEFT(products.productname,4)) AS tahun_pembuatan,
		 COUNT(products.productcode) AS stok,SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman',
		 case when MONTH(orders.orderdate ) % 2 = 1 AND SUM(DATEDIFF(shippedDate, orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)AS tabel) then 'target 1'
		      when MONTH(orders.orderdate ) % 2 = 0 AND SUM(DATEDIFF(shippedDate, orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)AS tabel) then 'target 2' 
		 ELSE NULL
		 END
		 AS keterangan
FROM customers
JOIN orders USING(customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING(productCode)
WHERE LEFT(products.productName,4) LIKE '18%' 
GROUP BY customers.customername
HAVING keterangan IS NOT NULL
UNION
SELECT customers.customername,GROUP_CONCAT(SUBSTRING(products.productname,1,4)) AS tahun_pembuatan,
		 COUNT(products.productcode) AS stok,SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman',
		 case when MONTH(orders.orderdate ) % 2 = 1 AND COUNT(products.productcode) > (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)AS tabel) THEN 'target 3' 
		      when MONTH(orders.orderdate ) % 2 = 0 AND COUNT(products.productcode)> (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)AS tabel) THEN 'target 4' 
		 ELSE NULL
		 END
		 AS keterangan
FROM customers
JOIN orders USING(customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING(productCode)
WHERE LEFT(products.productName,2) = '19' 
GROUP BY customers.customername
HAVING keterangan IS NOT NULL
UNION
SELECT customers.customername,GROUP_CONCAT(SUBSTRING(products.productname,1,4)) AS tahun_pembuatan,
		 COUNT(products.productcode) AS stok,SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman',
		 case when MONTH(orders.orderdate ) % 2 = 1 AND COUNT(products.productcode) > (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)AS tabel) THEN 'target 3' 
		      when MONTH(orders.orderdate ) % 2 = 0 AND COUNT(products.productcode)> (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)AS tabel) THEN 'target 4' 
		 ELSE NULL
		 END
		 AS keterangan
FROM customers
JOIN orders USING(customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING(productCode)
WHERE LEFT(products.productName,2) = '20' 
GROUP BY customers.customername
HAVING keterangan IS NOT NULL

    
-- nomor5
SELECT * FROM employees
SELECT * FROM offices
SELECT CONCAT(a.firstName,' ',a.lastName)AS 'nama lengkap',CONCAT(b.firstName,' ',b.lastName)AS 'penanggung jawab',
		 case when b.jobTitle LIKE '%APAC%' then 'Asia Pasifik'
		      when b.jobTitle LIKE '%EMEA%' then 'Eropa,Timur Tengah,dan Afrika' 
		      when b.jobTitle LIKE '%NA%' then 'Amerika Utara' 
		      ELSE  'Non-Regional'
		      END
		      AS 'Region Tanggung Jawab'
		,offices.city
FROM employees a JOIN offices USING(officecode) LEFT JOIN employees b ON a.reportsTo = b.employeeNumber


