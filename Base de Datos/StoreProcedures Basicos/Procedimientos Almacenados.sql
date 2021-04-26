USE Northwind
GO
-- ********************************************** --
-- * EN CASO DE QUE LOS OBJETOS HAYAN SIDO		* --
-- * CREADOS CON ANTERIORIDAD, ELIMINARLOS		* --
-- * CON LOS SIGUIENTES DROP					* --
-- * CESAR HERNANDEZ OBISPO						* --
-- ********************************************** --
		--DROP TABLE SGBD_CLASE.BD_VIERNES
		--DROP TABLE SGBD_CLASE.CLIENTES
		--DROP PROCEDURE SGBD_CLASE.CONSULTA_COMPLETA
		--DROP PROCEDURE SGBD_CLASE.SP_IUDCliente
		--DROP TABLE SGBD_CLASE.Categorias
		--DROP PROCEDURE SGBD_CLASE.sp_CreateView1997
		--DROP VIEW SGBD_CLASE.View1997
		--DROP SCHEMA SGBD_CLASE

-- 1.- Creacion de un nuevo esquema
CREATE SCHEMA SGBD_CLASE
GO

-- 2.- Creacion de nueva tabla que este contenida en nuestro nuevo esquema
CREATE TABLE SGBD_CLASE.BD_VIERNES
(
	ID INT,
	NOMBRE VARCHAR(50)
)
GO

-- 3.- Consulta de nuestra nueva tabla
SELECT * FROM SGBD_CLASE.BD_VIERNES
GO

-- 4.- Copia de respaldo de una tabla
SELECT * INTO SGBD_CLASE.CLIENTES FROM Customers
GO

-- 5.- Creacion de un procedimiento almacenado 
CREATE PROCEDURE SGBD_CLASE.CONSULTA_COMPLETA
AS
BEGIN
	SELECT 
		ProductName 'Producto', Products.UnitPrice 'Precio', Categories.CategoryName 'Categoria'
	FROM
		Products, Categories
	WHERE Products.CategoryID=Categories.CategoryID
	ORDER BY UnitPrice
END
GO

EXEC SGBD_CLASE.CONSULTA_COMPLETA
GO


-- 6 .- Creacion de un procedimiento almacenado que realice la funcion de Insertar, Actualizar o eliminar
CREATE PROCEDURE SGBD_CLASE.SP_IUDCliente
@Sentencia VARCHAR(50),
@CustomerID nchar(5),
@CompanyName nvarchar(40) NULL,
@ContactName nvarchar(30) NULL,
@ContactTitle nvarchar(30) NULL,
@Address nvarchar(60) NULL,
@City nvarchar(15) NULL,
@Region nvarchar(15),
@PostalCode nvarchar(10) NULL,
@Country nvarchar(15) NULL,
@Phone nvarchar(24) NULL,
@Fax nvarchar(24) NULL
AS
BEGIN

	IF @Sentencia='INSERT'
	BEGIN
		INSERT INTO SGBD_CLASE.CLIENTES
		VALUES(@CustomerID,@CompanyName,@ContactName,@ContactTitle,@Address,@City,@Region,@PostalCode,@Country,@Phone,@Fax)
	END

	ELSE IF @Sentencia='UPDATE'
	BEGIN
		UPDATE SGBD_CLASE.CLIENTES
		SET 
			ContactName=@ContactName
		WHERE CustomerID=@CustomerID
	END

	ELSE IF @Sentencia='DELETE'
	BEGIN
		DELETE SGBD_CLASE.CLIENTES
		WHERE CustomerID=@CustomerID
	END

	ELSE
	BEGIN
		PRINT 'No se encontro ninguna opcion con la descripcion '+@Sentencia
	END
END
GO

EXEC SGBD_CLASE.SP_IUDCliente 'Insert','HOLA','FIME','ROBERTO','AGENTE','NL','MTY','D','67250','MEXICO','0000000000','ROBERTO@GMAIL.COM'
GO
EXEC SGBD_CLASE.SP_IUDCliente 'UPDATE','HOLA','','ROBERTO FERNANDEZ','','','','','','','',''
GO
EXEC SGBD_CLASE.SP_IUDCliente 'DELETE','HOLA','','','','','','','','','',''
GO
EXEC SGBD_CLASE.SP_IUDCliente 'NoExiste','HOLA','','','','','','','','','',''
GO

-- 7 Creacion de un procedimiento almacenado que genere una vista
CREATE PROCEDURE SGBD_CLASE.sp_CreateView1997
AS
BEGIN
	IF (EXISTS(SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA='SGBD_CLASE' AND TABLE_NAME='View1997'))
	BEGIN
		DROP VIEW SGBD_CLASE.View1997
	END
	DECLARE @sentencia nvarchar(1000)
	SET @sentencia='CREATE VIEW SGBD_CLASE.View1997 AS
		SELECT
			(SELECT Employees.FirstName+CHAR(32)+Employees.LastName FROM Employees WHERE Orders.EmployeeID=Employees.EmployeeID) AS "Nombre Empleado",
			ProductName,
			(SELECT CategoryName FROM Categories WHERE Categories.CategoryID=Products.CategoryID) "Categoria"
		FROM
			[Order Details], Orders,Products

		WHERE[Order Details].OrderID in(SELECT Orders.OrderID FROMOrders WHERE YEAR(OrderDate)=1997) 
			and  [Order Details].OrderID=Orders.OrderID 
			and [Order Details].ProductID=Products.ProductID'
	EXEC sp_executesql @sentencia
END
GO
EXEC SGBD_CLASE.sp_CreateView1997
GO

-- 8.- Copia de una tabla => validar que si existe, se debe borrar para volver a crear
IF (EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Categorias' and TABLE_SCHEMA='SGBD_CLASE'))
BEGIN
	DROP TABLE SGBD_CLASE.Categorias
END
GO
SELECT * INTO SGBD_CLASE.Categorias FROM [dbo].[Categories]
GO