-- 1

(SELECT c.customerName, p.productName, p.buyPrice * sum(od.quantityOrdered) AS 'Modal'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY SUM(p.buyPrice * od.quantityOrdered) DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, p.buyPrice * sum(od.quantityOrdered) AS 'Modal'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY SUM(p.buyPrice * od.quantityOrdered)
LIMIT 3);

-- 2

SELECT city, COUNT(*) AS jumlah_karyawan_pelanggan_L
FROM (
    SELECT offices.city FROM employees
    JOIN offices USING(officeCode)
    WHERE firstName LIKE 'L%'
    UNION ALL
    SELECT city FROM customers
    WHERE customerName LIKE 'L%'
) AS merged_data
GROUP BY city
ORDER BY jumlah_karyawan_pelanggan_L DESC
LIMIT 1;

-- 3

SELECT firstname AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee_count)
        FROM (
            SELECT COUNT(*) AS employee_count
            FROM employees
            GROUP BY officeCode
        ) AS office_counts
    )
)
UNION ALL
SELECT contactFirstName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee_count)
            FROM (
                SELECT COUNT(*) AS employee_count
                FROM employees
                GROUP BY officeCode
            ) AS office_counts
        )
    )
)
ORDER BY `nama karyawan/pelanggan`;

-- 4

SELECT tanggal, GROUP_CONCAT(riwayat1 ORDER BY riwayat1 ASC SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat1
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat2
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS combined_data
GROUP BY tanggal
ORDER BY tanggal;
