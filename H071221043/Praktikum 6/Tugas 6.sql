-- no 1
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Employee',
o.orderNumber AS 'Nomor Orderan',
COUNT(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
GROUP BY e.employeeNumber
HAVING COUNT(od.quantityOrdered) > 10;

-- no 2
SELECT p.productCode, p.productName, p.quantityInStock,MIN(o.orderDate)
FROM orders o
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.quantityInStock > 5000
GROUP BY p.productname
ORDER BY o.orderDate;

-- no 3
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

-- no 4
SELECT c.customerName AS 'Customer Name', YEAR(o.orderDate) AS 'Tahun Order',
MONTH(o.orderDate) AS 'Bulan Order', COUNT(o.orderNumber) AS 'Jumlah Pesanan',
SUM(od.priceEach * od.quantityOrdered) AS 'Total Penjualan'
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, YEAR(o.orderDate), MONTH(o.orderDate);


