USE classicmodels;

-- No.1
SELECT customerName, city, country
FROM customers
WHERE country='USA';

-- No.2
SELECT DISTINCT productVendor
FROM products

-- No.3
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC

-- No.4
SELECT productName AS 'Nama produk', buyPrice AS 'Harga beli', quantityinstock AS 'Jumlah dalam stok'
FROM products
WHERE quantityinstock >=1000 AND quantityinstock <=3000
ORDER BY buyPrice ASC
LIMIT 5,10;