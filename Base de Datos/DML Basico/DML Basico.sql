-- 1. Select the total (sum) of products of the order 10248.
SELECT SUM(Quantity) 'Total de productos' FROM [Order Details] WHERE OrderID=10248 

-- 2. Insert a client by completing all the fields in the table.

INSERT INTO Customers
VALUES('FIMAT','Fisico Matematico','Cesar Hernandez','Student','San sixto 132','Juarez NL','MX','67250','Mexico','8111754519','8111754519');

-- 3. Update the name of the new customer by passing the ID number obtained in point 2.
UPDATE Customers 
SET ContactName='Cesar Hernandez Obispo'
WHERE CustomerID='FIMAT'

-- 4. Delete the client inserted in point 2
DELETE Customers
WHERE CustomerID='FIMAT'

-- 5. Select the most expensive and cheapest product.
SELECT * FROM Products
WHERE UnitPrice=(SELECT MAX(UnitPrice) FROM Products) OR
	  UnitPrice=(SELECT MIN(UnitPrice) FROM Products)

-- 6. Select products whose existence is between 15 and 39 pieces
SELECT * FROM Products WHERE UnitsInStock between 15 and 39

-- 7. Select the suppliers whose contact title is marketing manager.
SELECT * FROM Suppliers WHERE ContactTitle='Marketing Manager'

-- 8. Select the product name, unit price and quantities in stock, of all products that have been sold in the USA.
SELECT Products.ProductID,Products.ProductName, Products.UnitPrice,Products.UnitsInStock FROM Products WHERE 
Products.ProductID in (
SELECT [Order Details].ProductID FROM Orders 
INNER JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
WHERE ShipCountry='USA'
GROUP BY [Order Details].ProductID
)
ORDER BY ProductID

-- 9. Select customers whose country is the United States (USA).
SELECT * FROM Customers WHERE Country='USA'

-- 10. Select products that belong to the supplier New Orleans Cajun Delights.
SELECT * FROM Products WHERE SupplierID=(SELECT SupplierID FROM Suppliers WHERE Suppliers.CompanyName='New Orleans Cajun Delights')

-- 11. Select all orders of customer Hanari Carnes.
SELECT * FROM Orders WHERE CustomerID=(SELECT CustomerID FROM Customers WHERE Customers.CompanyName='Hanari Carnes')

-- 12. Select the employee, product category and the product, of all the employees that processed the order in 1997.
SELECT 
	(SELECT Employees.FirstName+' '+Employees.LastName FROM Employees WHERE Orders.EmployeeID=Employees.EmployeeID)  'Nombre Empleado',
	ProductName,
	(SELECT CategoryName FROM Categories WHERE Categories.CategoryID=Products.CategoryID) 'Categoria'
FROM [Order Details] INNER JOIN Orders ON [Order Details].OrderID=Orders.OrderID
					 INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
WHERE [Order Details].OrderID IN (SELECT Orders.OrderID FROM Orders WHERE YEAR(OrderDate)='1997') 

-- 13.Select customers whose country is USA, SPAIN, ITALY
SELECT * FROM Customers WHERE Country in ('USA','SPAIN','ITALY')
-- 14. Select the cheapest shipping order, the average shipping and the most expensive shipping
SELECT Freight FROM Orders WHERE Freight in ((SELECT MIN(Freight) FROM Orders),(SELECT MAX(Freight) FROM Orders))
SELECT AVG(Freight) FROM Orders

SELECT MIN(Freight) 'Valor minimo', AVG(Freight) 'Promedio',MAX(Freight) 'Valor Maximo' FROM Orders

-- 15. Select the products, whose orders (including your customers) were sent to France.
SELECT (SELECT ProductName FROM Products where Products.ProductID=[Order Details].ProductID) 'Nombre Producto',
		(SELECT Customers.CompanyName FROM Customers WHERE Customers.CustomerID=Orders.CustomerID) 'Cliente' 
FROM [Order Details]
INNER JOIN Orders on [Order Details].OrderID=Orders.OrderID
WHERE [Order Details].OrderID in (SELECT OrderID FROM Orders WHERE ShipCountry='France')

-- 16. Select the orders whose sale date was between January 27, 1997 to March 24, 1997.
SELECT * FROM Orders WHERE Orders.OrderDate between '1997-01-27' and '1997-03-24'