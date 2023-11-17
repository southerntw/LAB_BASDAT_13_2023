-- Pertemuan08
-- Nomor 1
SELECT customername, productname, modal
FROM (
    SELECT customers.customername, products.productname, (products.buyPrice * orderdetails.quantityOrdered) AS modal
    FROM customers
    JOIN orders USING (customernumber)
    JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
    JOIN products ON orderdetails.productCode = products.productCode
    ORDER BY modal DESC
    LIMIT 3) AS tabel
UNION
SELECT customername, productname, modal
FROM (
    SELECT customers.customername, products.productname, (products.buyPrice * orderdetails.quantityOrdered) AS modal
    FROM customers
    JOIN orders USING (customernumber)
    JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
    JOIN products ON orderdetails.productCode = products.productCode
    ORDER BY modal ASC
    LIMIT 3) AS tabel
    
-- Nomor2
SELECT cityCustEmployee,SUM(cityCustomersEmployee) AS 'jumlahCityCustEmployee'
FROM( SELECT city AS cityCustEmployee,COUNT(city) AS cityCustomersEmployee FROM customers
		WHERE customername LIKE 'l%'
		GROUP BY city
		UNION 
		SELECT offices.city,COUNT(offices.city)
		FROM offices
		JOIN employees USING(officecode)
		WHERE employees.firstName LIKE 'l%'
		GROUP BY offices.city
		ORDER BY cityCustomersEmployee DESC) AS tabel
GROUP BY cityCustEmployee
ORDER BY jumlahCityCustEmployee DESC
LIMIT 1
-- --


-- Nomor 3
SELECT CONCAT(firstname,' ',lastname) AS 'nama Karyawan/Pelanggan','Karyawan' AS status FROM employees
JOIN offices USING(officecode)
WHERE officecode IN (SELECT officecode
						  FROM(SELECT officecode,COUNT(employeenumber) AS countEmp 
						  FROM employees
					 	  GROUP BY officecode
						  ORDER BY countEmp ASC
						  LIMIT 4)AS tabel)									  
UNION
SELECT customers.customername ,'Pelanggan'FROM customers
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE employees.officecode IN (SELECT officecode
										  FROM(SELECT officecode,COUNT(employeenumber) AS countEmp 
										  FROM employees
									 	  GROUP BY officecode
										  ORDER BY countEmp ASC
										  LIMIT 4)AS tabel)

-- Nomor4
SELECT tanggal,CASE 
	           WHEN COUNT(*) = 2 THEN 'membayar pesanan dan memesan barang' 
	           ELSE riwayat 
	       	  END AS riwayat
FROM(SELECT orderDate AS tanggal,'memesan barang' AS riwayat FROM orders	
	  UNION
	  SELECT paymentdate,'membayar pesanan' FROM payments
	  ORDER BY tanggal ASC) AS tabel
WHERE tanggal BETWEEN '2003-04-01' AND '2003-04-30'
GROUP BY tanggal
			  



