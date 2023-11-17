USE classicmodels;
SELECT * from customers
SELECT * FROM orders

SELECT orders.orderNumber AS 'Nomor order', customers.customerName AS 'Nama customer', orders.shippedDate AS 'Tanggal pengiriman', orders.`status` AS 'Status Pengiriman', customers.country 'Asal customers', customers.phone AS 'Nomor Telepon customers', employees.email AS 'Email penanggung jawab'
FROM orders
JOIN customers
ON orders.customerNumber = customers.customerNumber
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE STATUS = 'Shipped' ORDER BY shippedDate DESC LIMIT 10;