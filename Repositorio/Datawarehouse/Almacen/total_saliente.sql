USE [DM_PP]
GO

/****** Object:  View [dbo].[total_saliente]    Script Date: 03/09/2023 20:48:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[total_saliente]
AS

SELECT		COD_MATERIAL, 
			MATERIAL, 
			SUM(CANTIDAD) AS SumOfCANTIDAD, 
			UNIDAD

FROM            dbo.venta_pendiente

GROUP BY COD_MATERIAL, MATERIAL, UNIDAD

GO