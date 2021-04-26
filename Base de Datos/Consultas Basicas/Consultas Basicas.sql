-- 1. Select all clients that do not have FAX and a Region, from the Country of Germany.
select * from Customers where FAX is NULL AND Country='Germany'
go

-- 2. Show products whose price ranges between 25 and 55 dollars.
select * from Products where UnitPrice between 25 AND 55
go

-- 3. Select OrderDate, the ProductName  and the UnitPrice of the order made by CustomerID 635.
select 
		Orders.OrderDate,
		(select ProductName from Products where [Order Details].ProductID=Products.ProductID) 
		as 'Nombre Producto',
		[Order Details].UnitPrice 
from Orders 
inner join [Order Details] on [Order Details].OrderID=Orders.OrderID
where CustomerID='ALFKI'
go

-- 4. Select the product name and the CompanyName for all 
select Products.ProductName, (select Customers.CompanyName from Customers where Orders.CustomerID=Customers.CustomerID) from [Order Details] 
inner join Products on [Order Details].ProductID=Products.ProductID
inner join Orders on Orders.OrderID=[Order Details].OrderID
where ProductName='Gula Malacca'

--5. Show products that belong to the category condiments and dairy products.
select ProductName from Products inner join Categories on Products.CategoryID=Categories.CategoryID
where Categories.CategoryName='condiments'  OR Categories.CategoryName='Dairy Products'

--6. Select the product description for culture 'fr' for product.
select ProductName from Products inner join Categories
on Products.CategoryID=Categories.CategoryID
where Categories.Description like '%fr%'

--7. Show the number, maximum and minimum by price category.
select * from Products

--8. Select use the SubTotal value in Sale Order Header to list orders from the largest to the smallest. For each order show the Company Name and the SubTotal and the total weight of the order.


--9. Select  the CompanyName for all customers with an address in City 'Dallas'.
select CompanyName from Customers where City='dallas'


--10. Select how many products of ProductCategory 'Cranksets' have been sold to an address in 'London'?
select SUM(Quantity) 'Cantidad de Productos Vendidos' from [Order Details]
inner join Products on [Order Details].ProductID=Products.ProductID
inner join Orders on [Order Details].OrderID=Orders.OrderID
where [Order Details].ProductID=(select CategoryID from Categories where CategoryName='Seafood') and Orders.ShipCountry='USA'
group by [Order Details].ProductID

--11. Show accounts orders each employee has made (show the name and surname in a single column and number of orders).
 select 
	OrderID,
	(select Employees.FirstName+' '+Employees.LastName from Employees where Employees.EmployeeID=Orders.EmployeeID) 'Nombre'
 from Orders
 order by EmployeeID 

--12. Show the quantity of products by category, selecting the name of the category and the number of products of this category,
-- as well as the accounting of its price for the stock of all products and their existence.
select SUM(UnitsInStock) as 'Stock',
(select CategoryName from Categories where Products.CategoryID=Categories.CategoryID) as 'Nombre Categoria', 
count(Products.ProductID) 'Total de productos'
from Products inner join Categories
on Categories.CategoryID=Products.CategoryID
group by Products.CategoryID

--13. Shows the name of the employee, the customer, and the products of your order whose discount on your ticket is greater than 300.
select (select Employees.FirstName+' '+LastName from Employees where Employees.EmployeeID=Orders.EmployeeID) as 'nombre Empleado', 
		(select Customers.CompanyName from Customers where Customers.CustomerID=Orders.CustomerID) as 'Nombre Compañia',
		(select ProductName from Products where [Order Details].ProductID=Products.ProductID) as 'Nombre Producto'
from [Order Details] inner join Orders on [Order Details].OrderID=Orders.OrderID
where [Order Details].Discount>0.10




1. Select all clients that do not have FAX and a Region, from the Country of Germany.
2. Show products whose price ranges between 25 and 55 dollars.
3. Select OrderDate, the ProductName  and the UnitPrice of the order made by CustomerID 635.
4. Select the product name and the CompanyName for all Customers who ordered Product Name 'Gula Malacca'.
5. Show products that belong to the category condiments and dairy products.
6. Select the product description for culture 'fr' for product.
7. Show the number, maximum and minimum by price category.
8. Select use the SubTotal (UnitPrice and Quantity) value in Sale Order detail to list orders from the largest to the smallest. For each order show the Company Name and the SubTotal and the total weight of the order.
9. Select  the CompanyName for all customers with an address in City 'Dallas'.
10. Select how many products of ProductCategory 'Seafood' have been sold to an address in 'USA'?
11. Show accounts orders each employee has made (show the name and surname in a single column and number of orders).
12. Show the quantity of products by category, selecting the name of the category and the number of products of this category, as well as the accounting of its price for the stock of all products and their existence.
13. Shows the name of the employee, the customer, and the products of your order whose discount on your ticket is greater than 10.