CREATE DATABASE ContribucionInterbancaria
GO


USE ContribucionInterbancaria
GO

CREATE TABLE Bancos(
	idBanco INT IDENTITY(1,1) PRIMARY KEY,
	nombreBanco VARCHAR(50),
	fechaAlta DATETIME DEFAULT GETDATE(),
)
GO

insert into Bancos (nombreBanco) values 
('Banamex'), ('Bancomer'), ('Banorte')


CREATE TABLE TipoDolares(
	idTipo INT IDENTITY(1,1) PRIMARY KEY,
	tipoDolar VARCHAR(50) NOT NULL,
	fechaRegistro DATETIME DEFAULT GETDATE()
)
GO

insert into TipoDolares (tipoDolar) values
('Ventanilla'), ('Interbancario')

CREATE TABLE DolarBancos(
	idDolar INT IDENTITY(1,1) PRIMARY KEY,
	idBanco INT NOT NULL,
	idTipo INT NOT NULL,
	compraActual FLOAT NOT NULL,
	ventaActual FLOAT NOT NULL,
	compra24h FLOAT NULL,
	venta24h FLOAT NULL,
	compra48h FLOAT NULL,
	venta48h FLOAT NULL,
	fechaHora DATETIME DEFAULT GETDATE(),
	estatus BIT DEFAULT 0 NULL, -- CAMBIARA A 1 CUANDO SEA VISUALIZADO
	FOREIGN KEY (idBanco) REFERENCES Bancos(idBanco),
	FOREIGN KEY (idTipo) REFERENCES TipoDolares(idTipo)
)
GO


CREATE PROCEDURE spContribucion
	@opcion VARCHAR(50) NULL,
	@idBanco INT NULL,
	@idTipo INT NULL,
	@compraActual FLOAT,
	@ventaActual FLOAT,
	@compra24h FLOAT NULL,
	@venta24h FLOAT NULL,
	@compra48h FLOAT NULL,
	@venta48h FLOAT NULL,
	@idDolar INT NULL,
	@fechaActual DATE NULL,
	@nombreBanco VARCHAR(50) NULL
AS
BEGIN
	

	IF @opcion='SELECT'
	BEGIN
		SELECT * FROM DolarBancos
		UPDATE DolarBancos SET estatus=1 WHERE estatus=0
	END

	ELSE IF @opcion='INSERT'
	BEGIN
		IF EXISTS (SELECT * FROM Bancos WHERE idBanco=@idBanco)
		BEGIN
			IF EXISTS (SELECT * FROM TipoDolares WHERE idTipo=@idTipo)
			BEGIN
				-- Validar que ID banco exista y ID tipo
				INSERT INTO DolarBancos (idBanco,idTipo,compraActual,ventaActual,compra24h,venta24h,compra48h,venta48h)
				values (@idBanco,@idTipo,@compraActual,@ventaActual,@compra24h,@venta24h,@compra48h,@venta48h)

				SELECT TOP 1 * FROM DolarBancos order by idDolar desc
			END
			ELSE 
			BEGIN
				PRINT 'FAVOR DE COMPROBAR EL IDTIPO DEBIDO A QUE NO SE ENCONTRO NINGUN REGISTRO CON ESE ID'
			END
		END
		ELSE
		BEGIN
			PRINT 'FAVOR DE COMPROBAR EL IDBANCO DEBIDO A QUE NO SE ENCONTRO NINGUN REGISTRO CON ESE ID'
		END
	END

	ELSE IF @opcion='DELETE'
	BEGIN
		DELETE DolarBancos WHERE idDolar=@idDolar
	END

	ELSE IF @opcion='CONSULTA'
	BEGIN
		SELECT 
			(SELECT nombreBanco FROM Bancos WHERE Bancos.idBanco=DolarBancos.idBanco) 'Nombre del Banco',
			compraActual 'Dolar Compa',
			ventaActual 'Dolar Venta',
			compra24h 'Dolar Compra24h',
			venta24h 'Dolar Venta24h',
			compra48h 'Dolar Compra48h',
			venta48h 'Dolar Venta48h',
			(SELECT tipoDolar FROM TipoDolares WHERE TipoDolares.idTipo=DolarBancos.idTipo) 'Tipo de Dolar', 
			CONCAT(DAY(fechaHora),'-',MONTH(fechaHora),'-',YEAR(fechaHora),' ',CONVERT(VARCHAR(5),fechaHora,108)) 'Fecha'
		FROM 
			DolarBancos 
		WHERE 
			idBanco=(SELECT idBanco FROM Bancos WHERE nombreBanco=@nombreBanco) AND 
			estatus=0 AND CONVERT(DATE,FechaHora,103)=@fechaActual

		UPDATE DolarBancos SET estatus=1 WHERE estatus=0 AND idBanco=(SELECT idBanco FROM Bancos WHERE nombreBanco=@nombreBanco) AND 
			estatus=0 AND CONVERT(DATE,FechaHora,103)=@fechaActual

	END

	ELSE
	BEGIN 
		PRINT 'ERROR OPCION NO EXISTE'
	END


	IF EXISTS (SELECT idDolar FROM DolarBancos WHERE GETDATE()>=DATEADD(DAY,5,fechaHora))
	BEGIN
		delete from dolarBancos 
		where idDolar in (SELECT idDolar FROM DolarBancos WHERE GETDATE()>=DATEADD(DAY,5,fechaHora))
	END
	ELSE 
	BEGIN
		PRINT 'NO HAY INFORMACION QUE ELIMINAR'
	END

