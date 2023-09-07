USE [DM_PP]
GO

/****** Object:  View [dbo].[albaranes_almacen]    Script Date: 02/09/2023 1:49:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[albaranes_almacen]
AS

SELECT		DW.dbo.APP_albaranes.Numero AS Entrega, 
			MAX(CONVERT(DATETIME, DW.dbo.APP_lineas.Fecha) + CONVERT(DATETIME, DW.dbo.APP_lineas.Hora)) AS Fecha, 
			DW.dbo.APP_albaranes.Cliente, 
			DW.dbo.APP_lineas.Usuario

FROM        DW.dbo.APP_albaranes LEFT OUTER JOIN
				DW.dbo.APP_lineas 
					ON DW.dbo.APP_albaranes.CampoUnico = DW.dbo.APP_lineas.CampoUnicoAlbaran AND DW.dbo.APP_albaranes.Numero = DW.dbo.APP_lineas.Albaran

GROUP BY	DW.dbo.APP_albaranes.Numero, DW.dbo.APP_albaranes.Cliente, DW.dbo.APP_lineas.Usuario

HAVING		(MAX(CONVERT(DATETIME, DW.dbo.APP_lineas.Fecha) + CONVERT(DATETIME, DW.dbo.APP_lineas.Hora)) IS NOT NULL)

GO