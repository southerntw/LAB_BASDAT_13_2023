-- Pertemuan07
-- Nomor1

SELECT offices.addressline1,offices.addressline2,offices.city,offices.country 
FROM offices 
INNER JOIN employees
ON offices.officeCode = employees.officeCode
INNER JOIN customers
ON employees.employeenumber = customers.salesRepEmployeeNumber
WHERE customers.customernumber IN (SELECT customernumber FROM (SELECT customernumber,COUNT(amount) AS pembayaran
																 					  FROM payments
																					  GROUP BY customernumber
																					  ORDER BY pembayaran ASC LIMIT 1) AS tabel)			
-- NOmor 2 
SELECT employees.firstName AS namaEmployee,SUM(payments.amount) AS pendapatan
FROM employees
INNER JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
INNER JOIN payments
ON customers.customerNumber = payments.customerNumber
GROUP BY employees.employeenumber
HAVING pendapatan = (SELECT MAX(totalpendapatan) FROM (SELECT SUM(payments.amount) AS totalpendapatan FROM employees
															INNER JOIN customers
															ON employees.employeeNumber = customers.salesRepEmployeeNumber
															INNER JOIN payments
															ON customers.customerNumber = payments.customerNumber
															GROUP BY employees.employeenumber) AS tabel) 
							OR 
		 pendapatan = (SELECT MIN(totalpendapatan) FROM (SELECT SUM(payments.amount) AS totalpendapatan FROM employees
		 													INNER JOIN customers
															ON employees.employeeNumber = customers.salesRepEmployeeNumber
															INNER JOIN payments
															ON customers.customerNumber = payments.customerNumber
															GROUP BY employees.employeenumber) AS tabel)
															
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Karyawan, SUM(p.amount) AS Pendapatan, e.employeeNumber
FROM employees AS e
JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p 
USING (customerNumber)
WHERE e.employeeNumber IN (
  (SELECT e.employeeNumber FROM employees AS e JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber JOIN payments AS p USING (customerNumber) GROUP BY e.employeeNumber ORDER BY SUM(p.amount) LIMIT 1)
)
GROUP BY e.employeeNumber;

-- NOmor 3

SELECT country.Name AS negara,(countrylanguage.Percentage * country.Population) AS pengguna_bahasa
FROM country
INNER JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.`Language` = (SELECT countrylanguage.language 
												FROM countrylanguage
												INNER JOIN country ON countrylanguage.CountryCode = country.Code
												WHERE continent = 'asia'
											   GROUP BY countrylanguage.language
												ORDER BY COUNT(*) DESC 
												LIMIT 1);
												
-- Nomor4 
SELECT customers.customernumber,SUM(amount)as totalPembayaran,SUM(orderdetails.quantityOrdered) banyakBarang,GROUP_CONCAT(products.productName SEPARATOR ', ') as produkDibeli
FROM customers 
INNER JOIN orders  
USING (customerNumber)
INNER JOIN orderdetails  
USING (orderNumber)
INNER JOIN products  
USING (productCode)
INNER JOIN payments
USING (customerNumber)     
GROUP BY customers.customernumber
HAVING totalPembayaran > (SELECT AVG(amount) FROM payments)
ORDER BY totalpembayaran DESC 


SELECT * FROM products

																										
