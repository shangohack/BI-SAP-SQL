USE [DM_PP]
GO

/****** Object:  View [dbo].[MAESTRO_CLIENTES_VIEW]    Script Date: 02/09/2023 12:04:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[MAESTRO_CLIENTES_VIEW]
AS

SELECT      CONVERT(INT, DW.va4.KNA1.KUNNR) AS COD_CLI, 
			DW.va4.KNA1.NAME1 AS NOMBRE, 
			SUBSTRING(DW.va4.KNA1.ORT01, 7, LEN(DW.va4.KNA1.ORT01) - 6) AS POBLACION, 
			DW.va4.KNA1.STRAS AS DIRECCION, 
            DW.va4.KNA1.PSTLZ AS CP, 
			DW.va4.KNA1.TELF1 AS TELEFONO, 
			dbo.direccionescorreo.SMTP_ADDR AS Correo, 
			dbo.comisionistas.comisionista, 
			dbo.comisionistas.Nom_comisionista

FROM        DW.va4.KNKK RIGHT OUTER JOIN
				DW.va4.KNA1 LEFT OUTER JOIN
				DW.va4.KNB1 
					ON DW.va4.KNA1.KUNNR = DW.va4.KNB1.KUNNR LEFT OUTER JOIN
                DW.va4.T052U 
					ON DW.va4.KNB1.ZTERM = DW.va4.T052U.ZTERM 
					ON DW.va4.KNKK.KUNNR = DW.va4.KNA1.KUNNR LEFT OUTER JOIN
                dbo.direccionescorreo 
					ON DW.va4.KNA1.KUNNR = dbo.direccionescorreo.Cliente_Cod LEFT OUTER JOIN
                DW.va4.KNVV 
					ON DW.va4.KNA1.KUNNR = DW.va4.KNVV.KUNNR INNER JOIN
                dbo.comisionistas 
					ON DW.va4.KNA1.KUNNR = dbo.comisionistas.Cliente

GROUP BY	CONVERT(INT, DW.va4.KNA1.KUNNR), 
			DW.va4.KNA1.NAME1, DW.va4.KNA1.ORT01, DW.va4.KNA1.STRAS, DW.va4.KNA1.PSTLZ, DW.va4.KNA1.TELF1, 
			dbo.direccionescorreo.SMTP_ADDR, DW.va4.KNA1.MANDT, DW.va4.KNA1.BRSCH, DW.va4.KNB1.MANDT, 
			DW.va4.KNB1.ZTERM, DW.va4.T052U.MANDT, DW.va4.T052U.SPRAS, DW.va4.KNKK.MANDT, 
			dbo.comisionistas.comisionista, dbo.comisionistas.Nom_comisionista, DW.va4.KNA1.LAND1

HAVING      (DW.va4.KNA1.MANDT = '040') AND (DW.va4.KNA1.BRSCH >= N'0100') AND 
			(DW.va4.KNB1.MANDT = '040') AND (DW.va4.T052U.MANDT = '040') AND 
			(DW.va4.T052U.SPRAS = 'S') AND (DW.va4.KNKK.MANDT = '040') AND 
                         (dbo.comisionistas.comisionista = N'0000015170' OR
                         dbo.comisionistas.comisionista = N'0000015160' OR
                         dbo.comisionistas.comisionista = N'0000015133') AND 
			(DW.va4.KNA1.LAND1 = N'ES')
GO