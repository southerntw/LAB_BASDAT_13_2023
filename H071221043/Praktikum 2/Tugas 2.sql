USE classicmodels;

SELECT customerName, city, country FROM customers WHERE country = 'USA';

SELECT DISTINCT productVendor FROM products;

SELECT customerNumber, checkNumber, paymentDate, amount FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

SELECT productName AS 'nama produk', buyprice AS 'harga beli', quantityinstock AS 'jumlah dalam stok' FROM products 
WHERE quantityinstock >1000 AND quantityinstock <3000 ORDER BY buyprice ASC LIMIT 5, 10;