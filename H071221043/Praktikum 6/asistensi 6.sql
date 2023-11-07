SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'EmployeeName', COALESCE(SUM(p.amount), 0) AS 'TotalSales'
FROM employees e
left JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.firstName, e.lastName
ORDER BY 'TotalSales' DESC;

SELECT p.productline, SUM(od.priceEach *  od.quantityOrdered) AS 'TotalSales', concat(p.productname , '(', max(od.priceEach *  od.quantityOrdered),')') AS 'BestSellingProduct'
FROM products p
left JOIN orderdetails od
USING(productCode)
GROUP BY p.productline ;