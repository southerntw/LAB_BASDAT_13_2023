USE classicmodels


##--No1--##
SELECT customerName, city, country
FROM customers
WHERE country = 'USA'

##--No2--##
SELECT DISTINCT productVendor
FROM products

##--No3--##
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE customerNumber = '124'
ORDER BY paymentDate DESC

##--No4--##
SELECT productName 'Nama Produk', buyPrice 'Harga Beli', quantityinstock 'jumlah dalam stok'
FROM products
WHERE quantityinstock >= 1000 AND quantityinstock <=3000
ORDER BY buyPrice ASC
LIMIT 5,10

##--No5 --  Dari Asistensi--##
