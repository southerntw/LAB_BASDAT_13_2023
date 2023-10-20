#no1
SELECT c.customerName, p.productName, pa.paymentDate, o.status
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE p.productName LIKE '%ferrari%' AND o.status= 'Shipped'
LIMIT 3

#no2
#a
SELECT c.customerName, MONTHNAME(pa.paymentDate) 'Bulan', CONCAT(e.firstName, " " ,e.lastName)'Nama Penanggung Jawab', pa.amount
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTHNAME (pa.paymentDate) = 'November'

#b
SELECT c.customerName, MONTHNAME(pa.paymentDate) 'Bulan', CONCAT(e.firstName, " " ,e.lastName) 'Nama Penanggung Jawab', pa.amount
FROM customers AS c
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE MONTHNAME(pa.paymentDate) = 'November'
ORDER BY pa.amount DESC
LIMIT 1

#c
SELECT c.customerName, p.productName
FROM customers AS c
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS pa
ON pa.customerNumber = c.customerNumber
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE MONTHNAME(pa.paymentDate) = 'November' AND c.customerName = 'Corporate Gift Ideas Co.'


#d
SELECT c.customerName, GROUP_CONCAT(p.productName)AS 'product Name'
FROM customers AS c
JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS pa ON pa.customerNumber = c.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
JOIN products AS p ON p.productCode = od.productCode
WHERE MONTHNAME(pa.paymentDate) = 'November' AND c.customerName = 'Corporate Gift Ideas Co.'

#no3
SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF('2005-04-30', '2005-04-29') AS 'Telah menunggu selama'
FROM customers AS c
JOIN orders AS o
ON o.customerNumber = c.customerNumber
WHERE c.customerName = 'GiftsForHim.com'
ORDER BY o.orderDate DESC
LIMIT 1

#no4
USE world
SELECT * FROM city
SELECT * FROM country

SELECT co.code, co.Name, co.LifeExpectancy
FROM country AS co
WHERE co.code LIKE 'C%' AND co.code LIKE '%K' AND co.lifeexpectancy IS NOT NULL 


#No5 Soal Tambahan
ALTER TABLE orders
ADD COLUMN  Jasa_Pengantar VARCHAR(200);


UPDATE orders
SET Jasa_Pengantar = 'DHL'
WHERE comments LIKE '%DHL%'

UPDATE orders
SET Jasa_Pengantar = 'FedEx'
WHERE comments LIKE '%Negotiate%'

UPDATE orders
SET Jasa_Pengantar = 'UPS'
WHERE comments <> 'DHL' AND comments <> 'Negotiate'

UPDATE orders
SET Jasa_Pengantar = 'XPO Logistics'
WHERE comments IS NULL

SELECT Jasa_Pengantar FROM orders
WHERE Jasa_Pengantar = 'DHL'


SELECT * from orders


#No6
SELECT UPPER(LEFT(customerName, 3))  'Inisial Customer', p.productName 'Nama Produk', o.comments 'Komentar', o.Jasa_Pengantar 
FROM customers
JOIN orders o USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products p USING(productCode)