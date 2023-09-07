USE [DM_PP]
GO

/****** Object:  View [dbo].[total_entrante]    Script Date: 03/09/2023 20:03:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[total_entrante]
AS

SELECT      COD_MATERIAL, 
			MATERIAL, 
			SUM(CANTIDAD) AS SumOfCANTIDAD, 
			UNIDAD

FROM        dbo.compra_pendiente

GROUP BY	COD_MATERIAL, MATERIAL, UNIDAD

GO