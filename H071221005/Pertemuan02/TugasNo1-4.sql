-- No1
SELECT customerName,city,country FROM customers
LIMIT 36;

-- No2
SELECT DISTINCT productVendor FROM products
LIMIT 13;

-- No3
SELECT customerNumber,checkNumber,paymentDate,amount FROM payments
WHERE customerNumber='124'
ORDER BY customerNumber DESC
LIMIT 9;

-- No4
SELECT productName AS 'Nama produk',buyPrice AS'Harga beli',quantityinStock AS 'jumlah dalam stok' FROM products
WHERE quantityinStock >=1000 AND quantityinStock <= 3000
ORDER BY buyPrice ASC
LIMIT 5,10;