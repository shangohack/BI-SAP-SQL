USE [DW]
GO
/****** Object:  StoredProcedure [dbo].[Actualizar_DW]    Script Date: 01/09/2023 15:38:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[Actualizar_DW]

as

-- ****************************************************************************************************************************************************



-- DATOS MAESTROS DIRECCIONES ADR6
TRUNCATE TABLE [DW].[va4].[ADR6]
insert into va4.ADR6
	select * from [192.168.0.32].VA4.va4.ADR6 where CLIENT='040'

-- DATOS Cabecera del documento de compras
TRUNCATE TABLE [DW].[va4].[EKKO]
insert into va4.EKKO
	select * from [192.168.0.32].VA4.va4.EKKO where MANDT='040'

-- DATOS Posición del documento de compras
TRUNCATE TABLE [DW].[va4].[EKPO]
insert into va4.EKPO
	select * from [192.168.0.32].VA4.va4.EKPO where MANDT='040'

-- DATOS MAESTROS CLIENTES
TRUNCATE TABLE [DW].[va4].[KNA1]
insert into va4.KNA1
	select * from [192.168.0.32].VA4.va4.KNA1 where MANDT='040'

-- DATOS Maestro de clientes (sociedad)
TRUNCATE TABLE [DW].[va4].[KNB1]
insert into va4.KNB1
	select * from [192.168.0.32].VA4.va4.KNB1 where MANDT='040'

-- Gestión de créditos de clientes: datos de áreas de control KNKK
TRUNCATE TABLE [DW].[va4].[KNKK]
insert into va4.KNKK
	select * from [192.168.0.32].VA4.va4.KNKK where MANDT='040'

-- DATOS MAESTROS FUNCIONES INTERLOCUTOR COMERCIAL
TRUNCATE TABLE [DW].[va4].[KNVP]
insert into va4.KNVP
	select * from [192.168.0.32].VA4.va4.KNVP where MANDT='040'

-- DATOS MAESTROS CLIENTES DATOS COMERCIALES
TRUNCATE TABLE [DW].[va4].[KNVV]
insert into va4.KNVV
	select * from [192.168.0.32].VA4.va4.KNVV where MANDT='040'

-- TABLA DE CONDICIONES KONP
TRUNCATE TABLE [DW].[va4].[KONP]
insert into va4.KONP
	select * from [192.168.0.32].VA4.va4.KONP where MANDT='040' AND KAPPL='V' AND KSCHL='PR00'

-- DATOS MAESTROS ACREEDORES
TRUNCATE TABLE [DW].[va4].[LFA1]
insert into va4.LFA1
	select * from [192.168.0.32].VA4.va4.LFA1 where MANDT='040'

-- ENTREGAS CABECERA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[LIKP] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.LIKP
	select * from [192.168.0.32].VA4.va4.LIKP where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- ENTREGAS POSICIÓN. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[LIPS] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.LIPS
	select * from [192.168.0.32].VA4.va4.LIPS where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- DATOS MAESTROS MATERIALES MAKT. 
TRUNCATE TABLE [DW].[va4].[MAKT] 
insert into va4.MAKT
	select * from [192.168.0.32].VA4.va4.MAKT where MANDT='040' AND SPRAS='S'

-- DATOS MAESTROS MATERIALES MARA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[MARA] 
insert into va4.MARA
	select * from [192.168.0.32].VA4.va4.MARA where MANDT='040'

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

-- DATOS VALORACION MATERIALES MBEW. 
TRUNCATE TABLE [DW].[va4].[MBEW] 
insert into va4.MBEW
	select * from [192.168.0.32].VA4.va4.MBEW where MANDT='040'

-- MOVIMIENTOS DE MATERIAL POSICIONES
TRUNCATE TABLE [DW].[va4].[MSEG]
insert into va4.MSEG
	select * from [192.168.0.32].VA4.va4.MSEG where MANDT='040' and MJAHR >= year(GETDATE())-3

-- DATOS Aclaraciones propias para condiciones de pago
TRUNCATE TABLE [DW].[va4].[T052U]
insert into va4.T052U
	select * from [192.168.0.32].VA4.va4.T052U where MANDT='040'

-- PEDIDOS CABECERA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBAK] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBAK
	select * from [192.168.0.32].VA4.va4.VBAK where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040' and [VBTYP]='C'

-- PEDIDOS POSICIÓN. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBAP] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBAP
	select * from [192.168.0.32].VA4.va4.VBAP where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- DATOS Registro individual de necesidad de ventas
TRUNCATE TABLE [DW].[va4].[VBBE]
insert into va4.VBBE
	select * from [192.168.0.32].VA4.va4.VBBE where MANDT='040'

-- FACTURAS CABECERA. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBRK] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBRK
	select * from [192.168.0.32].VA4.va4.VBRK where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- FACTURAS DETALLE. Eliminamos e importamos el año en curso
DELETE FROM [DW].[va4].[VBRP] where YEAR([ERDAT]) >= year(GETDATE())-3
insert into va4.VBRP
	select * from [192.168.0.32].VA4.va4.VBRP where YEAR([ERDAT]) >= year(GETDATE())-3 AND MANDT='040'

-- ENTREGAS CABECERA ESTADO. Importamos solo los pedidos de la tabla LIKP
truncate table [DW].[va4].[VBUK]
declare 
@entrega as nvarchar(10)
SELECT  @entrega = min(va4.LIKP.VBELN) FROM  va4.LIKP
insert into va4.VBUK
select * from [192.168.0.32].VA4.va4.VBUK where [VBELN]>=@entrega

-- DATOS ????
TRUNCATE TABLE [DW].[va4].[ZA005]
insert into va4.ZA005
	select * from [192.168.0.32].VA4.va4.ZA005 where MANDT='040'

