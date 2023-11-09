USE classicmodels;

DROP DATABASE classicmodels;
-- No.1
SELECT o.addressLine1, o.addressLine2, o.city, o.country
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
WHERE e.employeeNumber = (
	SELECT c.salesRepEmployeeNumber
	FROM customers c
	JOIN (
		SELECT p.customerNumber, COUNT(*) AS paymentCount
		FROM payments p
		GROUP BY p.customerNumber
		ORDER BY paymentCount ASC
		LIMIT 1
	) AS minPayments ON c.customerNumber = minPayments.customerNumber
);

-- No.2
SELECT
    CONCAT(e.firstname, ' ', e.lastname) as Nama_Karyawan,
    SUM(p.amount) AS totalPendapatan
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = (
    SELECT MAX(totalPendapatan)
    FROM (SELECT SUM(p.amount) AS totalPendapatan
          FROM customers c
          JOIN payments p
          USING (customerNumber)
          GROUP BY c.salesRepEmployeeNumber) AS max_pendapatan
)
OR SUM(p.amount) = (
	SELECT MIN(totalPendapatan)
    FROM (SELECT SUM(p.amount) AS totalPendapatan
          FROM customers c
          JOIN payments p
          USING (customerNumber)
          GROUP BY c.salesRepEmployeeNumber) AS min_pendapatan
);

-- No.3
-- Bahasa yang paling umum digunakan di benua asia dan banyak penggunanya serta nama negara
USE world;

SELECT c.Name AS Nama_Negara, c.Population AS Pengguna_Bahasa
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.language = 
	(SELECT cl1.language
	FROM countrylanguage cl1
	JOIN country c1 ON c1.Code = cl1.CountryCode
	WHERE c1.Continent = 'Asia'
	GROUP BY cl1.language
	ORDER BY COUNT(cl1.language) DESC
	LIMIT 1);

-- No.4				
-- Jumlah pembayaran, jumlah barang, serta produk yang dibeli oleh customer yg total pembayaran di atas rata-rata
SELECT
	c.customerName,
	SUM(p.amount) AS Total_Pembayaran,
	SUM(od.quantityOrdered) AS Banyak_Barang,
	GROUP_CONCAT(pr.productName) AS Produk_yang_dibeli
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pr USING(productCode)
JOIN payments p USING(customerNumber)
GROUP BY c.customerNumber
HAVING Total_Pembayaran >
	(SELECT AVG(subTotal)
	FROM (SELECT SUM(od.quantityOrdered * od.priceEach) AS subTotal
			FROM customers c 
			JOIN orders o USING(customerNumber)
			JOIN orderdetails od USING (orderNumber)
			GROUP BY c.customerNumber) AS avgTotal
			)
ORDER BY Total_Pembayaran DESC;