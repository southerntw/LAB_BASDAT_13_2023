SELECT * FROM customers;
SELECT customername, city, country FROM customers WHERE country = 'USA';

SELECT * FROM products;
SELECT DISTINCT productVendor FROM products;

SELECT * FROM payments;
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

SELECT * FROM products;
SELECT productName AS 'Nama Produk', buyPrice AS 'Harga Beli', quantityInStock AS 'Jumlah dalam stok' FROM products WHERE quantityInStock > 1000 AND quantityInStock < 3000 ORDER BY quantityInStock LIMIT 4, 10;