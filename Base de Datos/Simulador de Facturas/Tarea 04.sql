CREATE DATABASE DBFacturas
GO

USE DBFacturas
GO

CREATE TABLE Proveedores(
	idProveedor INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
	razonSocial VARCHAR(MAX),
	rfcProveedor VARCHAR(13) UNIQUE NOT NULL,
	direccion VARCHAR(70) NOT NULL,
	telefono VARCHAR(10) NULL,
	email VARCHAR(30) NULL
)
GO

CREATE TABLE FacturasProveedor(
	idFactura INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	rfcProveedor VARCHAR(13) NOT NULL,
	folioFiscal VARCHAR(32) NOT NULL,
	fechaEmision DATE NOT NULL,
	descripcion VARCHAR(MAX) NOT NULL,
	estatus VARCHAR(2) NOT NULL,
	total FLOAT NOT NULL,
	formaPago INT NOT NULL,
	metodoPago VARCHAR(5) NOT NULL,
	usoCFDI VARCHAR(3) NOT NULL,
	claveProducto INT NOT NULL,
	claveUnidad VARCHAR(30) NOT NULL,
	FOREIGN KEY (rfcProveedor) 
	REFERENCES proveedores(rfcProveedor)
)
GO

CREATE TABLE FacturasRechazadas(
	idError INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	folioFiscal VARCHAR(32) NOT NULL,
	rfcProveedor VARCHAR(13) NOT NULL,
	fechaDeRechazo DATE NULL DEFAULT GETDATE(),
	descripcionError VARCHAR(MAX) NOT NULL,
	FOREIGN KEY (rfcProveedor) REFERENCES Proveedores(rfcProveedor)
)
GO

CREATE TABLE DatosValidacionFacturas(
	idDato INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	valor VARCHAR(50) NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	estatus VARCHAR(2) NOT NULL
)
GO



