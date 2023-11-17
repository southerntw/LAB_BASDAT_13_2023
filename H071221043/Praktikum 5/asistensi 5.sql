SELECT * from orders

ALTER TABLE orders
ADD Jasa_Pengantar VARCHAR(50);

UPDATE orders
SET jasa_Pengantar = 'DHL'
WHERE comments LIKE '%DHL%';

UPDATE orders 
SET jasa_Pengantar = 'FedEx'
WHERE comments LIKE '%Negotiate%';

UPDATE orders
SET jasa_Pengantar = 'UPS'
WHERE comments NOT IN('DHL', 'Negotiate');

UPDATE orders
SET jasa_Pengantar = 'XPO Logistics'
WHERE comments IS NULL;

SELECT SUBSTR(c.customerName, 1, 3) AS 'Inisial Customer', lower (p.productName ) AS 'Nama Produk', o.comments, o.Jasa_Pengantar
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode);

DESCRIBE customers;