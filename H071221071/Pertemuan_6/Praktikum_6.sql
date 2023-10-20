USE classicmodels
#No1
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan', COUNT(c.customerNumber) AS 'Jumlah Pesanan'
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber
HAVING COUNT(c.customerNumber) >10


#No2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products AS p
JOIN orderdetails AS od
ON p.productCode = od.productCode
JOIN orders AS o
ON od.orderNumber = o.orderNumber
GROUP BY p.productName
HAVING(p.quantityInStock) > 5000 
ORDER BY o.orderDate 


#No3
SELECT o.addressline1 AS 'Alamat', CONCAT(left(o.phone, LENGTH(o.phone)-5), '*****') AS 'Nomor Telp', COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan', COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan', ROUND(AVG(p.amount), 2) AS 'Rata-rata penghasilan'
FROM offices AS o
LEFT JOIN employees AS e
USING(officeCode)
LEFT JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
USING(customerNumber)
GROUP BY o.addressLine1 
ORDER BY o.phone;

#No4
SELECT c.customerName, YEAR(o.orderDate) AS 'tahun order', MONTH(o.orderDate) AS 'bulan order', od.quantityOrdered AS 'jumlah pesanan', SUM(od.priceEach*od.quantityOrdered) AS 'uang total penjualan'
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate)




