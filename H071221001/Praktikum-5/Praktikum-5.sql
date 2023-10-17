#NOMOR 1

USE classicmodels;
SELECT * FROM ord
SELECT DISTINCT customers.customerName,products.productName,payments.paymentDate,orders.status
FROM customers
JOIN orders
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
JOIN payments  
USING (customernumber)
WHERE customers.customername = 'signal gift stores' AND products.productname LIKE '%Ferrari%' AND orders.status ='shipped';

#N0MOR 2

#a
SELECT customers.customerName,payments.paymentDate,employees.firstName,employees.lastName
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH (paymentdate)= 11;

#b
SELECT customers.customerName,
payments.paymentDate,
payments.amount,
CONCAT (employees.firstName,' ',employees.lastName) AS 'nama karyawan'
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH(paymentdate)=11
ORDER BY amount DESC LIMIT 1;

#c
SELECT customers.customerName AS 'nama Customers',products.productName AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';

#d
SELECT customers.customerName AS 'nama Customers', GROUP_CONCAT(products.productName) AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';

#NOMOR 3
SELECT customers.customerName AS 'Nama Customers',
orders.orderDate AS 'tanggal order',
orders.shippedDate AS 'tanggal pengiriman',
(orders.orderDate) AS lama_menunggu
FROM customers
JOIN orders
USING (customernumber)
WHERE customername ='GiftsForHim.com';

#NOMOR 4
USE world;
#a
SELECT * FROM country;

SELECT * FROM country 
WHERE code2 LIKE 'C%K' AND CODE LIKE 'C%K'; 

#b
SELECT * FROM country
WHERE lifeexpectancy != 'null';

#5
USE classicmodels;
SELECT * FROM orders;

ALTER TABLE orders ADD JasaPengantaran VARCHAR(20);

UPDATE orders
SET jasaPengantaran = 'DHL'
WHERE comments LIKE %DHL%;

UPDATE orders
SET jasaPengantaran = 'FedEx'
WHERE comments LIKE '%negotiate%';

UPDATE orders
SET jasaPengantaran = 'UPS'
WHERE comments NOT LIKE '%DHL%' AND comments NOT LIKE '%negotiate%' AND comments IS NOT NULL;

UPDATE orders
SET jasaPengantaran = 'XPO Logistics'
WHERE comments IS NULL;

#6
SELECT UPPER(LEFT(customerName, 3)) AS 'inisial customer' , upper(p.productname) AS 'nama produk',  o.comments , o.JasaPengantaran
FROM customers c
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING (productcode)
ORDER BY JasaPengantaran ASC;