END


--- EJECUCION DEL PROCEDIMIENTO ALMACENADO
EXEC spContribucion @opcion='INSERT',@idBanco=1,@idTipo=1,@compraActual=16,@ventaActual=17,@compra24h=16.5,
					@venta24h=17.5,@compra48h=18,@venta48h=20,@idDolar=NULL,@fechaActual=NULL,@nombreBanco=NULL

EXEC spContribucion @opcion='SELECT',@idBanco=NULL,@idTipo=NULL,@compraActual=NULL,@ventaActual=NULL,@compra24h=NULL,
					@venta24h=NULL,@compra48h=NULL,@venta48h=NULL,	@idDolar=NULL,@fechaActual=NULL,@nombreBanco=NULL

EXEC spContribucion @opcion='DELETE',@idBanco=NULL,@idTipo=NULL,@compraActual=NULL,@ventaActual=NULL,@compra24h=NULL,
					@venta24h=NULL,@compra48h=NULL,@venta48h=NULL,	@idDolar=1,@fechaActual=NULL,@nombreBanco=NULL

EXEC spContribucion @opcion='CONSULTA',@idBanco=NULL,@idTipo=NULL,@compraActual=NULL,@ventaActual=NULL,@compra24h=NULL,
					@venta24h=NULL,@compra48h=NULL,@venta48h=NULL,	@idDolar=4,@fechaActual='2021/03/16',@nombreBanco='Banamex'

EXEC spContribucion @opcion=NULL,@idBanco=NULL,@idTipo=NULL,@compraActual=NULL,@ventaActual=NULL,@compra24h=NULL,
					@venta24h=NULL,@compra48h=NULL,@venta48h=NULL,@idDolar=4,@fechaActual=NULL,@nombreBanco=NULL


-- INSERT PARA COMPRAR EL ULTIMO REQUERIMIENTO SI LA FECHA ES MAYOR A 5 DIAS ELIMINAR REGISTRO
INSERT INTO DolarBancos 
(idBanco,idTipo,compraActual,ventaActual,compra24h,venta24h,compra48h,venta48h,fechaHora) 
VALUES (1,1,16,17,16.5,17.5,18,20,'2021-03-11')

EXEC spContribucion @opcion=NULL,@idBanco=NULL,@idTipo=NULL,@compraActual=NULL,@ventaActual=NULL,@compra24h=NULL,
@venta24h=NULL,@compra48h=NULL,@venta48h=NULL,@idDolar=4,@fechaActual=NULL,@nombreBanco=NULL