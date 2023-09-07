USE [DM_PP]
GO

/****** Object:  View [dbo].[ALMACEN_VIEW]    Script Date: 03/09/2023 23:58:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[ALMACEN_VIEW]
AS

SELECT      dbo.stock.COD_MATERIAL, 
			dbo.stock.MATERIAL, 
			dbo.stock.ALMACEN, 
			dbo.stock.KgEnvase, 
			SUM(dbo.stock.STOCK) AS STOCK, 
			ISNULL(dbo.total_entrante.SumOfCANTIDAD, 0) AS PENDIENTE_ENTRAR, 
            ISNULL(CONVERT(NUMERIC(20, 2), dbo.total_saliente.SumOfCANTIDAD), 0) AS PENDIENTE_SERVIR

FROM        dbo.stock LEFT OUTER JOIN
				dbo.total_entrante 
					ON dbo.stock.COD_MATERIAL = dbo.total_entrante.COD_MATERIAL LEFT OUTER JOIN
                dbo.total_saliente 
					ON dbo.stock.COD_MATERIAL = dbo.total_saliente.COD_MATERIAL

GROUP BY	dbo.stock.COD_MATERIAL, dbo.stock.MATERIAL, dbo.stock.ALMACEN, dbo.stock.KgEnvase, 
			dbo.total_entrante.SumOfCANTIDAD, dbo.total_saliente.SumOfCANTIDAD

HAVING      (dbo.stock.ALMACEN = N'MAD')

GO