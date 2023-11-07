USE classicmodels;

SELECT * from orders

-- no 1
SELECT c.customerName, p.productName, pm.paymentDate, o.`status`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN payments pm
ON pm.customerNumber = c.customerNumber
WHERE p.productName LIKE '%Ferrari%' AND o.status = 'Shipped';

-- no 2 a
SELECT c.customerName, p.paymentDate, CONCAT (e.firstName, ' ' , e.lastName) AS 'employee name'
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentDate) = 11;

-- no 2 b
SELECT c.customerName, p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE MONTH (paymentDate) = 11 ORDER BY  amount DESC LIMIT 1;

-- no 2 c
SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.';

-- no 2 d
SELECT c.customerName, GROUP_CONCAT(' ', p.productName)
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.';

-- no 3
SELECT c.customerName, o.orderDate, o.shippedDate, ABS (o.orderDate-o.shippedDate) AS 'Lama menunggu'
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE customername ='GiftsForHim.com';

SELECT * FROM country
 -- no 4 b
SELECT * FROM country 
WHERE CODE LIKE 'C%K' AND LifeExpectancy IS NOT NULL; 