CREATE PROCEDURE spPractica04
AS
BEGIN
	-- Borrado del contanido de todas las tablas
	DELETE FROM FacturasProveedor
	DELETE FROM FacturasRechazadas
	DELETE FROM proveedores
	DELETE FROM DatosValidacionFacturas
	

	-- 1. Insert de forma manual con datos Ficticios 
	INSERT INTO Proveedores (razonSocial, rfcProveedor, direccion, telefono, email) VALUES
	('Gabtype','NOCI880504LT5' , '237 Bobwhite Alley', '7369910969', 'tbishopp0@va.gov'),
	('Pixope','YEGJ5604277XA', '86 Farragut Way', '3431953275', 'fmellings1@webs.com'),
	('Zoozzy','TACR630510Q14', '9 Hudson Crossing', '4808619619', 'rgulliman2@webs.com'),
	('Oba', 'FCT690317MW6', '5 Mifflin Lane', '2324891088', 'jocooney3@tripod.com'),
	('Oyoyo', 'OCE050214NX3', '69 5th Place', '8739005339', 'deschalette4@techcrunch.com'),
	('Dabshots','MAJR50050165A', '0861 Moland Parkway', '2906948740', 'aprewett5@mysql.com'),
	('Twiyo', 'MMI950125KG8', '3674 Fremont Court', '7858028452', 'vbrinsford6@fotki.com'),
	('Shuffletag','IHS0009013W2', '31 Schiller Point', '7862566054', 'rmityushin7@shinystat.com'),
	('Tagcat','REF960307LI1', '011 Utah Circle', '6706078381', 'sbridge8@columbia.edu'),
	('Devify','PFA160506KF3', '797 Goodland Parkway', '2849035890', 'byeats9@shinystat.com'),
	('Tazzy','FMA991109GT7', '7 Buena Vista Avenue', '9546093537', 'dhickforda@about.me'),
	('Zoombox','JANM570414JP8', '1544 Cambridge Plaza', '5898829658', 'droseburghb@wp.com'),
	('Tagchat','SRM980701STA', '637 Marcy Circle', '9769458383', 'ggoulstonc@marriott.com'),
	('Yombu', 'LIN080507S67', '3 Center Avenue', '3453599777', 'mradnaged@foxnews.com'),
	('Oozz','TLE1211165V0', '690 David Terrace', '9295421428', 'dadlingtone@biglobe.ne.jp');

	-- 2. Copia de Inserts del archivo DatosFacturas.txt
	INSERT INTO FacturasProveedor (rfcProveedor,FOLIOFISCAL,FECHAEMISION,DESCRIPCION,estatus,TOTAL,FORMAPAGO,metodoPago,USOCFDI,claveProducto,CLAVEUNIDAD) values 
	('NOCI880504LT5','8A917F1F-1308-4468-81D8-CB308CEF',CONVERT(date,'09/09/20',3),'MANTENIMIENTO MES DE SEPTIEMBRE','01',18001.47,'03','PUE','P01','80131502','E48'),
	('NOCI880504LT5','D9C22F37-D82C-41F7-A16C-C0F8BB54',CONVERT(date,'09/09/20',3),'Pago','01',0,'03','PUE','P01','84111506','ACT'),
	('YEGJ5604277XA','391CE067-A741-4BA9-B103-97D08A5E',CONVERT(date,'09/09/20',3),'RENTA DE LOCAL UBICADO EN: SEPTIEMBRE 2020','01',25870.3,'03','PUE','G03','80131502','E48'),
	('NOCI880504LT5','2646EBA1-47A6-4B16-81A7-D996949D',CONVERT(date,'09/09/20',3),'RENTA MES DE SEPTIEMBRE','01',11095.35,'03','PUE','P01','80131502','E48'),
	('TACR630510Q14','2FB40C4E-F457-4A97-BE7C-A1449420',CONVERT(date,'08/09/20',3),'RENTA DEL LOCAL, MES DE SEPTIEMBRE DE 2020','01',32370.25,'03','PUE','G03','80131502','E48'),
	('FCT690317MW6', '21EF03C0-0329-F94A-8556-B9A9396A',CONVERT(date,'09/09/20',3),'Pago','01',0,'03','PPD','P01','84111506','ACT'),
	('OCE050214NX3','09487E8B-901F-4710-91A3-208D3C51',CONVERT(date,'01/09/20',3),'RENTA DE LOCAL COMERCIAL E INDUSTRIAL','01',30304.93,'03','PUE','P01','80131502','E48'),
	('FCT690317MW6','3C96BCB0-E7CB-4B4E-ACFA-622CEBEA',CONVERT(date,'01/09/20',3),'RENTA DEL MES ABRIL 2020','01',53337.84,'99','PPD','G03','80131500','E48'),
	('FCT690317MW6','E1935A56-A266-D449-ADF5-2FA3DE97',CONVERT(date,'01/09/20',3),'RENTA DEL MES SEPTIEMBRE 2020','01',152393.84,'99','PPD','G03','80131500','E48'),
	('MAJR50050165A','AAA148DB-6A0E-4305-B0D1-A95F702F',CONVERT(date,'03/09/20',3),'RENTA DEL MES DE SEPTIEMBRE DEL 2020','01',44633.19,'03','PUE','G03','80131500','E48'),
	('MMI950125KG8','037F7C5A-11A2-4375-B622-65F4B3F2',CONVERT(date,'01/09/20',3),'COMISIONES','01',1113.6,'03','PUE','G03','84121500','E48'),
	('IHS0009013W2','99d60adc-c19d-449a-a238-b18aeb92',CONVERT(date,'25/09/20',3),'Renta','01',145000,'03','PUE','G03','80131503','E48'),
	('REF960307LI1','6972432E-293E-4E1F-BE3D-F069505F',CONVERT(date,'10/09/20',3),'RENTA DE LOCAL COMERCIAL MES DE SEPTIEMBRE DE 2020','01',211077.53,'99','PPD','P01','80131502','CE'),
	('PFA160506KF3','EDE43C91-E872-45EC-AD5C-BC15899B',CONVERT(date,'01/09/20',3),'RENTA DE LOCAL INDUSTRIAL MES DE SEPTIEMBRE DE 2020','01',1452,'03','PUE','G03','80131501','E48'),
	('FMA991109GT7','8ffb0ced-4e8c-4b74-a638-5999d71a',CONVERT(date,'13/09/20',3),'RENTAS DE LOCAL COMERCIAL','01',208744.04,'03','PUE','G03','80131500','MTK'),
	('JANM570414JP8','DAEC6444-564D-42EA-991B-13FFE6CE',CONVERT(date,'01/09/20',3),'RENTA DEL MES DE SEPTIEMBRE DEL  2020','01',108635.85,'03','PUE','G03','80131500','MON'),
	('SRM980701STA','25d93860-1d81-4d2d-b5c5-ec728950',CONVERT(date,'23/09/20',3),'SERVICIOS ADMINISTRATIVOS (RED,AGUA,LUZ) SEPTIEMBRE 2020','01',273528.97,'99','PPD','G03','80101500','E48'),
	('SRM980701STA','2b69d9da-2f49-43bb-b0d9-5e84b4d3',CONVERT(date,'04/09/20',3),'SERVICIOS ADMINISTRATIVOS JULIO 2020','01',60920.46,'99','PPD','G03','80101500','NA'),
	('LIN080507S67','710CDAF7-C550-42CD-A2EE-FF6C33BB',CONVERT(date,'01/09/20',3),'MANTENIMIENTO SEPTIEMBRE 2020. CUENTA 10-005-008','01',492.03,'99','PPD','G03','72101507','E48'),
	('TLE1211165V0','5A8828CB-F521-11EA-9678-00155D01',CONVERT(date,'12/09/20',3),'Intereses moratorios por atraso en el pago','01',7020.24,'03','PUE','G03','84101703','E48');

	-- 3.- Copiar los inserts que vienen en el txt DatosValidacion
	Insert into DatosValidacionFacturas (VALOR,DESCRIPCION,ESTATUS) values 
	('80131502','Clave Producto/Servicio','SI'),
	('80131500','Clave Producto/Servicio','SI'),
	('84111506','Clave Producto/Servicio','SI'),
	('03','Forma de Pago','SI'),
	('P01','Uso CFDI','SI'),
	('PUE','Metodo de Pago','SI'),
	('DLS','Metodo de Pago','NO'),
	('30181800','Clave Producto/Servicio','NO'),
	('H87','Clave Unidad','NO'),
	('40','Clave Unidad','NO'),
	('01','Forma de Pago','NO'),
	('E48','Clave Unidad','SI'),
	('G03','Uso CFDI','SI'),
	('PPD','Metodo de Pago','SI'),
	('02','Forma de Pago','SI'),
	('ACT','Clave Unidad','SI'),
	('99','Forma de Pago','SI');
	
	-- 4. Validar que cada registro de la tabla de Facturas Proveedor 
	-- sea válido realizando una comparación contra la tabla de Datos Validación Facturas. 
	-- Pero solo de aquellos registros, cuyo estatus sea igual a SI.

	-- Cursor para Forma de Pago
	DECLARE ErrorFacturaFormaPago CURSOR FOR(
		SELECT 
			folioFiscal,rfcProveedor,'Forma de pago'  as 'Error' 
		FROM 
			FacturasProveedor 
		where 
			(formaPago not in (select valor from DatosValidacionFacturas where estatus='SI' and descripcion='Forma de Pago' ))
	)

	-- Cursor para Metodo de Pago
	DECLARE ErrorFacturaMetodoPago CURSOR FOR(
		select 
			folioFiscal,rfcProveedor,'Metodo de pago'  as 'Error' 
		from 
			FacturasProveedor 
		where 
			(metodoPago not in (select valor from DatosValidacionFacturas where estatus='SI' and descripcion='Metodo de Pago'))
	)	
	-- Cursor para UsoCFDI
	DECLARE ErrorFacturaUsoCFDI CURSOR FOR(
		select 
			folioFiscal,rfcProveedor,'Uso CFDI'  as 'Error'
		from 
			FacturasProveedor 
		where 
			(usoCFDI not in (select valor from DatosValidacionFacturas where estatus='SI' and descripcion='Uso CFDI'))
	)
	-- Cursor para Clave Producto Servicio
	DECLARE ErrorFacturaProductoServicio CURSOR FOR (
		select 
			folioFiscal,rfcProveedor,'Clave Producto/Servicio'  as 'Error'
		from 
			FacturasProveedor 
		where 
			(claveProducto not in (select valor from DatosValidacionFacturas where estatus='SI' and descripcion='Clave Producto/Servicio'))
	)
	-- Cursor para Clave Unidad
	DECLARE ErrorFacturaClaveUnidad CURSOR FOR (
		select 
			folioFiscal,rfcProveedor,'Clave Unidad'  as 'Error'
		from 
			FacturasProveedor 
		where 
			(claveUnidad not in (select valor from DatosValidacionFacturas where estatus='SI' and descripcion='Clave Unidad'))
	)
	
	-- Apertura de cursores
	OPEN ErrorFacturaFormaPago
	OPEN ErrorFacturaMetodoPago
	OPEN ErrorFacturaUsoCFDI
	OPEN ErrorFacturaProductoServicio
	OPEN ErrorFacturaClaveUnidad

	-- Declaracion de variables
	DECLARE @folioFiscal varchar(32),@rfcProveedor varchar(13),@Error varchar(MAX)

	-- Recorrido de cursor Forma de Pago
	FETCH NEXT FROM ErrorFacturaFormaPago INTO @folioFiscal,@rfcProveedor,@Error
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF EXISTS (SELECT * FROM FacturasRechazadas WHERE @folioFiscal=folioFiscal)
		BEGIN 
			UPDATE FacturasRechazadas SET descripcionError=descripcionError+', '+@Error WHERE folioFiscal=@folioFiscal
		END
		ELSE 
		BEGIN
			INSERT INTO FacturasRechazadas (folioFiscal,rfcProveedor,descripcionError) VALUES(@folioFiscal,@rfcProveedor,@Error)
			UPDATE FacturasProveedor SET estatus='I' WHERE folioFiscal=@folioFiscal
		END
		FETCH NEXT FROM ErrorFacturaFormaPago INTO  @folioFiscal,@rfcProveedor,@Error
	END

	-- Recorrido de cursor Metodo de Pago
	FETCH NEXT FROM ErrorFacturaMetodoPago INTO @folioFiscal,@rfcProveedor,@Error
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF EXISTS (SELECT * FROM FacturasRechazadas WHERE @folioFiscal=folioFiscal)
		BEGIN 
			UPDATE FacturasRechazadas SET descripcionError=descripcionError+', '+@Error WHERE folioFiscal=@folioFiscal
		END
		ELSE 
		BEGIN
			INSERT INTO FacturasRechazadas (folioFiscal,rfcProveedor,descripcionError) VALUES(@folioFiscal,@rfcProveedor,@Error)
			UPDATE FacturasProveedor SET estatus='I' WHERE folioFiscal=@folioFiscal
		END
		FETCH NEXT FROM ErrorFacturaMetodoPago INTO  @folioFiscal,@rfcProveedor,@Error
	END

	-- Recorrido de cursor Uso CFDI
	FETCH NEXT FROM ErrorFacturaUsoCFDI INTO @folioFiscal,@rfcProveedor,@Error
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF EXISTS (SELECT * FROM FacturasRechazadas WHERE @folioFiscal=folioFiscal)
		BEGIN 
			UPDATE FacturasRechazadas SET descripcionError=descripcionError+', '+@Error WHERE folioFiscal=@folioFiscal
		END
		ELSE 
		BEGIN
			INSERT INTO FacturasRechazadas (folioFiscal,rfcProveedor,descripcionError) VALUES(@folioFiscal,@rfcProveedor,@Error)
			UPDATE FacturasProveedor SET estatus='I' WHERE folioFiscal=@folioFiscal
		END
		FETCH NEXT FROM ErrorFacturaUsoCFDI INTO  @folioFiscal,@rfcProveedor,@Error
	END

	-- Recorrido de cursor Producto/Servicio
	FETCH NEXT FROM ErrorFacturaProductoServicio INTO @folioFiscal,@rfcProveedor,@Error
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF EXISTS (SELECT * FROM FacturasRechazadas WHERE @folioFiscal=folioFiscal)
		BEGIN 
			UPDATE FacturasRechazadas SET descripcionError=descripcionError+', '+@Error WHERE folioFiscal=@folioFiscal
		END
		ELSE 
		BEGIN
			INSERT INTO FacturasRechazadas (folioFiscal,rfcProveedor,descripcionError) VALUES(@folioFiscal,@rfcProveedor,@Error)
			UPDATE FacturasProveedor SET estatus='I' WHERE folioFiscal=@folioFiscal
		END
		FETCH NEXT FROM ErrorFacturaProductoServicio INTO  @folioFiscal,@rfcProveedor,@Error
	END

	-- Recorrido de cursor Clave Unidad
	FETCH NEXT FROM ErrorFacturaClaveUnidad INTO @folioFiscal,@rfcProveedor,@Error
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF EXISTS (SELECT * FROM FacturasRechazadas WHERE @folioFiscal=folioFiscal)
		BEGIN 
			UPDATE FacturasRechazadas SET descripcionError=descripcionError+', '+@Error WHERE folioFiscal=@folioFiscal
		END
		ELSE 
		BEGIN
			INSERT INTO FacturasRechazadas (folioFiscal,rfcProveedor,descripcionError) VALUES(@folioFiscal,@rfcProveedor,@Error)
			UPDATE FacturasProveedor SET estatus='I' WHERE folioFiscal=@folioFiscal
		END
		FETCH NEXT FROM ErrorFacturaClaveUnidad INTO  @folioFiscal,@rfcProveedor,@Error
	END

	-- Cerrar Cursores 
	CLOSE ErrorFacturaFormaPago
	CLOSE ErrorFacturaMetodoPago
	CLOSE ErrorFacturaUsoCFDI
	CLOSE ErrorFacturaClaveUnidad
	CLOSE ErrorFacturaProductoServicio
	
	-- Eliminar Cursores
	DEALLOCATE ErrorFacturaFormaPago
	DEALLOCATE ErrorFacturaMetodoPago
	DEALLOCATE ErrorFacturaUsoCFDI
	DEALLOCATE ErrorFacturaClaveUnidad
	DEALLOCATE ErrorFacturaProductoServicio

	UPDATE FacturasProveedor SET estatus='V' WHERE estatus!='I' 

	-- 5. Crear una vista que presente la siguiente información.
	IF(EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='vistaFacturaFinal'))
	BEGIN
		DROP VIEW vistaFacturaFinal
	END

	DECLARE @sentencia nvarchar(1000)='
	CREATE VIEW vistaFacturaFinal
	AS
	SELECT 
		razonSocial as [Proveedor],
		FacturasProveedor.rfcProveedor as [RFC],
		folioFiscal as [UUID Factura],
		descripcion as [Efecto],
		case estatus
			WHEN char(86) THEN ''Valido''
			WHEN char(73) THEN ''Invalido''
		END as [Estatus],
		total as [Monto Factura]
	FROM FacturasProveedor 
	INNER JOIN Proveedores ON Proveedores.rfcProveedor=FacturasProveedor.rfcProveedor'

	EXEC sp_executesql @sentencia
END
GO