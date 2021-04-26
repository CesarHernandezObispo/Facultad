--1. Select all clients that do not have FAX and a Region, from the Country of Germany.
SELECT * FROM Customers WHERE (FAX IS NULL) AND (Region IS NULL)
AND Country='Germany'

--2. Show products whose price ranges between 25 and 55 dollars.
SELECT * FROM Products WHERE UnitPrice >= 25 and UnitPrice <=55

--3. Select OrderDate, the ProductName  and the UnitPrice of the order made by CustomerID 635.

SELECT 
	Orders.OrderDate, 
	Products.ProductName, 
	Products.UnitPrice
FROM Orders, [Order Details], Products 
WHERE 
	Orders.CustomerID='ALFKI'
	AND [Order Details].OrderID=Orders.OrderID
	AND [Order Details].ProductID=Products.ProductID
ORDER BY  Products.ProductName

--4. Select the product name and the CompanyName for all Customers who ordered Product Name 'Gula Malacca'.
SELECT 
	ProductName 'Nombre del producto', 
	Suppliers.CompanyName 'Provedor', 
	Customers.ContactName 'Cliente'
FROM Customers 
	INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
	INNER JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
	INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
	INNER JOIN Suppliers ON Products.SupplierID= Suppliers.SupplierID
WHERE ProductName='Gula Malacca'

--5. Show products that belong to the category condiments and dairy products.
SELECT 
	Products.ProductName 'Nombre del Producto',
	Categories.CategoryName 'Categoria' , 
	Suppliers.CompanyName  'Nombre del provedor'
FROM Products  
	INNER JOIN Categories  ON Products.CategoryID=Categories.CategoryID
	INNER JOIN Suppliers  ON Products.SupplierID=Suppliers.SupplierID
WHERE Categories.CategoryName='Condiments' or Categories.CategoryName='Dairy Products'
ORDER BY Products.ProductName

--6. Select the product description for culture 'fr' for product.
SELECT Categories.[Description] 
FROM Products
	INNER JOIN Categories ON Categories.CategoryID=Products.CategoryID
WHERE Products.ProductName like '%fr%'

--7. Show the number, maximum and minimum by price category.
SELECT 
	Products.ProductName 'Nombre producto', 
	Categories.CategoryName 'Categoria', 
	Products.unitprice 'Precio Unitario',
	Customers.CompanyName 'Provedor', 
	(Employees.Firstname +' '+Employees.LastName) 'Nombre empleado'
FROM [Order Details]
	INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
	INNER JOIN Categories  ON Categories.CategoryID=Products.CategoryID
	INNER JOIN Orders ON [Order Details].OrderID=Orders.OrderID
	INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
	INNER JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID
WHERE Products.unitprice = (SELECT MIN(unitprice) FROM products)
	  OR Products.UnitPrice = (SELECT MAX (unitprice) FROM products)

--8. Select use the SubTotal (UnitPrice and Quantity) value in Sale Order detail to list orders from the largest to the smallest. For each order show the Company Name and the SubTotal and the total weight of the order.
SELECT 
	Customers.CompanyName, 
	([Order Details].UnitPrice * [Order Details].Quantity) 'Subtotal', 
	(([Order Details].UnitPrice * [Order Details].Quantity) - [Order Details].Discount) 'Total'
FROM [Order Details] 
INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
ORDER BY 'Total'

--9. Select  the CompanyName for all customers with an address in City 'London'.
SELECT 
	CompanyName, 
	[Address] 
FROM Customers 
WHERE City='London'


--10. Select how many products of ProductCategory 'Seafood' have been sold to an address in 'USA'?
SELECT COUNT(Customers.Country) AS 'Cantidad de productos' 
FROM Products
	INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
	INNER JOIN [Order Details] ON Products.ProductID =[Order Details].ProductID
	INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
	INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.ShipCountry= 'USA' 
	  AND Categories.CategoryName = 'Seafood'

--11. Show accounts orders each employee has made (show the name and surname in a single column and number of orders).
SELECT 
	   COUNT(*) 'Numero de Ordenes', 
	   CONCAT(Employees.FirstName,' ', Employees.LastName) 'Nombre completo' 
FROM Orders
	INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 
GROUP BY Employees.FirstName,Employees.LastName

--12. Show the quantity of products by category, selecting the name of the category and the number of products of this category, as well as the accounting of its price for the stock of all products and their existence.

SELECT Categories.CategoryName, 
	COUNT(Products.UnitsInStock) 'Cantidad', 
	SUM(Products.UnitPrice * Products.UnitsInStock) 'Valor Total'
FROM Categories  
	INNER JOIN Products ON Categories.CategoryID=Products.CategoryID
GROUP BY Categories.CategoryName
 

--13. Shows the name of the employee, the customer, and the products of your order whose discount on your ticket is greater than 10.

SELECT CONCAT(Employees.FirstName,' ', Employees.LastName) as 'Empleado' ,
		Products.ProductName, 
		Customers.ContactName as 'Cliente', 
		[Order Details].Discount 
FROM Products  
    INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
    INNER JOIN [Order Details] ON Products.ProductID =[Order Details].ProductID
    INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
    INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
    INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName,
		 Employees.LastName, 
		 Products.ProductName, 
		 Customers.ContactName, 
		 [Order Details].Discount
HAVING ([Order Details].Discount) >.1
