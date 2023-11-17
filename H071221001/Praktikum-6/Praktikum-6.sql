-- 1

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama employee',
o.orderNumber AS 'Nama orderan',
COUNT(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
GROUP BY CONCAT(e.firstName, ' ', e.lastName)
HAVING COUNT(od.quantityOrdered) > 10;

-- 2

SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate)
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productName
ORDER BY o.orderDate;

-- 3

SELECT o.addressline1 AS 'Alamat', 
CONCAT(LEFT(o.phone, LENGTH(o.phone) - 5), '* **') AS 'Nomor Telp',
COUNT(DISTINCT e.employeeNumber) AS 'jumlah karyawan',
COUNT(DISTINCT  c.customerNumber) AS 'jumlah pelanggan',
AVG(p.amount) AS 'rata-rata penghasilan'
FROM offices o
LEFT JOIN employees e 
USING(officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p 
USING(customerNumber)
GROUP BY o.addressLine1;

-- 4

SELECT  c.customerName, YEAR(o.orderDate) AS 'Tahun order', MONTH(o.orderDate) AS 'Bulan order',
COUNT(od.quantityOrdered) 'jumlah pesanan', SUM(od.priceEach *  od.quantityOrdered) AS 'Uang total penjualan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);