USE [DM_PP]
GO
/****** Object:  StoredProcedure [dbo].[Actualizar_stock_30m]    Script Date: 01/09/2023 16:31:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Actualizar_stock_30m]
AS

-- ****************************************************************************************************************************************************

TRUNCATE TABLE DM_PP.dbo.ALMACEN

insert DM_PP.dbo.ALMACEN
SELECT dbo.ALMACEN_VIEW.* FROM dbo.ALMACEN 
RIGHT OUTER JOIN dbo.ALMACEN_VIEW ON dbo.ALMACEN.COD_MATERIAL = dbo.ALMACEN_VIEW.COD_MATERIAL
WHERE (dbo.ALMACEN.COD_MATERIAL IS NULL)