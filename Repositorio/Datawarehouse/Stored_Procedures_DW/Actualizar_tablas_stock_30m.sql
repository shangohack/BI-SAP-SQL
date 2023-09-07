USE [DW]
GO
/****** Object:  StoredProcedure [dbo].[Actualizar_tablas_stock_30m]    Script Date: 01/09/2023 15:44:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Actualizar_tablas_stock_30m]

AS

-- ****************************************************************************************************************************************************

-- DATOS Datos centro p.material
TRUNCATE TABLE [DW].[va4].[MARC]
insert into va4.MARC
	select * from [192.168.0.32].VA4.va4.MARC where MANDT='040'

-- DATOS Datos de almacén para el material
TRUNCATE TABLE [DW].[va4].[MARD]
insert into va4.MARD
	select * from [192.168.0.32].VA4.va4.MARD where MANDT='040'

-- DATOS MAESTROS MATERIALES MARM. 
TRUNCATE TABLE [DW].[va4].[MARM] 
insert into va4.MARM
	select * from [192.168.0.32].VA4.va4.MARM where MANDT='040'

-- DATOS Cabecera del documento de compras
TRUNCATE TABLE [DW].[va4].[EKKO]
insert into va4.EKKO
	select * from [192.168.0.32].VA4.va4.EKKO where MANDT='040'

-- DATOS Posición del documento de compras
TRUNCATE TABLE [DW].[va4].[EKPO]
insert into va4.EKPO
	select * from [192.168.0.32].VA4.va4.EKPO where MANDT='040'

-- DATOS MAESTROS MATERIALES MARA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[MARA] 
insert into va4.MARA
	select * from [192.168.0.32].VA4.va4.MARA where MANDT='040'

-- DATOS MAESTROS MATERIALES MAKT. 
TRUNCATE TABLE [DW].[va4].[MAKT] 
insert into va4.MAKT
	select * from [192.168.0.32].VA4.va4.MAKT where MANDT='040' AND SPRAS='S'

-- DATOS MAESTROS CLIENTES
TRUNCATE TABLE [DW].[va4].[KNA1]
insert into va4.KNA1
	select * from [192.168.0.32].VA4.va4.KNA1 where MANDT='040'

-- MOVIMIENTOS DE MATERIAL POSICIONES
TRUNCATE TABLE [DW].[va4].[MSEG]
insert into va4.MSEG
	select * from [192.168.0.32].VA4.va4.MSEG where MANDT='040' and MJAHR >= year(GETDATE())-3

-- PEDIDOS POSICIÓN. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBAP] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBAP
	select * from [192.168.0.32].VA4.va4.VBAP where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- PEDIDOS CABECERA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBAK] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBAK
	select * from [192.168.0.32].VA4.va4.VBAK where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040' and [VBTYP]='C'

-- DATOS Registro individual de necesidad de ventas
TRUNCATE TABLE [DW].[va4].[VBBE]
insert into va4.VBBE
	select * from [192.168.0.32].VA4.va4.VBBE where MANDT='040'

