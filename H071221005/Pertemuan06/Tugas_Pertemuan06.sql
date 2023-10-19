-- Pertemuan06
-- Nomor1
SELECT * FROM employees;
SELECT  CONCAT(employees.firstName,' ',employees.lastName) AS namaEmployees,GROUP_CONCAT(orders.orderNumber)AS nomorOrderan,COUNT(orders.orderNumber) AS jumlahPesanan
FROM employees
INNER JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
WHERE orderdetails.quantityOrdered > 10
GROUP BY namaEmployees

-- Nomor2
SELECT products.productCode,products.productName,products.quantityInStock,orders.orderDate
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
INNER JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.quantityInStock > 5000
GROUP BY products.productName
ORDER BY orders.orderDate ASC 
-- Nomor3
SELECT
    offices.addressLine1 AS alamat,
    concat(substring(offices.phone,1,6),'* **') AS nomor_telp,
    COUNT(DISTINCT employees.employeeNumber) AS jumlah_karyawan,
    COUNT(DISTINCT customers.customerNumber) AS jumlah_pelanggan,
    AVG(payments.amount) AS rata2_penghasilan
FROM offices
INNER JOIN employees 
ON offices.officeCode = employees.officeCode
LEFT JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN payments
ON customers.customerNumber = payments.customerNumber 
GROUP BY offices.addressLine1
ORDER BY offices.phone ASC ;	

-- Nomor4
SELECT customers.customerName,YEAR(orders.orderDate) AS tahun_order,MONTHNAME(orders.orderDate) as bulan_order,COUNT(orders.orderNumber),sum(orderdetails.quantityOrdered * orderdetails.priceEach)AS uang_total_penjualan
FROM customers
INNER JOIN orders
ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
WHERE YEAR(orders.orderDate) = 2003
GROUP BY customers.customerName,bulan_order; 



SELECT productCode, COUNT(productCode)
FROM orderdetails
GROUP BY productCode 

-- NOmor5
SELECT  CONCAT(employees.firstName,' ',employees.lastName) AS namaEmployees,COALESCE(sum(payments.amount),0) AS jumlah_penjualan
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber
RIGHT JOIN employees
on employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY namaEmployees
ORDER BY namaEmployees ASC;


-- N0mor 6
SELECT products.productLine,sum(orderdetails.quantityOrdered * orderdetails.priceEach) AS jumlah_penjualan,CONCAT((products.productName),' (',MAX(orderdetails.quantityOrdered * orderdetails.priceEach),')') AS BestSellingProduct
FROM productlines
INNER JOIN products
ON productlines.productLine = products.productLine
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode
GROUP BY products.productLine



	
